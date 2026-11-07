--  ============================================================
--  Module:I18n/ISO 639
--  Tra tên ngôn ngữ theo mã ISO 639-1 (Alpha-2) hoặc ISO 639-2/3 (Alpha-3)
--
--  Quy tắc DRY:
--    · baseData  = nguồn sự thật duy nhất (tên tiếng Anh + metadata)
--    · /tran     = chỉ chứa bản dịch, KHÔNG lặp lại tên tiếng Anh
--    · Alpha-3   = tra qua Module:I18n/Alias (build tự động từ baseData,
--                  không bảng thứ hai, có phát hiện xung đột)
--    · Fallback  = nhận từ Module:I18n, không định nghĩa lại
--
--  Cách dùng:
--    local iso639 = require('Module:I18n/ISO 639')
--    iso639.getName('vi', 'en')    --> "Vietnamese"
--    iso639.getName('vie', 'vi')   --> "Tiếng Việt"
--    iso639.getName('zh', 'vi')    --> "Tiếng Trung"
--  ============================================================

local M = {}

M._meta = {
	standard = 'ISO 639-1 / 639-2 / 639-3 / 639-5',
	sources  = {
		'https://www.loc.gov/standards/iso639-2/',
		'https://www.loc.gov/standards/iso639-5/',
		'https://iso639-3.sil.org/code_tables/download_tables',
	},
	updated  = '2026-11-07',
}

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
	['bh'] = {alpha3='bih',                  name='Bihari languages',scope='C', type='L', altnames={'Bihari'}},
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
	['se'] = {alpha3='sme',                  name='Northern Sami',   scope='I', type='L', altnames={'North Sami'}},
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
	['tl'] = {alpha3='tgl',                  name='Tagalog',         scope='I', type='L'},
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
-- 1b. ISO 639-2 / 639-3 / 639-5 (Mã chuẩn 3 ký tự không có mã 639-1)
--     part  : 2 (639-2), 3 (639-3), 5 (639-5 họ/nhóm ngôn ngữ)
--     scope : 'I'=individual, 'M'=macrolanguage, 'C'=collection/family, 'S'=special
--     type  : 'L'=living, 'H'=historical, 'A'=ancient, 'C'=constructed, 'S'=special
-- ============================================================
local part235Data = {
	-- Ngôn ngữ cổ đại & lịch sử (ISO 639-2 / 639-3)
	['akk'] = {part=3, name='Akkadian',               scope='I', type='A'},
	['ang'] = {part=3, name='Old English',            scope='I', type='H', altnames={'Anglo-Saxon'}},
	['arc'] = {part=3, name='Official Aramaic',       scope='I', type='A', altnames={'Imperial Aramaic'}},
	['cop'] = {part=3, name='Coptic',                 scope='I', type='H'},
	['egy'] = {part=3, name='Egyptian (Ancient)',     scope='I', type='A', altnames={'Ancient Egyptian'}},
	['enm'] = {part=3, name='Middle English',         scope='I', type='H'},
	['frm'] = {part=3, name='Middle French',          scope='I', type='H'},
	['fro'] = {part=3, name='Old French',             scope='I', type='H'},
	['gmh'] = {part=3, name='Middle High German',     scope='I', type='H'},
	['goh'] = {part=3, name='Old High German',        scope='I', type='H'},
	['got'] = {part=3, name='Gothic',                 scope='I', type='A'},
	['grc'] = {part=3, name='Greek, Ancient',         scope='I', type='H', altnames={'Ancient Greek'}},
	['hit'] = {part=3, name='Hittite',                scope='I', type='A'},
	['kaw'] = {part=3, name='Kawi',                   scope='I', type='A', altnames={'Old Javanese'}},
	['lzh'] = {part=3, name='Literary Chinese',       scope='I', type='H', altnames={'Classical Chinese'}},
	['non'] = {part=3, name='Old Norse',              scope='I', type='H'},
	['pal'] = {part=3, name='Pahlavi',                scope='I', type='A', altnames={'Middle Persian'}},
	['peo'] = {part=3, name='Old Persian',            scope='I', type='H'},
	['phn'] = {part=3, name='Phoenician',             scope='I', type='A'},
	['pro'] = {part=3, name='Old Provençal',          scope='I', type='H', altnames={'Old Occitan'}},
	['sga'] = {part=3, name='Old Irish',              scope='I', type='H'},
	['sux'] = {part=3, name='Sumerian',               scope='I', type='A'},
	['syc'] = {part=3, name='Classical Syriac',       scope='I', type='H'},
	['uga'] = {part=3, name='Ugaritic',               scope='I', type='A'},

	-- Ngôn ngữ hiện đại, đại ngôn ngữ & ngôn ngữ vùng miền tiêu biểu (ISO 639-2 / 639-3)
	['ast'] = {part=3, name='Asturian',               scope='I', type='L', altnames={'Bable','Leonese'}},
	['ceb'] = {part=3, name='Cebuano',                scope='I', type='L'},
	['chr'] = {part=3, name='Cherokee',               scope='I', type='L'},
	['cmn'] = {part=3, name='Mandarin Chinese',       scope='I', type='L'},
	['csb'] = {part=3, name='Kashubian',              scope='I', type='L'},
	['dsb'] = {part=3, name='Lower Sorbian',          scope='I', type='L'},
	['fil'] = {part=3, name='Filipino',               scope='I', type='L', altnames={'Pilipino'}},
	['fur'] = {part=3, name='Friulian',               scope='I', type='L'},
	['gsw'] = {part=3, name='Swiss German',           scope='I', type='L', altnames={'Alemannic','Alsatian'}},
	['hak'] = {part=3, name='Hakka Chinese',          scope='I', type='L'},
	['haw'] = {part=3, name='Hawaiian',               scope='I', type='L'},
	['hbs'] = {part=3, name='Serbo-Croatian',         scope='M', type='L'},
	['hmn'] = {part=3, name='Hmong',                  scope='M', type='L', altnames={'Mong'}},
	['hsb'] = {part=3, name='Upper Sorbian',          scope='I', type='L'},
	['ilo'] = {part=3, name='Iloko',                  scope='I', type='L', altnames={'Ilocano'}},
	['kab'] = {part=3, name='Kabyle',                 scope='I', type='L'},
	['kok'] = {part=3, name='Konkani',                scope='M', type='L'},
	['lad'] = {part=3, name='Ladino',                 scope='I', type='L', altnames={'Judaeo-Spanish'}},
	['mai'] = {part=3, name='Maithili',               scope='I', type='L'},
	['mni'] = {part=3, name='Manipuri',               scope='I', type='L', altnames={'Meitei'}},
	['mtq'] = {part=3, name='Muong',                  scope='I', type='L', altnames={'Mường'}},
	['nan'] = {part=3, name='Min Nan Chinese',        scope='I', type='L', altnames={'Hokkien','Southern Min'}},
	['nap'] = {part=3, name='Neapolitan',             scope='I', type='L'},
	['nds'] = {part=3, name='Low German',             scope='I', type='L', altnames={'Low Saxon'}},
	['nut'] = {part=3, name='Nung (Viet Nam)',        scope='I', type='L', altnames={'Nùng'}},
	['rom'] = {part=3, name='Romany',                 scope='M', type='L', altnames={'Romani'}},
	['rup'] = {part=3, name='Aromanian',              scope='I', type='L', altnames={'Macedo-Romanian'}},
	['sah'] = {part=3, name='Yakut',                  scope='I', type='L', altnames={'Sakha'}},
	['sat'] = {part=3, name='Santali',                scope='I', type='L'},
	['scn'] = {part=3, name='Sicilian',               scope='I', type='L'},
	['sco'] = {part=3, name='Scots',                  scope='I', type='L'},
	['tet'] = {part=3, name='Tetum',                  scope='I', type='L'},
	['tpi'] = {part=3, name='Tok Pisin',              scope='I', type='L'},
	['tyz'] = {part=3, name='Tày',                    scope='I', type='L', altnames={'Tay'}},
	['vec'] = {part=3, name='Venetian',               scope='I', type='L'},
	['war'] = {part=3, name='Waray',                  scope='I', type='L'},
	['wuu'] = {part=3, name='Wu Chinese',             scope='I', type='L', altnames={'Shanghainese'}},
	['yue'] = {part=3, name='Yue Chinese',            scope='I', type='L', altnames={'Cantonese'}},
	['zgh'] = {part=3, name='Standard Moroccan Tamazight', scope='I', type='L'},

	-- Mã đặc biệt chuẩn ISO 639-2 / 639-3
	['mis'] = {part=3, name='Uncoded languages',      scope='S', type='S'},
	['mul'] = {part=3, name='Multiple languages',     scope='S', type='S'},
	['und'] = {part=3, name='Undetermined',           scope='S', type='S'},
	['zxx'] = {part=3, name='No linguistic content',  scope='S', type='S'},

	-- Họ & nhóm ngôn ngữ chuẩn ISO 639-5 / ISO 639-2 collective
	['afa'] = {part=5, name='Afro-Asiatic languages',           scope='C'},
	['alg'] = {part=5, name='Algonquian languages',             scope='C'},
	['alv'] = {part=5, name='Atlantic-Congo languages',         scope='C'},
	['art'] = {part=5, name='Artificial languages',             scope='C'},
	['ath'] = {part=5, name='Athapascan languages',             scope='C'},
	['aus'] = {part=5, name='Australian languages',             scope='C'},
	['awd'] = {part=5, name='Arawakan languages',               scope='C'},
	['azc'] = {part=5, name='Uto-Aztecan languages',            scope='C'},
	['bat'] = {part=5, name='Baltic languages',                 scope='C'},
	['ber'] = {part=5, name='Berber languages',                 scope='C'},
	['bnt'] = {part=5, name='Bantu languages',                  scope='C'},
	['cai'] = {part=5, name='Central American Indian languages',scope='C'},
	['cau'] = {part=5, name='Caucasian languages',              scope='C'},
	['cel'] = {part=5, name='Celtic languages',                 scope='C'},
	['crp'] = {part=5, name='Creoles and pidgins',              scope='C'},
	['cus'] = {part=5, name='Cushitic languages',               scope='C'},
	['dra'] = {part=5, name='Dravidian languages',              scope='C'},
	['egx'] = {part=5, name='Egyptian languages',               scope='C'},
	['esx'] = {part=5, name='Eskimo-Aleut languages',           scope='C'},
	['euq'] = {part=5, name='Basque (family)',                  scope='C', altnames={'Vasconic languages'}},
	['fiu'] = {part=5, name='Finno-Ugrian languages',           scope='C'},
	['gem'] = {part=5, name='Germanic languages',               scope='C'},
	['gme'] = {part=5, name='East Germanic languages',          scope='C'},
	['gmq'] = {part=5, name='North Germanic languages',         scope='C'},
	['gmw'] = {part=5, name='West Germanic languages',          scope='C'},
	['grk'] = {part=5, name='Greek languages',                  scope='C', altnames={'Hellenic languages'}},
	['hmx'] = {part=5, name='Hmong-Mien languages',             scope='C'},
	['iir'] = {part=5, name='Indo-Iranian languages',           scope='C'},
	['inc'] = {part=5, name='Indic languages',                  scope='C', altnames={'Indo-Aryan languages'}},
	['ine'] = {part=5, name='Indo-European languages',          scope='C'},
	['ira'] = {part=5, name='Iranian languages',                scope='C'},
	['itc'] = {part=5, name='Italic languages',                 scope='C'},
	['jpx'] = {part=5, name='Japanese (family)',                scope='C', altnames={'Japonic languages'}},
	['kar'] = {part=5, name='Karen languages',                  scope='C'},
	['khi'] = {part=5, name='Khoisan languages',                scope='C'},
	['map'] = {part=5, name='Austronesian languages',           scope='C'},
	['mkh'] = {part=5, name='Mon-Khmer languages',              scope='C', altnames={'Austroasiatic languages'}},
	['mun'] = {part=5, name='Munda languages',                  scope='C'},
	['myn'] = {part=5, name='Mayan languages',                  scope='C'},
	['nah'] = {part=5, name='Nahuatl languages',                scope='C'},
	['nai'] = {part=5, name='North American Indian languages',  scope='C'},
	['nic'] = {part=5, name='Niger-Kordofanian languages',      scope='C'},
	['nub'] = {part=5, name='Nubian languages',                 scope='C'},
	['omq'] = {part=5, name='Oto-Manguean languages',           scope='C'},
	['paa'] = {part=5, name='Papuan languages',                 scope='C'},
	['phi'] = {part=5, name='Philippine languages',             scope='C'},
	['poz'] = {part=5, name='Malayo-Polynesian languages',      scope='C'},
	['pra'] = {part=5, name='Prakrit languages',                scope='C'},
	['qwe'] = {part=5, name='Quechuan (family)',                scope='C'},
	['roa'] = {part=5, name='Romance languages',                scope='C'},
	['sai'] = {part=5, name='South American Indian languages',  scope='C'},
	['sem'] = {part=5, name='Semitic languages',                scope='C'},
	['sgn'] = {part=5, name='Sign languages',                   scope='C'},
	['sio'] = {part=5, name='Siouan languages',                 scope='C'},
	['sit'] = {part=5, name='Sino-Tibetan languages',           scope='C'},
	['sla'] = {part=5, name='Slavic languages',                 scope='C'},
	['smi'] = {part=5, name='Sami languages',                   scope='C'},
	['ssa'] = {part=5, name='Nilo-Saharan languages',           scope='C'},
	['tai'] = {part=5, name='Tai languages',                    scope='C', altnames={'Kra-Dai languages'}},
	['tbq'] = {part=5, name='Tibeto-Burman languages',          scope='C'},
	['trk'] = {part=5, name='Turkic languages',                 scope='C'},
	['tup'] = {part=5, name='Tupi languages',                   scope='C'},
	['tut'] = {part=5, name='Altaic languages',                 scope='C'},
	['tuw'] = {part=5, name='Tungus languages',                 scope='C', altnames={'Tungusic languages'}},
	['urj'] = {part=5, name='Uralic languages',                 scope='C'},
	['wen'] = {part=5, name='Sorbian languages',                scope='C'},
	['xgn'] = {part=5, name='Mongolic languages',               scope='C'},
	['zhx'] = {part=5, name='Chinese (family)',                 scope='C', altnames={'Sinitic languages'}},
	['zle'] = {part=5, name='East Slavic languages',            scope='C'},
	['zls'] = {part=5, name='South Slavic languages',           scope='C'},
	['zlw'] = {part=5, name='West Slavic languages',            scope='C'},
}

