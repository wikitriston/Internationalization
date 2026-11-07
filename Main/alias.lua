-- ======================================================================
--  Module:I18n/Alias
--  Unified, namespace-aware alias registry for WikiTriston I18n
-- ======================================================================
--
--  Copyright (c) 2026 WikiTriston
--  Released under the MIT License (see Module:I18n).
--
--  Purpose
--  -------
--  A single resolution layer shared by ISO 639, ISO 3166, ISO 15924 and
--  Unicode alias datasets, so that every dataset uses the same rules for
--  normalization, precedence, conflict detection and reverse lookup.
--
--  Key guarantees
--  --------------
--  • Aliases are never stored apart from their canonical record: every
--    namespace is (re)built by ONE loader from its source data, so the
--    forward index, reverse index and records cannot drift apart.
--  • Lazy loading: a namespace is indexed on first use only.
--  • Deterministic precedence (lower number wins, see KIND_PRIORITY).
--    Equal-priority aliases that point to different canonicals are marked
--    AMBIGUOUS and resolve to nil (never silently picked).
--  • Every conflict is recorded, reported through the 'conflict' callback
--    and returned by Alias.validate(). Strict namespaces raise errors.
--  • Recursion guards on loading, providers and callback dispatch.
--  • Pure Lua 5.1 / Scribunto; works without `mw` for offline tests.
--
--  Events (Alias.on(event, fn))
--  ------
--    load       (ns, stats)                 namespace finished indexing
--    register   (ns, alias, canonical, kind) new alias entered the index
--    conflict   (ns, conflict)               two canonicals claim one alias
--    resolve    (ns, input, canonical, kind) successful lookup
--    invalidate (ns)                         namespace caches dropped
-- ======================================================================

local Alias = {}

-- ============================================================
-- 0. Constants
-- ============================================================

--- Lower number = higher precedence.
local KIND_PRIORITY = {
	canonical   = 0, -- the canonical identifier itself
	official    = 1, -- alternative official code (Alpha-3, numeric, 639-2/B…)
	name        = 2, -- official / reference name
	deprecated  = 3, -- deprecated but officially documented identifier
	historical  = 3, -- withdrawn / historical identifier
	translation = 4, -- localized name taken from a /tran module
	project     = 5, -- project-defined alias (not from a standard)
}
Alias.KIND_PRIORITY = KIND_PRIORITY

--- Default namespace providers: namespace → module that defines it.
--  A prefix entry ending in ':' matches every namespace with that prefix.
local PROVIDERS = {
	['iso3166']   = 'Module:I18n/ISO 3166',
	['iso639']    = 'Module:I18n/ISO 639',
	['iso15924']  = 'Module:I18n/ISO 15924',
	['unicode:']  = 'Module:I18n/Unicode',
}

-- ============================================================
-- 1. String helpers (mw-optional)
-- ============================================================

local function trim(s)
	if mw and mw.text and mw.text.trim then return mw.text.trim(s) end
	return (s:gsub('^%s+', ''):gsub('%s+$', ''))
end

local function ulower(s)
	if mw and mw.ustring and mw.ustring.lower then return mw.ustring.lower(s) end
	return string.lower(s)
end

local normalizers = {}

--- Case-insensitive, trimmed, inner whitespace collapsed.
function normalizers.default(s)
	return ulower((trim(s):gsub('%s+', ' ')))
end

--- Unicode loose matching, UAX #44 LM3: ignore case, whitespace,
--  underscores, hyphens and an initial "is" prefix.
function normalizers.uax44(s)
	local k = ulower(s):gsub('[%s_%-]', '')
	if #k > 2 and k:sub(1, 2) == 'is' then k = k:sub(3) end
	return k
end

Alias.normalizers = normalizers

-- ============================================================
-- 2. State
-- ============================================================

local spaces    = {}  -- ns → space
local listeners = { load = {}, register = {}, conflict = {}, resolve = {}, invalidate = {} }
local firing    = {}  -- event → true while dispatching (re-entrancy guard)
local providing = {}  -- ns → true while its provider module is loading
local errors    = {}  -- callback errors (never thrown into page output)

