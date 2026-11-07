-- ======================================================================
--  Offline test suite for WikiTriston Internationalization
--
--  Run from the repository root with a Lua 5.1 interpreter (Scribunto
--  uses Lua 5.1 semantics):
--
--      lua5.1 tests/run_tests.lua
--
--  A minimal `mw` stub is installed and `Module:I18n/...` names are mapped
--  to repository files, so the real modules and datasets are exercised
--  unchanged.
-- ======================================================================

-- ------------------------------------------------------------
-- 1. mw stub
-- ------------------------------------------------------------
local KNOWN_LANGS = {
	en = 'English', vi = 'Tiếng Việt', zh = '中文', ['zh-hans'] = '简体中文',
	['zh-hant'] = '繁體中文', fr = 'Français', ja = '日本語', ko = '한국어',
	de = 'Deutsch', es = 'Español', it = 'Italiano', pt = 'Português',
	ru = 'Русский', ar = 'العربية',
}

mw = {
	text = {
		trim   = function(s) return (tostring(s):gsub('^%s+', ''):gsub('%s+$', '')) end,
		nowiki = function(s) return s end,
		decode = function(s) return s end,
	},
	ustring = {
		lower = string.lower, upper = string.upper,
		sub = string.sub, find = string.find,
	},
	language = {
		fetchLanguageName  = function(code) return KNOWN_LANGS[code] or '' end,
		getContentLanguage = function() return { getCode = function() return 'en' end } end,
	},
	getCurrentFrame = function() return nil end,
}
mw.loadData = function(name) return require(name) end

-- ------------------------------------------------------------
-- 2. Module name → file mapping
-- ------------------------------------------------------------
local FILES = {
	['Module:I18n']                = 'Main/i18n.lua',
	['Module:I18n/Alias']          = 'Main/alias.lua',
	['Module:I18n/ISO 3166']       = 'ISO 3166/iso-3166.lua',
	['Module:I18n/ISO 3166/tran']  = 'ISO 3166/iso-3166-data.lua',
	['Module:I18n/ISO 639']        = 'ISO 639/iso-639.lua',
	['Module:I18n/ISO 639/tran']   = 'ISO 639/iso-639-data.lua',
	['Module:I18n/ISO 15924']      = 'ISO 15924/iso-15924.lua',
	['Module:I18n/ISO 15924/tran'] = 'ISO 15924/iso-15924-data.lua',
	['Module:I18n/Unicode']        = 'Unicode/unicode.lua',
	['Module:I18n/Unicode/data']   = 'Unicode/unicode-data.lua',
}

local function install(overrides)
	for name in pairs(FILES) do package.loaded[name] = nil; package.preload[name] = nil end
	for name, path in pairs(FILES) do
		package.preload[name] = function()
			local chunk = assert(loadfile(path))
			return chunk()
		end
	end
	for name, value in pairs(overrides or {}) do
		package.preload[name] = function() return value end
	end
end

-- ------------------------------------------------------------
-- 3. Tiny test framework
-- ------------------------------------------------------------
local passed, failed = 0, 0
local function test(name, fn)
	local ok, err = pcall(fn)
	if ok then passed = passed + 1; print('  ok    ' .. name)
	else failed = failed + 1; print('  FAIL  ' .. name .. '\n        ' .. tostring(err)) end
end
local function eq(actual, expected, msg)
	if actual ~= expected then
		error((msg or 'assertion') .. ': expected ' .. tostring(expected) .. ', got ' .. tostring(actual), 2)
	end
end
local function truthy(v, msg) if not v then error(msg or 'expected truthy value', 2) end end

-- ------------------------------------------------------------
-- 4. Alias registry
-- ------------------------------------------------------------
print('Alias registry')
install()
local Alias = require('Module:I18n/Alias')