-- ============================================================
-- 1c. Mã ISO 639 cũ đã ngừng sử dụng (Deprecated Codes)
--     Bảo toàn ánh xạ thay thế (replacedBy) và thời điểm ngừng dùng.
-- ============================================================
local deprecatedData = {
	['in']  = { replacedBy = 'id',  alpha3 = 'ind', name = 'Indonesian',     status = 'deprecated', deprecated = '1989' },
	['iw']  = { replacedBy = 'he',  alpha3 = 'heb', name = 'Hebrew',         status = 'deprecated', deprecated = '1989' },
	['ji']  = { replacedBy = 'yi',  alpha3 = 'yid', name = 'Yiddish',        status = 'deprecated', deprecated = '1989' },
	['jw']  = { replacedBy = 'jv',  alpha3 = 'jav', name = 'Javanese',       status = 'deprecated', deprecated = '2001' },
	['mo']  = { replacedBy = 'ro',  alpha3 = 'mol', name = 'Moldavian',      status = 'deprecated', deprecated = '2008' },
	['mol'] = { replacedBy = 'ro',                  name = 'Moldavian',      status = 'deprecated', deprecated = '2008' },
	['sh']  = { replacedBy = 'hbs', alpha3 = 'hbs', name = 'Serbo-Croatian', status = 'deprecated', deprecated = '2000', splitInto = { 'bs', 'hr', 'sr' } },
}