local function newSpace(ns, opts)
	return {
		name      = ns,
		loader    = opts.loader,
		normalize = opts.normalize or normalizers.default,
		strict    = opts.strict and true or false,
		state     = 'empty',   -- 'empty' | 'loading' | 'ready'
		records   = {},
		index     = {},        -- key → entry
		reverse   = nil,       -- lazily built canonical → { aliases }
		conflicts = {},
		nAliases  = 0,
		nRecords  = 0,
		generation = 0,
	}
end

-- ============================================================
-- 3. Callbacks
-- ============================================================

function Alias.on(event, fn)
	local list = listeners[event]
	if not list then error('Alias.on: unknown event "' .. tostring(event) .. '"') end
	if type(fn) ~= 'function' then error('Alias.on: callback must be a function') end
	for _, f in ipairs(list) do
		if f == fn then return fn end -- de-duplicate
	end
	list[#list + 1] = fn
	return fn
end

function Alias.off(event, fn)
	local list = listeners[event]
	if not list then return false end
	for i, f in ipairs(list) do
		if f == fn then table.remove(list, i); return true end
	end
	return false
end

local function fire(event, ...)
	local list = listeners[event]
	if #list == 0 or firing[event] then return end
	firing[event] = true
	for _, fn in ipairs(list) do
		local ok, err = pcall(fn, ...)
		if not ok then errors[#errors + 1] = { event = event, error = tostring(err) } end
	end
	firing[event] = nil
end

function Alias.getErrors() return errors end

-- ============================================================
-- 4. Namespace definition & loading
-- ============================================================

--- Define (or redefine) a namespace.
--  opts.loader(api)  builds the namespace; api = { addRecord, register }
--  opts.normalize    key normalizer (default: normalizers.default)
--  opts.strict       raise errors on conflicts instead of only recording
function Alias.define(ns, opts)
	if type(ns) ~= 'string' or ns == '' then error('Alias.define: invalid namespace') end
	opts = opts or {}
	if type(opts.loader) ~= 'function' then error('Alias.define: loader function required for "' .. ns .. '"') end
	local old = spaces[ns]
	if old and old.loader == opts.loader then return old end -- idempotent
	if old and old.state == 'loading' then error('Alias.define: cannot redefine "' .. ns .. '" while it is loading') end
	spaces[ns] = newSpace(ns, opts)
	if old then fire('invalidate', ns) end
	return spaces[ns]
end

function Alias.has(ns) return spaces[ns] ~= nil end

local function providerFor(ns)
	if PROVIDERS[ns] then return PROVIDERS[ns] end
	for prefix, mod in pairs(PROVIDERS) do
		if prefix:sub(-1) == ':' and ns:sub(1, #prefix) == prefix then return mod end
	end
	return nil
end

--- Register an additional provider (namespace or 'prefix:' → module).
function Alias.setProvider(ns, moduleName) PROVIDERS[ns] = moduleName end

local register, addRecord -- forward declarations

local function getSpace(ns)
	local space = spaces[ns]
	if not space then
		local mod = providerFor(ns)
		if mod and not providing[ns] then
			providing[ns] = true
			local ok, err = pcall(require, mod)
			providing[ns] = nil
			if not ok then error('Alias: provider "' .. mod .. '" failed for "' .. ns .. '": ' .. tostring(err)) end
			space = spaces[ns]
		end
		if not space then error('Alias: unknown namespace "' .. tostring(ns) .. '"') end
	end

	if space.state == 'ready' then return space end
	if space.state == 'loading' then
		error('Alias: recursive load of namespace "' .. ns .. '"')
	end

	space.state = 'loading'
	local api = {
		addRecord = function(canonical, record) return addRecord(space, canonical, record) end,
		register  = function(alias, canonical, kind) return register(space, alias, canonical, kind) end,
	}
	local ok, err = pcall(space.loader, api)
	if not ok then
		local fresh = newSpace(ns, space)
		spaces[ns] = fresh
		error('Alias: loader for "' .. ns .. '" failed: ' .. tostring(err))
	end
	space.state = 'ready'
	space.generation = space.generation + 1
	fire('load', ns, { records = space.nRecords, aliases = space.nAliases, conflicts = #space.conflicts })
	return space
end

-- ============================================================
-- 5. Registration (only callable from inside a loader)
-- ============================================================

local function recordConflict(space, c)
	space.conflicts[#space.conflicts + 1] = c
	fire('conflict', space.name, c)
	if space.strict and c.resolution ~= 'kept' and c.resolution ~= 'replaced' then
		error(string.format('Alias[%s]: %s conflict for "%s" (%s vs %s)',
			space.name, c.resolution, tostring(c.alias), tostring(c.existing), tostring(c.incoming)))
	end
end

addRecord = function(space, canonical, record)
	if type(canonical) ~= 'string' or canonical == '' then
		error('Alias[' .. space.name .. ']: invalid canonical identifier')
	end
	if space.records[canonical] ~= nil then
		recordConflict(space, { type = 'duplicate-record', alias = canonical,
			existing = canonical, incoming = canonical, resolution = 'duplicate' })
		return false
	end
	space.records[canonical] = record or true
	space.nRecords = space.nRecords + 1
	register(space, canonical, canonical, 'canonical')
	return true
end

register = function(space, alias, canonical, kind)
	if space.state ~= 'loading' then
		error('Alias[' .. space.name .. ']: aliases may only be registered by the namespace loader')
	end
	if type(alias) == 'number' then alias = tostring(alias) end
	if type(alias) ~= 'string' or type(canonical) ~= 'string' then return false end
	local prio = KIND_PRIORITY[kind]
	if not prio then error('Alias[' .. space.name .. ']: unknown alias kind "' .. tostring(kind) .. '"') end

	local key = space.normalize(alias)
	if key == '' then return false end

	local cur = space.index[key]
	if not cur then
		space.index[key] = { canonical = canonical, kind = kind, priority = prio, alias = alias }
		space.nAliases = space.nAliases + 1
		space.reverse = nil
		fire('register', space.name, alias, canonical, kind)
		return true
	end

	if cur.canonical == canonical and not cur.ambiguous then
		if prio < cur.priority then cur.kind, cur.priority = kind, prio end
		return true
	end

	-- Different canonical (or entry already ambiguous) → conflict
	local c = { type = 'alias', alias = alias, key = key,
		existing = cur.canonical, existingKind = cur.kind,
		incoming = canonical, incomingKind = kind }

	if prio < cur.priority then
		space.index[key] = { canonical = canonical, kind = kind, priority = prio, alias = alias }
		c.resolution = 'replaced'
	elseif prio > cur.priority then
		c.resolution = 'kept'
	else
		if not cur.ambiguous then
			cur.ambiguous  = true
			cur.candidates = { cur.canonical }
		end
		local seen = false
		for _, cand in ipairs(cur.candidates) do if cand == canonical then seen = true end end
		if seen then return true end
		cur.candidates[#cur.candidates + 1] = canonical
		c.resolution = 'ambiguous'
	end
	space.reverse = nil
	recordConflict(space, c)
	return false
end

-- ============================================================
-- 6. Lookup API
-- ============================================================

--- Resolve an alias to its canonical identifier.
--  @return canonical, kind                     on success
--  @return nil, { ambiguous=true, candidates } when ambiguous
--  @return nil                                 when unknown
function Alias.resolve(ns, input)
	if input == nil then return nil end
	if type(input) == 'number' then input = tostring(input) end
	if type(input) ~= 'string' then return nil end
	local space = getSpace(ns)
	local entry = space.index[space.normalize(input)]
	if not entry then return nil end
	if entry.ambiguous then
		local cands = {}
		for i, v in ipairs(entry.candidates) do cands[i] = v end
		return nil, { ambiguous = true, candidates = cands }
	end
	fire('resolve', ns, input, entry.canonical, entry.kind)
	return entry.canonical, entry.kind
end

--- Resolve and return the canonical record.
function Alias.getRecord(ns, input)
	local canonical, info = Alias.resolve(ns, input)
	if not canonical then return nil, nil, info end
	return spaces[ns].records[canonical], canonical
end

--- Try several namespaces in the given (deterministic) order.
--  @return ns, canonical, kind   for the first unambiguous hit
--  @return nil, nil, ambiguities otherwise
function Alias.resolveIn(nsList, input)
	local ambiguities = {}
	for _, ns in ipairs(nsList) do
		local canonical, info = Alias.resolve(ns, input)
		if canonical then return ns, canonical, info end
		if type(info) == 'table' and info.ambiguous then
			ambiguities[#ambiguities + 1] = { namespace = ns, candidates = info.candidates }
		end
	end
	return nil, nil, (#ambiguities > 0) and ambiguities or nil
end

--- Reverse lookup: every alias that resolves (unambiguously) to `canonical`.
--  @return array of { alias, kind } sorted by precedence then text
function Alias.getAliases(ns, canonical)
	local space = getSpace(ns)
	if not space.reverse then
		local rev = {}
		for _, e in pairs(space.index) do
			if not e.ambiguous then
				local list = rev[e.canonical]
				if not list then list = {}; rev[e.canonical] = list end
				list[#list + 1] = { alias = e.alias, kind = e.kind, priority = e.priority }
			end
		end
		for _, list in pairs(rev) do
			table.sort(list, function(a, b)
				if a.priority ~= b.priority then return a.priority < b.priority end
				return a.alias < b.alias
			end)
		end
		space.reverse = rev
	end
	return space.reverse[canonical] or {}
end

--- Sorted list of canonical identifiers in a namespace.
function Alias.getCanonicals(ns)
	local space = getSpace(ns)
	local list = {}
	for k in pairs(space.records) do list[#list + 1] = k end
	table.sort(list)
	return list
end

-- ============================================================
-- 7. Validation, statistics, invalidation
-- ============================================================

--- Integrity report for a namespace.
--  report.ok is false when ambiguous aliases, dangling aliases or duplicate
--  records exist. Precedence-resolved ('kept'/'replaced') conflicts are
--  listed for review but do not fail validation.
function Alias.validate(ns)
	local space = getSpace(ns)
	local report = {
		namespace = ns, records = space.nRecords, aliases = space.nAliases,
		conflicts = {}, ambiguous = {}, dangling = {}, duplicates = {},
	}
	for i, c in ipairs(space.conflicts) do
		report.conflicts[i] = c
		if c.type == 'duplicate-record' then report.duplicates[#report.duplicates + 1] = c.alias end
	end
	for key, e in pairs(space.index) do
		if e.ambiguous then
			report.ambiguous[#report.ambiguous + 1] = { key = key, candidates = e.candidates }
		elseif space.records[e.canonical] == nil then
			report.dangling[#report.dangling + 1] = { key = key, canonical = e.canonical }
		end
	end
	table.sort(report.ambiguous, function(a, b) return a.key < b.key end)
	table.sort(report.dangling,  function(a, b) return a.key < b.key end)
	report.ok = #report.ambiguous == 0 and #report.dangling == 0 and #report.duplicates == 0
	return report
end

function Alias.stats(ns)
	local space = getSpace(ns)
	return { records = space.nRecords, aliases = space.nAliases,
		conflicts = #space.conflicts, generation = space.generation }
end

--- Drop caches for one namespace (or all, when ns is nil).
--  The namespace is rebuilt from its loader on next access.
function Alias.invalidate(ns)
	local names = {}
	if ns then names[1] = ns else for k in pairs(spaces) do names[#names + 1] = k end end
	for _, name in ipairs(names) do
		local space = spaces[name]
		if space then
			if space.state == 'loading' then error('Alias.invalidate: "' .. name .. '" is loading') end
			local gen = space.generation
			spaces[name] = newSpace(name, space)
			spaces[name].generation = gen
			fire('invalidate', name)
		end
	end
end

return Alias
