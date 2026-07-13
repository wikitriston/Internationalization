--  ============================================================
--  Module:I18n/ISO 639
--  Tra tên ngôn ngữ theo mã ISO 639-1 (Alpha-2) hoặc ISO 639-2/3 (Alpha-3)
--
--  Quy tắc DRY:
--    · baseData  = nguồn sự thật duy nhất (tên tiếng Anh + metadata)
--    · /tran     = chỉ chứa bản dịch, KHÔNG lặp lại tên tiếng Anh
--    · Alpha-3   = tra qua reverseAlpha3 (build tự động, không bảng thứ hai)
--    · Fallback  = nhận từ Module:I18n, không định nghĩa lại
--
--  Cách dùng:
--    local iso639 = require('Module:I18n/ISO 639')
--    iso639.getName('vi', 'en')    --> "Vietnamese"
--    iso639.getName('vie', 'vi')   --> "Tiếng Việt"
--    iso639.getName('zh', 'vi')    --> "Tiếng Trung"
--  ============================================================

local M = {}

-- ============================================================
-- 1. Base Data  –  tên gốc tiếng Anh + metadata
--    alpha2  : mã ISO 639-1 (nếu có)
--    alpha3  : mã ISO 639-2/T hoặc ISO 639-3
--    alpha3B : mã ISO 639-2/B (bibliographic, nếu khác T)
--    scope   : 'I'=individual, 'M'=macrolanguage, 'S'=special
--    type    : 'L'=living, 'H'=historical, 'C'=constructed, 'A'=ancient
--    name    : tên tiếng Anh chuẩn
--    altnames: tên thay thế / tên cũ
-- ============================================================
local baseData = {
	-- A
	['ab'] = {alpha3='abk',                  name='Abkhazian',       scope='I', type='L'},
	['aa'] = {alpha3='aar',                  name='Afar',            scope='I', type='L'},
	['af'] = {alpha3='afr',                  name='Afrikaans',       scope='I', type='L'},
	['ak'] = {alpha3='aka',                  name='Akan',            scope='M', type='L'},
	['sq'] = {alpha3='sqi', alpha3B='alb',   name='Albanian',        scope='M', type='L'},
	['am'] = {alpha3='amh',                  name='Amharic',         scope='I', type='L'},
	['ar'] = {alpha3='ara',                  name='Arabic',          scope='M', type='L'},
	['an'] = {alpha3='arg',                  name='Aragonese',       scope='I', type='L'},
	['hy'] = {alpha3='hye', alpha3B='arm',   name='Armenian',        scope='I', type='L'},
	['as'] = {alpha3='asm',                  name='Assamese',        scope='I', type='L'},
	['av'] = {alpha3='ava',                  name='Avaric',          scope='I', type='L'},
	['ae'] = {alpha3='ave',                  name='Avestan',         scope='I', type='A'},
	['ay'] = {alpha3='aym',                  name='Aymara',          scope='M', type='L'},
	['az'] = {alpha3='aze',                  name='Azerbaijani',     scope='M', type='L', altnames={'Azeri'}},

	-- B
	['ba'] = {alpha3='bak',                  name='Bashkir',         scope='I', type='L'},
	['bm'] = {alpha3='bam',                  name='Bambara',         scope='I', type='L'},
	['eu'] = {alpha3='eus', alpha3B='baq',   name='Basque',          scope='I', type='L'},
	['be'] = {alpha3='bel',                  name='Belarusian',      scope='I', type='L'},
	['bn'] = {alpha3='ben',                  name='Bengali',         scope='I', type='L', altnames={'Bangla'}},
	['bi'] = {alpha3='bis',                  name='Bislama',         scope='I', type='L'},
	['bs'] = {alpha3='bos',                  name='Bosnian',         scope='I', type='L'},
	['br'] = {alpha3='bre',                  name='Breton',          scope='I', type='L'},
	['bg'] = {alpha3='bul',                  name='Bulgarian',       scope='I', type='L'},
	['my'] = {alpha3='mya', alpha3B='bur',   name='Burmese',         scope='I', type='L', altnames={'Myanmar'}},

	-- C
	['ca'] = {alpha3='cat',                  name='Catalan',         scope='I', type='L', altnames={'Valencian'}},
	['ch'] = {alpha3='cha',                  name='Chamorro',        scope='I', type='L'},
	['ce'] = {alpha3='che',                  name='Chechen',         scope='I', type='L'},
	['ny'] = {alpha3='nya',                  name='Chichewa',        scope='I', type='L', altnames={'Chewa','Nyanja'}},
	['zh'] = {alpha3='zho', alpha3B='chi',   name='Chinese',         scope='M', type='L'},
	['cu'] = {alpha3='chu',                  name='Church Slavic',   scope='I', type='H', altnames={'Old Church Slavonic','Old Bulgarian','Old Slavonic'}},
	['cv'] = {alpha3='chv',                  name='Chuvash',         scope='I', type='L'},
	['kw'] = {alpha3='cor',                  name='Cornish',         scope='I', type='L'},
	['co'] = {alpha3='cos',                  name='Corsican',        scope='I', type='L'},
	['cr'] = {alpha3='cre',                  name='Cree',            scope='M', type='L'},
	['hr'] = {alpha3='hrv',                  name='Croatian',        scope='I', type='L'},
	['cs'] = {alpha3='ces', alpha3B='cze',   name='Czech',           scope='I', type='L'},

	-- D
	['da'] = {alpha3='dan',                  name='Danish',          scope='I', type='L'},
	['dv'] = {alpha3='div',                  name='Divehi',          scope='I', type='L', altnames={'Dhivehi','Maldivian'}},
	['nl'] = {alpha3='nld', alpha3B='dut',   name='Dutch',           scope='I', type='L', altnames={'Flemish'}},
	['dz'] = {alpha3='dzo',                  name='Dzongkha',        scope='I', type='L'},

	-- E
	['en'] = {alpha3='eng',                  name='English',         scope='I', type='L'},
	['eo'] = {alpha3='epo',                  name='Esperanto',       scope='I', type='C'},
	['et'] = {alpha3='est',                  name='Estonian',        scope='M', type='L'},
	['ee'] = {alpha3='ewe',                  name='Ewe',             scope='I', type='L'},

	-- F
	['fo'] = {alpha3='fao',                  name='Faroese',         scope='I', type='L'},
	['fj'] = {alpha3='fij',                  name='Fijian',          scope='I', type='L'},
	['fi'] = {alpha3='fin',                  name='Finnish',         scope='I', type='L'},
	['fr'] = {alpha3='fra', alpha3B='fre',   name='French',          scope='I', type='L'},
	['fy'] = {alpha3='fry',                  name='Western Frisian', scope='I', type='L'},

	-- G
	['ff'] = {alpha3='ful',                  name='Fula',            scope='M', type='L', altnames={'Fulah','Pulaar','Pular'}},
	['gd'] = {alpha3='gla',                  name='Scottish Gaelic', scope='I', type='L', altnames={'Gaelic'}},
	['gl'] = {alpha3='glg',                  name='Galician',        scope='I', type='L'},
	['lg'] = {alpha3='lug',                  name='Ganda',           scope='I', type='L'},
	['ka'] = {alpha3='kat', alpha3B='geo',   name='Georgian',        scope='I', type='L'},
	['de'] = {alpha3='deu', alpha3B='ger',   name='German',          scope='I', type='L'},
	['el'] = {alpha3='ell', alpha3B='gre',   name='Greek, Modern',   scope='I', type='L', altnames={'Greek'}},
	['kl'] = {alpha3='kal',                  name='Kalaallisut',     scope='I', type='L', altnames={'Greenlandic'}},
	['gn'] = {alpha3='grn',                  name='Guaraní',         scope='M', type='L'},
	['gu'] = {alpha3='guj',                  name='Gujarati',        scope='I', type='L'},
	['ht'] = {alpha3='hat',                  name='Haitian Creole',  scope='I', type='L'},
	['ha'] = {alpha3='hau',                  name='Hausa',           scope='I', type='L'},
	['he'] = {alpha3='heb',                  name='Hebrew',          scope='I', type='L'},
	['hz'] = {alpha3='her',                  name='Herero',          scope='I', type='L'},
	['hi'] = {alpha3='hin',                  name='Hindi',           scope='I', type='L'},
	['ho'] = {alpha3='hmo',                  name='Hiri Motu',       scope='I', type='L'},
	['hu'] = {alpha3='hun',                  name='Hungarian',       scope='I', type='L'},

	-- I
	['ia'] = {alpha3='ina',                  name='Interlingua',     scope='I', type='C'},
	['id'] = {alpha3='ind',                  name='Indonesian',      scope='I', type='L'},
	['ie'] = {alpha3='ile',                  name='Interlingue',     scope='I', type='C'},
	['ga'] = {alpha3='gle',                  name='Irish',           scope='I', type='L'},
	['ig'] = {alpha3='ibo',                  name='Igbo',            scope='I', type='L'},
	['ik'] = {alpha3='ipk',                  name='Inupiaq',         scope='M', type='L'},
	['io'] = {alpha3='ido',                  name='Ido',             scope='I', type='C'},
	['is'] = {alpha3='isl', alpha3B='ice',   name='Icelandic',       scope='I', type='L'},
	['it'] = {alpha3='ita',                  name='Italian',         scope='I', type='L'},
	['iu'] = {alpha3='iku',                  name='Inuktitut',       scope='M', type='L'},

	-- J
	['ja'] = {alpha3='jpn',                  name='Japanese',        scope='I', type='L'},
	['jv'] = {alpha3='jav',                  name='Javanese',        scope='I', type='L'},

	-- K
	['kn'] = {alpha3='kan',                  name='Kannada',         scope='I', type='L'},
	['kr'] = {alpha3='kau',                  name='Kanuri',          scope='M', type='L'},
	['ks'] = {alpha3='kas',                  name='Kashmiri',        scope='I', type='L'},
	['kk'] = {alpha3='kaz',                  name='Kazakh',          scope='I', type='L'},
	['km'] = {alpha3='khm',                  name='Khmer',           scope='I', type='L', altnames={'Central Khmer','Cambodian'}},
	['ki'] = {alpha3='kik',                  name='Kikuyu',          scope='I', type='L', altnames={'Gikuyu'}},
	['rw'] = {alpha3='kin',                  name='Kinyarwanda',     scope='I', type='L'},
	['ky'] = {alpha3='kir',                  name='Kyrgyz',          scope='I', type='L', altnames={'Kirghiz'}},
	['kv'] = {alpha3='kom',                  name='Komi',            scope='M', type='L'},
	['kg'] = {alpha3='kon',                  name='Kongo',           scope='M', type='L'},
	['ko'] = {alpha3='kor',                  name='Korean',          scope='I', type='L'},
	['ku'] = {alpha3='kur',                  name='Kurdish',         scope='M', type='L'},
	['kj'] = {alpha3='kua',                  name='Kwanyama',        scope='I', type='L'},

	-- L
	['lo'] = {alpha3='lao',                  name='Lao',             scope='I', type='L'},
	['la'] = {alpha3='lat',                  name='Latin',           scope='I', type='A'},
	['lv'] = {alpha3='lav',                  name='Latvian',         scope='M', type='L'},
	['li'] = {alpha3='lim',                  name='Limburgish',      scope='I', type='L'},
	['ln'] = {alpha3='lin',                  name='Lingala',         scope='I', type='L'},
	['lt'] = {alpha3='lit',                  name='Lithuanian',      scope='I', type='L'},
	['lu'] = {alpha3='lub',                  name='Luba-Katanga',    scope='I', type='L'},
	['lb'] = {alpha3='ltz',                  name='Luxembourgish',   scope='I', type='L'},

	-- M
	['mk'] = {alpha3='mkd', alpha3B='mac',   name='Macedonian',      scope='I', type='L'},
	['mg'] = {alpha3='mlg',                  name='Malagasy',        scope='M', type='L'},
	['ms'] = {alpha3='msa', alpha3B='may',   name='Malay',           scope='M', type='L'},
	['ml'] = {alpha3='mal',                  name='Malayalam',       scope='I', type='L'},
	['mt'] = {alpha3='mlt',                  name='Maltese',         scope='I', type='L'},
	['gv'] = {alpha3='glv',                  name='Manx',            scope='I', type='L'},
	['mi'] = {alpha3='mri', alpha3B='mao',   name='Māori',           scope='I', type='L', altnames={'Maori'}},
	['mr'] = {alpha3='mar',                  name='Marathi',         scope='I', type='L'},
	['mh'] = {alpha3='mah',                  name='Marshallese',     scope='I', type='L'},
	['mn'] = {alpha3='mon',                  name='Mongolian',       scope='M', type='L'},

	-- N
	['na'] = {alpha3='nau',                  name='Nauru',           scope='I', type='L'},
	['nv'] = {alpha3='nav',                  name='Navajo',          scope='I', type='L', altnames={'Navaho'}},
	['nd'] = {alpha3='nde',                  name='North Ndebele',   scope='I', type='L'},
	['ne'] = {alpha3='nep',                  name='Nepali',          scope='M', type='L'},
	['ng'] = {alpha3='ndo',                  name='Ndonga',          scope='I', type='L'},
	['nb'] = {alpha3='nob',                  name='Norwegian Bokmål',scope='I', type='L'},
	['nn'] = {alpha3='nno',                  name='Norwegian Nynorsk',scope='I',type='L'},
	['no'] = {alpha3='nor',                  name='Norwegian',       scope='M', type='L'},
	['ii'] = {alpha3='iii',                  name='Nuosu',           scope='I', type='L', altnames={'Sichuan Yi'}},
	['nr'] = {alpha3='nbl',                  name='South Ndebele',   scope='I', type='L'},
	['oc'] = {alpha3='oci',                  name='Occitan',         scope='I', type='L'},
	['oj'] = {alpha3='oji',                  name='Ojibwe',          scope='M', type='L', altnames={'Ojibwa'}},

	-- O P Q
	['or'] = {alpha3='ori',                  name='Odia',            scope='M', type='L', altnames={'Oriya'}},
	['om'] = {alpha3='orm',                  name='Oromo',           scope='M', type='L'},
	['os'] = {alpha3='oss',                  name='Ossetian',        scope='I', type='L'},
	['pi'] = {alpha3='pli',                  name='Pāli',            scope='I', type='A'},
	['pa'] = {alpha3='pan',                  name='Punjabi',         scope='I', type='L', altnames={'Panjabi'}},
	['ps'] = {alpha3='pus',                  name='Pashto',          scope='M', type='L', altnames={'Pushto'}},
	['fa'] = {alpha3='fas', alpha3B='per',   name='Persian',         scope='M', type='L', altnames={'Farsi'}},
	['pl'] = {alpha3='pol',                  name='Polish',          scope='I', type='L'},
	['pt'] = {alpha3='por',                  name='Portuguese',      scope='I', type='L'},

	-- R
	['qu'] = {alpha3='que',                  name='Quechua',         scope='M', type='L'},
	['ro'] = {alpha3='ron', alpha3B='rum',   name='Romanian',        scope='I', type='L', altnames={'Moldavian','Moldovan'}},
	['rm'] = {alpha3='roh',                  name='Romansh',         scope='I', type='L'},
	['rn'] = {alpha3='run',                  name='Rundi',           scope='I', type='L'},
	['ru'] = {alpha3='rus',                  name='Russian',         scope='I', type='L'},

	-- S
	['sm'] = {alpha3='smo',                  name='Samoan',          scope='I', type='L'},
	['sg'] = {alpha3='sag',                  name='Sango',           scope='I', type='L'},
	['sa'] = {alpha3='san',                  name='Sanskrit',        scope='I', type='A'},
	['sc'] = {alpha3='srd',                  name='Sardinian',       scope='M', type='L'},
	['sr'] = {alpha3='srp',                  name='Serbian',         scope='I', type='L'},
	['sn'] = {alpha3='sna',                  name='Shona',           scope='I', type='L'},
	['sd'] = {alpha3='snd',                  name='Sindhi',          scope='M', type='L'},
	['si'] = {alpha3='sin',                  name='Sinhala',         scope='I', type='L', altnames={'Sinhalese'}},
	['sk'] = {alpha3='slk', alpha3B='slo',   name='Slovak',          scope='I', type='L'},
	['sl'] = {alpha3='slv',                  name='Slovenian',       scope='I', type='L'},
	['so'] = {alpha3='som',                  name='Somali',          scope='I', type='L'},
	['st'] = {alpha3='sot',                  name='Southern Sotho',  scope='I', type='L'},
	['es'] = {alpha3='spa',                  name='Spanish',         scope='I', type='L', altnames={'Castilian'}},
	['su'] = {alpha3='sun',                  name='Sundanese',       scope='I', type='L'},
	['sw'] = {alpha3='swa',                  name='Swahili',         scope='M', type='L'},
	['ss'] = {alpha3='ssw',                  name='Swati',           scope='I', type='L'},
	['sv'] = {alpha3='swe',                  name='Swedish',         scope='I', type='L'},

	-- T
	['ty'] = {alpha3='tah',                  name='Tahitian',        scope='I', type='L'},
	['tg'] = {alpha3='tgk',                  name='Tajik',           scope='I', type='L'},
	['ta'] = {alpha3='tam',                  name='Tamil',           scope='I', type='L'},
	['tt'] = {alpha3='tat',                  name='Tatar',           scope='I', type='L'},
	['te'] = {alpha3='tel',                  name='Telugu',          scope='I', type='L'},
	['th'] = {alpha3='tha',                  name='Thai',            scope='I', type='L'},
	['bo'] = {alpha3='bod', alpha3B='tib',   name='Tibetan',         scope='I', type='L'},
	['ti'] = {alpha3='tir',                  name='Tigrinya',        scope='I', type='L'},
	['to'] = {alpha3='ton',                  name='Tonga',           scope='I', type='L'},
	['ts'] = {alpha3='tso',                  name='Tsonga',          scope='I', type='L'},
	['tn'] = {alpha3='tsn',                  name='Tswana',          scope='I', type='L'},
	['tk'] = {alpha3='tuk',                  name='Turkmen',         scope='I', type='L'},
	['tr'] = {alpha3='tur',                  name='Turkish',         scope='I', type='L'},
	['tw'] = {alpha3='twi',                  name='Twi',             scope='I', type='L'},

	-- U V
	['ug'] = {alpha3='uig',                  name='Uighur',          scope='I', type='L', altnames={'Uyghur'}},
	['uk'] = {alpha3='ukr',                  name='Ukrainian',       scope='I', type='L'},
	['ur'] = {alpha3='urd',                  name='Urdu',            scope='I', type='L'},
	['uz'] = {alpha3='uzb',                  name='Uzbek',           scope='M', type='L'},
	['ve'] = {alpha3='ven',                  name='Venda',           scope='I', type='L'},
	['vi'] = {alpha3='vie',                  name='Vietnamese',      scope='I', type='L'},
	['vo'] = {alpha3='vol',                  name='Volapük',         scope='I', type='C'},

	-- W X Y Z
	['wa'] = {alpha3='wln',                  name='Walloon',         scope='I', type='L'},
	['cy'] = {alpha3='cym', alpha3B='wel',   name='Welsh',           scope='I', type='L'},
	['wo'] = {alpha3='wol',                  name='Wolof',           scope='I', type='L'},
	['xh'] = {alpha3='xho',                  name='Xhosa',           scope='I', type='L'},
	['yi'] = {alpha3='yid',                  name='Yiddish',         scope='M', type='L'},
	['yo'] = {alpha3='yor',                  name='Yoruba',          scope='I', type='L'},
	['za'] = {alpha3='zha',                  name='Zhuang',          scope='M', type='L', altnames={'Chuang'}},
	['zu'] = {alpha3='zul',                  name='Zulu',            scope='I', type='L'},
}