-- Hợp nhất bảng tra cứu bản ghi chuẩn (ISO 639-1 ưu tiên mã 2 ký tự; 639-2/3/5 dùng mã 3 ký tự)
local allData = {}
for k, v in pairs(baseData) do allData[k] = v end
for k, v in pairs(part235Data) do allData[k] = v end

-- ============================================================
-- 2. Nạp /tran (bản dịch, nếu có)
-- ============================================================
local function loadOptionalTran(modName)
	if mw and mw.loadData then
		local ok, d = pcall(mw.loadData, modName)
		if ok and type(d) == 'table' then return d end
	end
	local ok, d = pcall(require, modName)
	if ok and type(d) == 'table' then return d end
	return nil
end

local tranData = loadOptionalTran('Module:I18n/ISO 639/tran')
	or loadOptionalTran('Module:I18n/ISO 639/data')
	or {}

-- ============================================================
-- 3. Unified alias registry (Module:I18n/Alias)
--    Thay cho bảng reverseA3 cục bộ: mọi chỉ mục (639-1, 639-2/T,
--    639-2/B, 639-3, 639-5, mã deprecated, tên, altnames, bản dịch)
--    được dựng DUY NHẤT từ allData + deprecatedData + /tran.
-- ============================================================
local Alias = require('Module:I18n/Alias')
local NS = 'iso639'

