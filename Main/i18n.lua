-- ======================================================================
--                _-o#&&*''''?d:>b\_
--           _o/"`''  '',, dMF9MMMMMHo_
--        .o&#'        `"MbHMMMMMMMMMMMHo.
--      .o"" '         vodM*$&&HMMMMMMMMMM?.
--     ,'              $M&ood,~'`(&##MMMMMMH\
--    /               ,MMMMMMM#b?#bobMMMMHMMML
--   &              ?MMMMMMMMMMMMMMMMM7MMM$R*Hk
--  ?$.            :MMMMMMMMMMMMMMMMMMM/HMMM|`*L     /$$$$$$   /$$    /$$$$$$           
-- |               |MMMMMMMMMMMMMMMMMMMMbMH'   T,   |_  $$_/ /$$$$   /$$__  $$          
-- $H#:            `*MMMMMMMMMMMMMMMMMMMMb#}'  `?     | $$  |_  $$  | $$  \ $$ /$$$$$$$ 
-- ]MMH#             ""*""""*#MMMMMMMMMMMMM'    -     | $$    | $$  |  $$$$$$/| $$__  $$
-- MMMMMb_                   |MMMMMMMMMMMP'     :     | $$    | $$   >$$__  $$| $$  \ $$
-- HMMMMMMMHo                 `MMMMMMMMMT       .     | $$    | $$  | $$  \ $$| $$  | $$
-- ?MMMMMMMMP                  9MMMMMMMM}       -    /$$$$$$ /$$$$$$|  $$$$$$/| $$  | $$
-- -?MMMMMMM                  |MMMMMMMMM?,d-    '   |______/|______/ \______/ |__/  |__/         
--  :|MMMMMM-                 `MMMMMMMT .M|.   :   
--   .9MMM[                    &MMMMM*' `'    .
--    :9MMk                    `MMM#"        -
--      &M}                     `          .-
--       `&.                             .
--         `~,   .                     ./
--             . _                  .-
--               '`--._,dd###pp=""'
-- ======================================================================
--  I18n Library
--  Powered by WikiTriston
-- ======================================================================
--
--  Copyright (c) 2026 WikiTriston
--  Released under the MIT License.
--
--  Permission is hereby granted, free of charge, to any person obtaining a
--  copy of this software and associated documentation files (the "Software"),
--  to deal in the Software without restriction, including without limitation
--  the rights to use, copy, modify, merge, publish, distribute, sublicense,
--  and/or sell copies of the Software, and to permit persons to whom the
--  Software is furnished to do so, subject to the following conditions:
--
--  The above copyright notice and this permission notice shall be included in
--  all copies or substantial portions of the Software.
--
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
--  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
--  DEALINGS IN THE SOFTWARE.
--
-- ======================================================================
--
--  A lightweight internationalization (i18n) library for Scribunto Lua.
--
--  This module provides a unified datastore API for loading, retrieving,
--  and managing localized messages while keeping translations completely
--  separate from module and template logic.
--
--  Features
--  --------
--  • Layered language fallback chains
--      vi → en
--      zh → zh-hans → zh-hant → en
--      pt-br → pt → en
--
--  • Smart source resolution
--      Supports short names, module paths, and Commons JsonConfig (.tab)
--      without additional configuration.
--
--  • Stateless datastore execution
--      Every lookup executes independently, preventing temporary language
--      or source selections from affecting subsequent calls.
--
--  • Flexible message formatting
--      - Numbered placeholders ($1, $2, ...)
--      - Named placeholders ($name)
--      - qqx debug mode
--      - Automatic wikitext preprocessing
--
--  • Helper closures
--      Generates compact message getter functions for individual modules,
--      reducing repetitive boilerplate code.
--
--  • Automatic datastore normalization
--      Accepts both of the following layouts:
--
--          { [lang] = { [key] = value } }
--
--      and
--
--          { [key] = { [lang] = value } }
--
--  • ISO integration
--      Built-in localized lookup for:
--      - ISO 3166 country names
--      - ISO 639 language names
--      - ISO 15924 script names
--
--  • Unified alias resolution
--      All ISO / Unicode datasets share Module:I18n/Alias (namespace-aware
--      forward & reverse lookup, deterministic precedence, conflict
--      detection and load/register/conflict/resolve/invalidate callbacks).
--
--  Design Goals
--  ------------
--  • DRY (Don't Repeat Yourself)
--  • Stateless execution
--  • High compatibility with Wikimedia Scribunto
--  • Lua-first architecture
--  • Commons JsonConfig support
--  • Predictable fallback behavior
--  • Minimal runtime overhead
--
--  This library is intended to serve as the shared internationalization
--  foundation for WikiTriston and other MediaWiki-based Lua projects.
--
-- ======================================================================

local i18n, _i18n = {}, {}

-- ============================================================
-- 0. Constants & Fallback table
-- ============================================================

local FALLBACKS = {
	['vi']      = {'en'},
	['zh']      = {'zh-hans', 'zh-hant', 'en'},
	['zh-hans'] = {'zh', 'en'},
	['zh-hant'] = {'zh', 'en'},
	['pt-br']   = {'pt', 'en'},
	['pt-pt']   = {'pt', 'en'},
	['nb']      = {'no', 'en'},
	['nn']      = {'no', 'en'},
	['sr-ec']   = {'sr', 'en'},
	['sr-el']   = {'sr', 'en'},
}

-- ============================================================
-- 1. Internal utilities (_i18n)
-- ============================================================

function _i18n.checkFallback(messages, lang, key)
	local val = (messages[lang] or {})[key]
	if val ~= nil then return val end

	local fbList = FALLBACKS[lang]
	if fbList then
		for _, fl in ipairs(fbList) do
			val = (messages[fl] or {})[key]
			if val ~= nil then return val end
		end
	end

	return (messages['en'] or {})[key]
end

function _i18n.resolveLang(args)
	args = args or {}
	local code = args.lang or args.uselang

	if not code or code == '' then
		local frame = mw.getCurrentFrame and mw.getCurrentFrame()
		if frame and frame.preprocess then
			local ok, res = pcall(frame.preprocess, frame, '{{int:lang}}')
			if ok and res then
				res = mw.text.decode(res):gsub('[%⧼⧽<>]', '')
				if #res > 0 and #res < 10 and res ~= 'lang' and res ~= 'qqx' then
					code = res
				end
			end
		end
	end

	return code
		or (mw.language and mw.language.getContentLanguage and mw.language.getContentLanguage():getCode())
		or 'en'
end

function _i18n.isValidCode(code)
	return type(code) == 'string'
		and mw.language
		and #mw.language.fetchLanguageName(code) ~= 0
end

function _i18n.isWikitext(msg)
	return type(msg) == 'string' and (
		msg:find('%-%-%-%-')                          or
		msg:find('%f[^\n%z][;:*#] ')                 or
		msg:find('%f[^\n%z]==* *[^\n|]+ =*=%f[\n]')  or
		msg:find('%b<>')                              or
		msg:find("''")                                or
		msg:find('%[%b[]%]')                          or
		msg:find('{%b{}}')
	)
end

function _i18n.handleArgs(msg, args)
	if type(args) ~= 'table' then return msg end
	for k, v in pairs(args) do
		if type(k) == 'number' then
			msg = msg:gsub('%%$' .. k, tostring(v))
		elseif type(k) == 'string' and k ~= 'lang' and k ~= 'uselang' then
			msg = msg:gsub('%%$' .. k, tostring(v))
		end
	end
	return msg
end

-- ============================================================
-- 2. Data Store Class (Stateless Execution)
-- ============================================================

local Data = {}
Data.__index = Data

function Data:msg(opts, ...)
	if not opts then error('Data:msg – missing arguments') end

	local key  = type(opts) == 'table' and opts.key  or opts
	local args = type(opts) == 'table' and opts.args or {...}

	local runLang    = self.defaultLang
	local runSources = self._sources

	if type(opts) == 'table' then
		if opts.lang and _i18n.isValidCode(opts.lang) then
			runLang = opts.lang
		end
		if type(opts.sources) == 'table' then
			runSources = {}
			for _, srcName in ipairs(opts.sources) do
				if type(srcName) == 'string' and type(self._sources[srcName]) == 'number' then
					runSources[srcName] = self._sources[srcName]
				end
			end
		end
	end

	local idxSet = {}
	for name, idx in pairs(runSources) do idxSet[idx] = name end

	if runLang == 'qqx' then
		return '⧼' .. mw.text.nowiki(tostring(key)) .. '⧽'
	end

	for idx = 1, #self._messages do
		if idxSet[idx] then
			local messages = self._messages[idx]
			local val = _i18n.checkFallback(messages, runLang, key)

			if val ~= nil then
				local msg = tostring(val)

				if next(args) ~= nil then
					msg = _i18n.handleArgs(msg, args)
				end

				local frame = mw.getCurrentFrame and mw.getCurrentFrame()
				if frame and _i18n.isWikitext(msg) then
					return frame:preprocess(mw.text.trim(msg))
				end
				return mw.text.trim(msg)
			end
		end
	end

	return '⧼' .. mw.text.nowiki(tostring(key)) .. '⧽'
end

function Data:parameter(key, templateArgs, targetLang)
	if not key or not templateArgs then error('Data:parameter – missing arguments') end
	local lang = targetLang or mw.language.getContentLanguage():getCode()
	for _, messages in ipairs(self._messages) do
		local val = _i18n.checkFallback(messages, lang, key)
		if val ~= nil and templateArgs[val] ~= nil then
			return templateArgs[val]
		end
	end
	return nil
end

function Data:getLang()       return self.defaultLang end

function Data:useUserLang()
	self.defaultLang = _i18n.resolveLang(); return self
end
function Data:useContentLang()
	self.defaultLang = mw.language.getContentLanguage():getCode(); return self
end
function Data:useLang(code)
	if _i18n.isValidCode(code) then self.defaultLang = code end; return self
end

-- ============================================================
-- 3. Load data sources (Smart Path + JsonConfig Tab)
-- ============================================================

--- Normalize module name:
--   "Foo"          → "Module:Foo/i18n"
--   "Foo/bar"      → "Module:Foo/bar"
--   "Module:Foo"   → "Module:Foo"
local function resolveModuleName(source)
	-- [FIX] ucfirst via ustring.sub avoids gsub+function (invalid capture index on Lua 5.1)
	local function ucfirst(s)
		if not s or s == '' then return s end
		return mw.ustring.upper(mw.ustring.sub(s, 1, 1)) .. mw.ustring.sub(s, 2)
	end

	if mw.ustring.find(source, ':') then
		local ns, rest = source:match('^([^:]+):(.+)$')
		if ns and rest then return ns .. ':' .. ucfirst(rest) end
		return source
	elseif mw.ustring.find(source, '/') then
		return 'Module:' .. ucfirst(source)
	else
		return 'Module:' .. ucfirst(source) .. '/i18n'
	end
end

--- Convert raw table into { [lang][key] = value }
--  Supports structure A { [lang][key] } and B { [key][lang] }
local function normalizeMessages(raw)
	local out = {}
	local isInverted = false

	for k1, v1 in pairs(raw) do
		if type(v1) == 'table' and k1 ~= 'qqq' then
			local firstSubKey
			for subK in pairs(v1) do firstSubKey = subK; break end

			if firstSubKey and _i18n.isValidCode(firstSubKey) and not _i18n.isValidCode(k1) then
				isInverted = true
			end
			break
		end
	end

	for k1, v1 in pairs(raw) do
		if type(v1) == 'table' then
			if not isInverted then
				if k1 ~= 'qqq' then
					out[k1] = out[k1] or {}
					for key, val in pairs(v1) do out[k1][key] = val end
				end
			else
				for lang, val in pairs(v1) do
					out[lang] = out[lang] or {}
					out[lang][k1] = val
				end
			end
		end
	end

	return out
end

function i18n.loadMessages(...)
	local ds
	local sources = {}
	local idx = 0

	for j = 1, select('#', ...) do
		local source = select(j, ...)
		if type(source) == 'string' and source ~= '' then
			idx = idx + 1
			sources[source] = idx

			if not ds then
				ds = setmetatable({ _messages = {}, _sources = {} }, Data)
				ds:useUserLang()
			end

			local modName = resolveModuleName(source)
			local ok, raw = pcall(mw.loadData, modName)
			if ok and type(raw) == 'table' then
				ds._messages[idx] = normalizeMessages(raw)
			end

			local tabName = mw.ustring.find(source, '%.tab$')
				and source
				or ('I18n/' .. source .. '.tab')

			local tabOk, tabRaw = pcall(function()
				return mw.ext and mw.ext.data and mw.ext.data.get(tabName, '_')
			end)

			if tabOk and type(tabRaw) == 'table' and tabRaw.data then
				local T = {}
				for _, row in ipairs(tabRaw.data) do
					local key, translations = row[1], row[2]
					if key and type(translations) == 'table' then
						for lang, val in pairs(translations) do
							T[lang] = T[lang] or {}
							T[lang][key] = val
						end
					end
				end
				if ds._messages[idx] then
					for lang, msgTbl in pairs(T) do
						ds._messages[idx][lang] = ds._messages[idx][lang] or {}
						for k, v in pairs(msgTbl) do
							if ds._messages[idx][lang][k] == nil then
								ds._messages[idx][lang][k] = v
							end
						end
					end
				else
					ds._messages[idx] = T
				end
			end

			if not ds._messages[idx] then
				if os then
					error('i18n: no data found for source "' .. source .. '"')
				end
				ds._messages[idx] = {}
			end
		end
	end

	if not ds then
		error('i18n.loadMessages: no valid sources were passed')
	end
	ds._sources = sources
	return ds
end

-- ============================================================
-- 4. Helper closure  –  i18n.getHelper()
-- ============================================================

function i18n.getHelper(config)
	local source, options

	if type(config) == 'table' then
		options = config
		source  = options.source or error('getHelper: missing options.source')
		if options.subpage and not mw.ustring.find(source, '/') then
			source = source .. '/' .. options.subpage
		end
	else
		source  = config or error('getHelper: missing source parameter')
		options = {}
	end

	local ds = i18n.loadMessages(source)
	if options.lang and _i18n.isValidCode(options.lang) then
		ds:useLang(options.lang)
	end

	return function(key, ...)
		if type(key) == 'table' then
			key.lang = _i18n.resolveLang(key)
			return ds:msg(key)
		end

		local msgOpts = { key = key }
		local first   = select(1, ...)

		if type(first) == 'table' then
			msgOpts.args = first
			msgOpts.lang = _i18n.resolveLang(first)
		else
			msgOpts.args = {...}
			msgOpts.lang = _i18n.resolveLang(options)
		end

		return ds:msg(msgOpts)
	end
end

-- ============================================================
-- 5. Public utility API
-- ============================================================

--- {{#invoke:I18n|getMsg|source|key|arg1|arg2|lang=vi}}
function i18n.getMsg(frame)
	local a = frame.args
	if not a or not a[1] or not a[2] then
		error('i18n.getMsg: requires at least 2 arguments (source, key)')
	end
	local source = a[1]
	local key    = a[2]
	local args   = {}
	for i, v in ipairs(a) do
		if i >= 3 then args[i - 2] = v end
	end

	local ds = i18n.loadMessages(source)
	-- [FIX] Pass lang via msg() opts — ds:inLang() removed in stateless refactor
	return ds:msg({ key = key, args = args, lang = _i18n.resolveLang(a) })
end

function i18n.getLang(args)
	return _i18n.resolveLang(args)
end

-- ============================================================
-- 6. ISO 3166 integration
-- ============================================================

function i18n.getCountryName(code, args)
	local targetLang = _i18n.resolveLang(args)
	local ok, iso3166 = pcall(require, 'Module:I18n/ISO 3166')
	if ok and type(iso3166) == 'table' and iso3166.getName then
		return iso3166.getName(code, targetLang, FALLBACKS)
	end
	return code
end

-- ============================================================
-- 7. ISO 639 integration
-- ============================================================

function i18n.getLanguageName(code, args)
	local targetLang = _i18n.resolveLang(args)
	local ok, iso639 = pcall(require, 'Module:I18n/ISO 639')
	if ok and type(iso639) == 'table' and iso639.getName then
		return iso639.getName(code, targetLang, FALLBACKS)
	end
	return code
end

-- ============================================================
-- 7a. ISO 15924 integration
-- ============================================================

function i18n.getScriptName(code, args)
	local targetLang = _i18n.resolveLang(args)
	local ok, iso15924 = pcall(require, 'Module:I18n/ISO 15924')
	if ok and type(iso15924) == 'table' and iso15924.getName then
		return iso15924.getName(code, targetLang, FALLBACKS)
	end
	return code
end

-- ============================================================
-- 7b. Unified alias resolution (Module:I18n/Alias)
-- ============================================================

--- Resolve an alias in a namespace ('iso3166', 'iso639', 'iso15924',
--  'unicode:property', 'unicode:value:<prop>').
--  @return canonical, kind | nil, info  (info.ambiguous when ambiguous)
function i18n.resolveAlias(namespace, input)
	local ok, Alias = pcall(require, 'Module:I18n/Alias')
	if not ok or type(Alias) ~= 'table' then return nil end
	local ok2, canonical, info = pcall(Alias.resolve, namespace, input)
	if not ok2 then return nil end
	return canonical, info
end

--- {{#invoke:I18n|alias|iso3166|Viet Nam}}  → VN  (empty string if unknown)
function i18n.alias(frame)
	local a = frame.args
	if not a or not a[1] or not a[2] then
		error('i18n.alias: requires 2 arguments (namespace, alias)')
	end
	return i18n.resolveAlias(mw.text.trim(a[1]), a[2]) or ''
end

-- ============================================================
-- 8. Template entry point
-- ============================================================

function i18n.main(frame)
	local fn = frame.args.activate or 'getMsg'
	if i18n[fn] then return i18n[fn](frame) end
	return i18n.getMsg(frame)
end

i18n._FALLBACKS   = FALLBACKS
i18n._resolveLang = _i18n.resolveLang

return i18n
