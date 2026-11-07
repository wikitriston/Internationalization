--  ============================================================
--  Module:I18n/Unicode
--  Tra cứu & phân giải bí danh thuộc tính, giá trị và khối mã Unicode
--
--  Nguồn dữ liệu:
--    · Module:I18n/Unicode/data (nạp qua mw.loadData hoặc require)
--      theo chuẩn Unicode Character Database (UAX #44 / UAX #24)
--
--  Tách biệt không gian tên (Namespace isolation trên Module:I18n/Alias):
--    · unicode:property        'Script', 'sc', 'General_Category' → tên ngắn
--    · unicode:value:<prop>    ví dụ unicode:value:gc  'Letter' → 'L'
--                              (nhờ tách theo <prop>, 'L' của gc='Letter'
--                               không bao giờ xung đột với 'L' của bc='Left_To_Right')
--
--  Quy tắc chuẩn hóa: UAX #44 LM3 (bỏ qua hoa/thường, khoảng trắng, '_',
--  '-' và tiền tố 'is').
--
--  Cách dùng:
--    local U = require('Module:I18n/Unicode')
--    U.resolveProperty('General Category')    --> 'gc', 'official'
--    U.resolveValue('Script', 'Latin')        --> 'Latn', 'official'
--    U.resolveValue('sc', 'Qaai')             --> 'Zinh', 'deprecated'
--    U.resolveValue('gc', 'uppercase-letter') --> 'Lu', 'official'
--    U.resolveValue('White_Space', 'true')    --> 'Y', 'official'
--    U.getBlock('ASCII')                      --> { first='0000', last='007F', ... }
--  ============================================================

local M = {}

local Alias = require('Module:I18n/Alias')
local uax44 = Alias.normalizers.uax44

local function loadUnicodeData()
	if mw and mw.loadData then
		local ok, d = pcall(mw.loadData, 'Module:I18n/Unicode/data')
		if ok and type(d) == 'table' then return d end
	end
	local ok, d = pcall(require, 'Module:I18n/Unicode/data')
	if ok and type(d) == 'table' then return d end
	return {}
end

local data       = loadUnicodeData()
local properties = data.properties or {}
local values     = data.values or {}
local blocks     = data.blocks or {}

local PROP_NS = 'unicode:property'
local function valueNs(short) return 'unicode:value:' .. short end

--- Đăng ký một tập bí danh chuẩn Unicode (canonical short, long, numeric,
--  aliases chính thức và deprecated).
local function registerSet(api, entry)
	local canonical = entry.short
	api.addRecord(canonical, entry)
	if entry.long and entry.long ~= canonical then
		api.register(entry.long, canonical, 'official')
	end
	if entry.numeric then
		api.register(entry.numeric, canonical, 'official')
	end
	if entry.aliases then
		for _, a in ipairs(entry.aliases) do
			api.register(a, canonical, 'official')
		end
	end
	if entry.deprecated then
		for _, a in ipairs(entry.deprecated) do
			api.register(a, canonical, 'deprecated')
		end
	end
end

-- 1. Không gian tên thuộc tính Unicode
Alias.define(PROP_NS, {
	normalize = uax44,
	loader = function(api)
		for i = 1, #properties do
			registerSet(api, properties[i])
		end
	end,
})

-- 2. Không gian tên cho từng tập giá trị thuộc tính
for prop, list in pairs(values) do
	Alias.define(valueNs(prop), {
		normalize = uax44,
		loader = function(api)
			for i = 1, #list do
				registerSet(api, list[i])
			end
		end,
	})
end

--- Xác định tập giá trị tương ứng của một thuộc tính đã phân giải:
--  · scx (Script_Extensions) dùng chung bảng mã chữ viết với sc (Script)
--  · Các thuộc tính nhị phân (type == 'binary') dùng chung tập giá trị 'binary'
local function valueSpaceFor(propShort)
	if not propShort then return nil end
	if values[propShort] then return valueNs(propShort) end
	if propShort == 'scx' and values.sc then return valueNs('sc') end
	local rec = Alias.getRecord(PROP_NS, propShort)
	if rec and rec.type == 'binary' and values.binary then
		return valueNs('binary')
	end
	return nil
end

-- ============================================================
-- Public API
-- ============================================================

--- Phân giải tên thuộc tính sang mã ngắn chuẩn ('sc', 'gc', 'WSpace'…).
--  @return short, kind | nil, info
function M.resolveProperty(name)
	return Alias.resolve(PROP_NS, name)
end

--- Phân giải giá trị thuộc tính sang mã ngắn chuẩn (hỗ trợ mọi alias của thuộc tính).
--  @return short, kind | nil, info
function M.resolveValue(property, value)
	local prop = M.resolveProperty(property)
	local ns   = valueSpaceFor(prop)
	if not ns then return nil end
	return Alias.resolve(ns, value)
end

--- Trả về bản ghi đầy đủ của một thuộc tính hoặc giá trị thuộc tính.
function M.getProperty(name)
	return (Alias.getRecord(PROP_NS, name))
end

function M.getValue(property, value)
	local prop = M.resolveProperty(property)
	local ns   = valueSpaceFor(prop)
	if not ns then return nil end
	return (Alias.getRecord(ns, value))
end

--- Tra ngược toàn bộ bí danh của một thuộc tính hoặc giá trị thuộc tính.
function M.getPropertyAliases(name)
	local prop = M.resolveProperty(name)
	return prop and Alias.getAliases(PROP_NS, prop) or {}
end

function M.getValueAliases(property, value)
	local prop = M.resolveProperty(property)
	local ns   = valueSpaceFor(prop)
	if not ns then return {} end
	local val = Alias.resolve(ns, value)
	return val and Alias.getAliases(ns, val) or {}
end

--- Tra cứu thông tin dải khối mã (Blocks.txt) bằng bất kỳ tên/alias khối nào.
function M.getBlock(name)
	if not name then return nil end
	local short = M.resolveValue('blk', name)
	local rec   = short and M.getValue('blk', short)
	local targetShort = short and uax44(short) or nil
	local targetName  = uax44(rec and rec.long or tostring(name))

	for i = 1, #blocks do
		local b = blocks[i]
		if (targetShort and b.short and uax44(b.short) == targetShort)
			or uax44(b.name) == targetName
		then
			return b
		end
	end
	return nil
end

--- Báo cáo kiểm tra toàn vẹn cho không gian thuộc tính hoặc một thuộc tính cụ thể.
function M.validate(property)
	if property then
		local prop = M.resolveProperty(property)
		local ns   = valueSpaceFor(prop)
		if not ns then return nil end
		return Alias.validate(ns)
	end
	return Alias.validate(PROP_NS)
end

function M.getMeta()
	return data._meta
end

return M