local function loader(api)
	local codes = {}
	for code in pairs(allData) do codes[#codes + 1] = code end
	table.sort(codes)

	for _, code in ipairs(codes) do
		local d = allData[code]
		api.addRecord(code, d)
		if d.alpha3  then api.register(d.alpha3,  code, 'official') end
		if d.alpha3B then api.register(d.alpha3B, code, 'official') end
		api.register(d.name, code, 'name')
		for _, alt in ipairs(d.altnames or {}) do api.register(alt, code, 'project') end
	end

	local depCodes = {}
	for dCode in pairs(deprecatedData) do depCodes[#depCodes + 1] = dCode end
	table.sort(depCodes)
	for _, dCode in ipairs(depCodes) do
		local dep = deprecatedData[dCode]
		if dep.replacedBy and allData[dep.replacedBy] then
			api.register(dCode, dep.replacedBy, 'deprecated')
		end
	end

	for _, code in ipairs(codes) do
		local row = tranData[code]
		if type(row) == 'table' then
			local langs = {}
			for lang in pairs(row) do langs[#langs + 1] = lang end
			table.sort(langs)
			for _, lang in ipairs(langs) do api.register(row[lang], code, 'translation') end
		end
	end
end

Alias.define(NS, { loader = loader })

-- ============================================================
-- 4. Engine tra cứu tên ngôn ngữ
-- ============================================================

--- Chuẩn hoá đầu vào: hỗ trợ 639-1, 639-2/T, 639-2/B, 639-3, 639-5, deprecated, tên & alias.
--  Trả về chính mã (lowercase) nếu không tìm thấy (tag BCP 47 như zh-hans…)
local function resolveCanonical(code)
	return Alias.resolve(NS, code) or mw.text.trim(tostring(code)):lower()
end

--- Phân giải bất kỳ mã/tên/alias nào về mã chuẩn (Alpha-2 cho 639-1, Alpha-3 cho 639-2/3/5).
--  @return canonical, kind | nil, info (info.ambiguous khi mơ hồ)
function M.resolve(input)
	return Alias.resolve(NS, input)
end

--- Tra cứu thông tin mã ngôn ngữ đã ngừng sử dụng (vd: 'iw', 'in', 'ji', 'mo', 'sh').
function M.getDeprecated(code)
	if not code then return nil end
	local k = mw.text.trim(tostring(code)):lower()
	return deprecatedData[k]
end

--- Tra tên ngôn ngữ
--  @param code       mã ISO 639-1 ('vi'), 639-2/3 ('vie', 'grc'), 639-5 ('mkh') hoặc mã cũ ('iw')
--  @param targetLang ngôn ngữ cần hiển thị ('vi', 'zh', 'en', …)
--  @param fallbacks  bảng fallback từ Module:I18n (DRY)
--  @return tên ngôn ngữ hoặc chính mã đó nếu không tìm thấy
function M.getName(code, targetLang, fallbacks)
	if not code then return nil end

	local canonical = resolveCanonical(code)
	local entry     = allData[canonical]
	if not entry then return code end  -- không có trong CSDL

	-- Tiếng Anh: trả thẳng từ allData
	if not targetLang or targetLang == 'en' then
		return entry.name
	end

	-- Hàm tra /tran cho một mã ngôn ngữ cụ thể
	local function checkTran(langCode)
		local row = tranData[canonical]
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

	-- C. Fallback cuối: tên tiếng Anh chuẩn
	return entry.name
end

--- Trả về toàn bộ metadata của một mã ngôn ngữ (tiện debug / infobox)
function M.getData(code)
	if not code then return nil end
	local canonical = resolveCanonical(code)
	return allData[canonical]
end

--- Liệt kê các mã ngôn ngữ đã biết.
--  @param part (tuỳ chọn) 1 = chỉ ISO 639-1 (184 mã Alpha-2);
--                         3 = chỉ ISO 639-2/3 mở rộng;
--                         5 = chỉ họ ngôn ngữ ISO 639-5;
--                         nil = toàn bộ mã chuẩn.
function M.getAllCodes(part)
	local list = {}
	if part == 1 then
		for k in pairs(baseData) do list[#list + 1] = k end
	elseif part == 3 or part == 5 then
		for k, v in pairs(part235Data) do
			if v.part == part then list[#list + 1] = k end
		end
	else
		for k in pairs(allData) do list[#list + 1] = k end
	end
	table.sort(list)
	return list
end

--- Mọi alias trỏ về một mã ngôn ngữ (tra ngược).
function M.getAliases(code)
	local canonical = Alias.resolve(NS, code)
	return canonical and Alias.getAliases(NS, canonical) or {}
end

--- Báo cáo toàn vẹn dữ liệu (xung đột, alias mơ hồ, alias treo).
function M.validate()
	return Alias.validate(NS)
end

function M.getMeta()
	return M._meta
end

return M