-- ============================================================
-- 2. Reverse-lookup (build tự động, DRY – không bảng thứ hai)
--    reverseA3['vie']  → 'vi'
--    reverseA3['chi']  → 'zh'  (bibliographic)
-- ============================================================
local reverseA3 = {}
for alpha2, data in pairs(baseData) do
	if data.alpha3  then reverseA3[data.alpha3 ] = alpha2 end
	if data.alpha3B then reverseA3[data.alpha3B] = alpha2 end
end

-- ============================================================
-- 3. Nạp /tran (bản dịch, nếu có)
-- ============================================================
local hasTran, tranData = pcall(require, 'Module:I18n/ISO 639/tran')
if not hasTran or type(tranData) ~= 'table' then tranData = {} end

-- ============================================================
-- 4. Engine tra cứu tên ngôn ngữ
-- ============================================================

--- Chuẩn hoá đầu vào: lowercase + trim, hỗ trợ Alpha-2 và Alpha-3
local function resolveAlpha2(code)
	code = mw.text.trim(code):lower()
	-- Nếu là Alpha-3 (3 ký tự) → tra bảng đảo ngược
	if #code == 3 then
		return reverseA3[code] or code   -- fallback: giữ nguyên nếu không tìm thấy
	end
	return code  -- Alpha-2 (2 ký tự) hoặc tag BCP 47 (vi-viet, zh-hans…)