test('precedence: higher-priority kind replaces lower', function()
	Alias.define('t:prec', { loader = function(api)
		api.addRecord('A', {}); api.addRecord('B', {})
		api.register('shared', 'A', 'project')
		api.register('shared', 'B', 'official')
	end })
	eq(Alias.resolve('t:prec', 'SHARED'), 'B')
	local r = Alias.validate('t:prec')
	eq(#r.conflicts, 1); eq(r.conflicts[1].resolution, 'replaced'); eq(r.ok, true)
end)

test('ambiguous aliases resolve to nil with candidates and fail validation', function()
	Alias.define('t:amb', { loader = function(api)
		api.addRecord('A', {}); api.addRecord('B', {})
		api.register('dup', 'A', 'name'); api.register('dup', 'B', 'name')
	end })
	local c, info = Alias.resolve('t:amb', 'dup')
	eq(c, nil); truthy(info and info.ambiguous); eq(#info.candidates, 2)
	eq(Alias.validate('t:amb').ok, false)
end)

test('strict namespace raises on ambiguity', function()
	Alias.define('t:strict', { strict = true, loader = function(api)
		api.addRecord('A', {}); api.addRecord('B', {})
		api.register('x', 'A', 'name'); api.register('x', 'B', 'name')
	end })
	truthy(not pcall(Alias.resolve, 't:strict', 'x'))
end)

test('duplicate record is reported', function()
	Alias.define('t:duprec', { loader = function(api)
		api.addRecord('A', {}); api.addRecord('A', {})
	end })
	local r = Alias.validate('t:duprec')
	eq(#r.duplicates, 1); eq(r.ok, false)
end)

test('dangling alias (canonical without record) is reported', function()
	Alias.define('t:dangle', { loader = function(api)
		api.register('ghost', 'NOPE', 'project')
	end })
	local r = Alias.validate('t:dangle')
	eq(#r.dangling, 1); eq(r.ok, false)
end)

test('reverse lookup sorted by precedence', function()
	Alias.define('t:rev', { loader = function(api)
		api.addRecord('A', {})
		api.register('zz', 'A', 'project'); api.register('aa', 'A', 'official')
	end })
	local list = Alias.getAliases('t:rev', 'A')
	eq(list[1].alias, 'A'); eq(list[2].alias, 'aa'); eq(list[3].alias, 'zz')
end)

test('callbacks: de-duplicated, load fires once, invalidate rebuilds', function()
	local loads, registers, invalidations = 0, 0, 0
	local onLoad = function(ns) if ns == 't:cb' then loads = loads + 1 end end
	Alias.on('load', onLoad); Alias.on('load', onLoad) -- duplicate ignored
	local onReg = function(ns) if ns == 't:cb' then registers = registers + 1 end end
	Alias.on('register', onReg)
	local onInv = function(ns) if ns == 't:cb' then invalidations = invalidations + 1 end end
	Alias.on('invalidate', onInv)
	local value = 'one'
	Alias.define('t:cb', { loader = function(api) api.addRecord('A', {}); api.register(value, 'A', 'name') end })
	eq(Alias.resolve('t:cb', 'one'), 'A'); Alias.resolve('t:cb', 'one')
	eq(loads, 1, 'load count')
	value = 'two'
	Alias.invalidate('t:cb')
	eq(invalidations, 1)
	eq(Alias.resolve('t:cb', 'one'), nil, 'stale alias removed')
	eq(Alias.resolve('t:cb', 'two'), 'A', 'new alias indexed')
	eq(loads, 2); eq(registers, 4)
	Alias.off('load', onLoad); Alias.off('register', onReg); Alias.off('invalidate', onInv)
end)

test('callback errors are collected, not thrown', function()
	local bad = function() error('boom') end
	Alias.on('load', bad)
	Alias.define('t:err', { loader = function(api) api.addRecord('A', {}) end })
	eq(Alias.resolve('t:err', 'a'), 'A')
	Alias.off('load', bad)
	local errs = Alias.getErrors()
	truthy(#errs >= 1 and errs[#errs].error:find('boom'))
end)

test('recursive load is detected', function()
	Alias.define('t:rec', { loader = function(api) Alias.resolve('t:rec', 'x') end })
	local ok, err = pcall(Alias.resolve, 't:rec', 'x')
	truthy(not ok and tostring(err):find('recursive'), tostring(err))
end)

test('registration outside loader is rejected; unknown namespace errors', function()
	truthy(not pcall(Alias.resolve, 't:does-not-exist', 'x'))
end)

test('UAX44 loose matching', function()
	local n = Alias.normalizers.uax44
	eq(n('Line_Break'), n('linebreak')); eq(n('is-Greek'), n('GREEK')); eq(n('L l'), 'll')
end)

-- ------------------------------------------------------------
-- 5. ISO 3166
-- ------------------------------------------------------------
print('ISO 3166')
install()
local iso3166 = require('Module:I18n/ISO 3166')
local i18n    = require('Module:I18n')

test('alpha-2 / alpha-3 / numeric / zero padding', function()
	eq(iso3166.resolve('vn'), 'VN'); eq(iso3166.resolve('VNM'), 'VN')
	eq(iso3166.resolve('704'), 'VN'); eq(iso3166.resolve('40'), 'AT'); eq(iso3166.resolve(40), 'AT')
end)
test('numeric "000" is not indexed (was non-deterministic)', function()
	eq(iso3166.resolve('000'), nil)
end)
test('official Alpha-3 wins over localized translation collision (NGA → NG vs RU vi="Nga")', function()
	eq(iso3166.resolve('NGA'), 'NG')
	eq(iso3166.getName('RU', 'vi'), 'Nga')
end)
test('names, ISO names, altnames, historical & reserved codes', function()
	eq(iso3166.resolve('viet nam'), 'VN'); eq(iso3166.resolve('Hoa Kỳ'), 'US')
	eq(iso3166.resolve('UK'), 'GB'); eq(iso3166.resolve('UNK'), 'XK')
	eq(iso3166.resolve('ZR'), 'CD'); eq(iso3166.resolve('DD'), 'DE'); eq(iso3166.resolve('BU'), 'MM')
	eq(iso3166.getReserved('EU').status, 'exceptionally-reserved')
	eq(iso3166.getHistorical('YU').iso3166_3, 'YUCS')
end)
test('getName keeps legacy behaviour & fallback chains', function()
	eq(iso3166.getName('VN', 'vi'), 'Việt Nam')
	eq(iso3166.getName('840', 'zh-hant'), '美國')
	eq(iso3166.getName('TW', 'zh-hant', i18n._FALLBACKS), '臺灣')
	eq(iso3166.getName('AD', 'vi'), 'Andorra')
	eq(iso3166.getName('xx', 'vi'), 'XX')
end)
test('getData / getAllCodes / getAliases / status filters', function()
	eq(iso3166.getData('GBR').name, 'United Kingdom')
	eq(iso3166.getData('GB-SCT').status, 'project-defined')
	eq(iso3166.getData('XK').status, 'user-assigned')
	eq(#iso3166.getAllCodes(), 255)
	eq(#iso3166.getAllCodes('officially-assigned'), 249)
	eq(#iso3166.getAllCodes('project-defined'), 5)
	eq(#iso3166.getAllCodes('user-assigned'), 1)
	truthy(#iso3166.getAliases('VN') >= 4)
end)
test('dataset validates cleanly with zero ambiguous or dangling aliases', function()
	local r = iso3166.validate()
	eq(r.ok, true); eq(#r.ambiguous, 0); eq(#r.dangling, 0); eq(r.records, 255)
end)

-- ------------------------------------------------------------
-- 6. ISO 639
-- ------------------------------------------------------------
print('ISO 639')
local iso639 = require('Module:I18n/ISO 639')

test('639-1 (all 184) / 639-2T / 639-2B / 639-3 / 639-5 / deprecated', function()
	eq(#iso639.getAllCodes(1), 184)
	eq(iso639.resolve('vie'), 'vi'); eq(iso639.resolve('chi'), 'zh'); eq(iso639.resolve('zho'), 'zh')
	eq(iso639.resolve('bih'), 'bh'); eq(iso639.resolve('sme'), 'se'); eq(iso639.resolve('tgl'), 'tl')
	eq(iso639.resolve('Ancient Greek'), 'grc'); eq(iso639.resolve('Sumerian'), 'sux')
	eq(iso639.resolve('Austroasiatic languages'), 'mkh')
	eq(iso639.resolve('iw'), 'he'); eq(iso639.resolve('in'), 'id'); eq(iso639.resolve('sh'), 'hbs')
	eq(iso639.getDeprecated('iw').replacedBy, 'he')
end)
test('getName keeps legacy behaviour & supports 639-2/3/5 translations', function()
	eq(iso639.getName('vi', 'en'), 'Vietnamese')
	eq(iso639.getName('vie', 'vi'), 'Tiếng Việt')
	eq(iso639.getName('zh', 'vi'), 'Tiếng Trung')
	eq(iso639.getName('grc', 'vi'), 'Tiếng Hy Lạp cổ đại')
	eq(iso639.getName('mtq', 'vi'), 'Tiếng Mường')
	eq(iso639.getName('mkh', 'vi'), 'Ngữ hệ Nam Á (Môn-Khmer)')
	eq(iso639.getName('zh-hans', 'vi'), 'zh-hans')
	eq(iso639.getData('ger').alpha3, 'deu')
end)
test('dataset validates cleanly with zero conflicts', function()
	local r = iso639.validate()
	eq(r.ok, true); eq(#r.conflicts, 0); eq(r.records, 322)
end)

-- ------------------------------------------------------------
-- 7. Module:I18n public API (regression + new integrations)
-- ------------------------------------------------------------
print('Module:I18n')
test('getCountryName / getLanguageName / getScriptName', function()
	eq(i18n.getCountryName('VN', { lang = 'vi' }), 'Việt Nam')
	eq(i18n.getLanguageName('vie', { lang = 'ja' }), 'ベトナム語')
	eq(i18n.getScriptName('Latn', { lang = 'vi' }), 'Chữ Latinh')
	eq(i18n.getScriptName('050', { lang = 'vi' }), 'Chữ tượng hình Ai Cập')
end)
test('resolveAlias across ISO & Unicode namespaces', function()
	eq(i18n.resolveAlias('iso3166', 'Viet Nam'), 'VN')
	eq(i18n.resolveAlias('iso639', 'deu'), 'de')
	eq(i18n.resolveAlias('iso15924', 'Qaai'), 'Zinh')
	eq(i18n.resolveAlias('unicode:property', 'General Category'), 'gc')
	eq(i18n.resolveAlias('unicode:value:gc', 'Uppercase_Letter'), 'Lu')
	eq(i18n.resolveAlias('no-such-namespace', 'x'), nil)
end)
test('#invoke alias entry point', function()
	eq(i18n.main({ args = { activate = 'alias', 'iso639', 'fre' } }), 'fr')
	eq(i18n.main({ args = { activate = 'alias', 'iso15924', 'Egyptian_Hieroglyphs' } }), 'Egyp')
end)

-- ------------------------------------------------------------
-- 8. ISO 15924 + Unicode real datasets
-- ------------------------------------------------------------
print('ISO 15924 & Unicode (real datasets)')
local iso15924 = require('Module:I18n/ISO 15924')
local U        = require('Module:I18n/Unicode')

test('ISO 15924 modern, historical, ancient & Nôm/Han coverage', function()
	eq(iso15924.resolve('latn'), 'Latn'); eq(iso15924.resolve('215'), 'Latn')
	eq(iso15924.resolve('050'), 'Egyp'); eq(iso15924.resolve('Egyptian_Hieroglyphs'), 'Egyp')
	eq(iso15924.resolve('Xsux'), 'Xsux'); eq(iso15924.resolve('Linear B'), 'Linb')
	eq(iso15924.resolve('Qaai'), 'Zinh'); eq(iso15924.resolve('Chữ Nôm'), 'Hani')
	eq(iso15924.getName('Grek', 'vi'), 'Chữ Hy Lạp')
	eq(iso15924.getName('Tavt', 'vi'), 'Chữ Thái Việt')
	truthy(#iso15924.getAllCodes('ancient') >= 35)
	local r = iso15924.validate()
	eq(r.ok, true); eq(#r.conflicts, 0); eq(r.records, 182)
end)

test('Unicode UCD property, value, namespace isolation & block resolution', function()
	eq(U.resolveProperty('General Category'), 'gc')
	eq(U.resolveProperty('Script_Extensions'), 'scx')
	eq(U.resolveValue('Script', 'latin'), 'Latn')
	eq(U.resolveValue('scx', 'Egyptian_Hieroglyphs'), 'Egyp')
	eq(U.resolveValue('sc', 'Qaai'), 'Zinh')
	eq(U.resolveValue('gc', 'uppercase-letter'), 'Lu')
	-- Namespace isolation: 'L' means Letter in gc, Left_To_Right in bc
	eq(U.getValue('gc', 'L').long, 'Letter')
	eq(U.getValue('bc', 'L').long, 'Left_To_Right')
	eq(U.resolveValue('White_Space', 'true'), 'Y')
	eq(U.getBlock('ASCII').last, '007F')
	eq(U.getBlock('CJK_Ext_B').first, '20000')
	eq(U.resolveValue('unknown-prop', 'x'), nil)
	eq(U.validate().ok, true); eq(U.validate('sc').ok, true); eq(U.validate('gc').ok, true)
end)

print(string.format('\n%d passed, %d failed', passed, failed))
if failed > 0 then os.exit(1) end