end

--- Tra tên ngôn ngữ
--  @param code       mã ISO 639-1 ('vi') hoặc ISO 639-2/3 ('vie')
--  @param targetLang ngôn ngữ cần hiển thị ('vi', 'zh', 'en', …)
--  @param fallbacks  bảng fallback từ Module:I18n (DRY)
--  @return tên ngôn ngữ hoặc chính mã đó nếu không tìm thấy
function M.getName(code, targetLang, fallbacks)
	if not code then return nil end

	local alpha2 = resolveAlpha2(code)
	local entry  = baseData[alpha2]
	if not entry then return code end  -- không có trong CSDL

	-- Tiếng Anh: trả thẳng từ baseData
	if not targetLang or targetLang == 'en' then
		return entry.name
	end

	-- Hàm tra /tran cho một mã ngôn ngữ cụ thể
	local function checkTran(langCode)
		local row = tranData[alpha2]
		return row and row[langCode] or nil
	end

	-- A. Thử chính xác ngôn ngữ yêu cầu
	local result = checkTran(targetLang)
	if result then return result end

	-- B. Thử chuỗi fallback (không chạm 'en' → xử lý ở C)
	if fallbacks and fallbacks[targetLang] then
		for _, fl in ipairs(fallbacks[targetLang]) do
			if fl == 'en' then break end
			result = checkTran(fl)
			if result then return result end
		end
	end

	-- C. Fallback cuối: tên tiếng Anh từ baseData
	return entry.name
end

--- Trả về toàn bộ metadata của một mã ngôn ngữ (tiện debug / infobox)
function M.getData(code)
	if not code then return nil end
	local alpha2 = resolveAlpha2(code)
	return baseData[alpha2]
end

--- Liệt kê tất cả mã ngôn ngữ đã biết (alpha2)
function M.getAllCodes()
	local list = {}
	for k in pairs(baseData) do list[#list+1] = k end
	table.sort(list)
	return list
end

return M
