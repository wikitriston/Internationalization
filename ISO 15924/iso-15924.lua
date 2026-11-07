--  ============================================================
--  Module:I18n/ISO 15924
--  Tra cứu hệ chữ viết (ISO 15924 Alpha-4, Numeric & Unicode Script)
--
--  Nguồn chuẩn chính thức (Provenance):
--    · ISO 15924 Registration Authority (Unicode Consortium)
--      https://www.unicode.org/iso15924/iso15924.txt
--    · Unicode Character Database (UAX #24 / UAX #44)
--      https://www.unicode.org/Public/UCD/latest/ucd/Scripts.txt
--      https://www.unicode.org/Public/UCD/latest/ucd/ScriptExtensions.txt
--      https://www.unicode.org/Public/UCD/latest/ucd/PropertyValueAliases.txt
--
--  Quy tắc DRY:
--    · baseData  = nguồn sự thật duy nhất (Alpha-4, Numeric, tên tiếng Anh,
--                  tên tiếng Pháp chuẩn ISO, Unicode PVA, chiều viết, loại
--                  hình hiện đại/cổ đại, quan hệ hệ chữ & Script_Extensions)
--    · /tran     = chỉ chứa bản dịch (Module:I18n/ISO 15924/tran), KHÔNG lặp
--                  lại tên tiếng Anh
--    · Alias     = đồng bộ tập trung qua Module:I18n/Alias (không bảng phụ)
--
--  Cách dùng:
--    local iso15924 = require('Module:I18n/ISO 15924')
--    iso15924.getName('Latn', 'vi')   --> "Chữ Latinh"
--    iso15924.getName('050',  'vi')   --> "Chữ tượng hình Ai Cập"
--    iso15924.getName('Xsux', 'en')   --> "Cuneiform, Sumero-Akkadian"
--    iso15924.resolve('Qaai')         --> "Zinh", "deprecated"
--  ============================================================

local M = {}

M._meta = {
	standard = 'ISO 15924',
	source   = 'https://www.unicode.org/iso15924/iso15924.txt',
	ucd      = 'https://www.unicode.org/Public/UCD/latest/ucd/',
	updated  = '2026-11-07',
}

-- ============================================================
-- 1. Base Data – mã Alpha-4 chuẩn ISO 15924
--    numeric        : mã 3 chữ số chính thức ISO 15924
--    name           : tên tiếng Anh chuẩn ISO 15924
--    nameFr         : tên tiếng Pháp chuẩn ISO 15924
--    pva            : Unicode Property Value Alias (sc), nếu có
--    direction      : 'ltr' | 'rtl' | 'ttb' | 'boustrophedon' | 'mixed' | 'varies'
--    type           : 'living' | 'historical' | 'ancient' | 'undeciphered'
--                     | 'variant' | 'alias' | 'special' | 'private-use'
--    status         : 'registered' | 'special' | 'private-use'
--    parent         : mã hệ chữ gốc / tổ tiên trực tiếp (nếu xác thực)
--    related        : các hệ chữ liên quan hoặc thành phần gộp
--    extensionsWith : quan hệ Unicode Script_Extensions (scx) tiêu biểu
--    altnames       : tên thay thế / tên lịch sử / phân loại Unicode liên quan
--    deprecatedAliases : mã/bí danh Unicode cũ đã ngừng dùng (vd: Qaai → Zinh)
-- ============================================================
local baseData = {
	-- ── A ─────────────────────────────────────────────────────
	['Adlm'] = {numeric='166', name='Adlam', nameFr='adlam', pva='Adlam', direction='rtl', type='living', status='registered'},
	['Aghb'] = {numeric='239', name='Caucasian Albanian', nameFr='aghbanien', pva='Caucasian_Albanian', direction='ltr', type='ancient', status='registered', altnames={'Old Udi'}},
	['Ahom'] = {numeric='338', name='Ahom, Tai Ahom', nameFr='âhom', pva='Ahom', direction='ltr', type='historical', status='registered', parent='Brah', altnames={'Tai Ahom'}},
	['Arab'] = {numeric='160', name='Arabic', nameFr='arabe', pva='Arabic', direction='rtl', type='living', status='registered', parent='Nbat', extensionsWith={'Syrc','Thaa','Mand','Rohg','Adlm'}},
	['Aran'] = {numeric='161', name='Arabic (Nastaliq variant)', nameFr='arabe (variante nastalique)', direction='rtl', type='variant', status='registered', parent='Arab', altnames={'Nastaliq','Nastaʿlīq'}},
	['Armi'] = {numeric='124', name='Imperial Aramaic', nameFr='araméen impérial', pva='Imperial_Aramaic', direction='rtl', type='ancient', status='registered', parent='Phnx', related={'Hebr','Syrc','Nbat','Palm','Phli','Prti'}},
	['Armn'] = {numeric='230', name='Armenian', nameFr='arménien', pva='Armenian', direction='ltr', type='living', status='registered', extensionsWith={'Grek'}},
	['Avst'] = {numeric='134', name='Avestan', nameFr='avestique', pva='Avestan', direction='rtl', type='ancient', status='registered', parent='Phli', altnames={'Din Dabireh'}},

	-- ── B ─────────────────────────────────────────────────────
	['Bali'] = {numeric='360', name='Balinese', nameFr='balinais', pva='Balinese', direction='ltr', type='living', status='registered', parent='Kawi'},
	['Bamu'] = {numeric='435', name='Bamum', nameFr='bamoum', pva='Bamum', direction='ltr', type='living', status='registered', altnames={'Shü-mom'}},
	['Bass'] = {numeric='259', name='Bassa Vah', nameFr='bassa', pva='Bassa_Vah', direction='ltr', type='living', status='registered', altnames={'Vah'}},
	['Batk'] = {numeric='365', name='Batak', nameFr='batak', pva='Batak', direction='ltr', type='living', status='registered', parent='Kawi', altnames={'Surat Batak'}},
	['Beng'] = {numeric='325', name='Bengali (Bangla)', nameFr='bengali (bangla)', pva='Bengali', direction='ltr', type='living', status='registered', parent='Brah', extensionsWith={'Deva','Sylo','Cakm','Tirh'}, altnames={'Bangla','Eastern Nagari'}},
	['Bhks'] = {numeric='334', name='Bhaiksuki', nameFr='bhaïksukî', pva='Bhaiksuki', direction='ltr', type='historical', status='registered', parent='Brah', altnames={'Arrow-Headed Script'}},
	['Bopo'] = {numeric='285', name='Bopomofo', nameFr='bopomofo', pva='Bopomofo', direction='ltr', type='living', status='registered', related={'Hani','Hanb'}, extensionsWith={'Hani'}, altnames={'Zhuyin','Zhuyin Fuhao'}},
	['Brah'] = {numeric='300', name='Brahmi', nameFr='brâhmî', pva='Brahmi', direction='ltr', type='ancient', status='registered', related={'Deva','Beng','Taml','Thai','Tibt','Khmr','Mymr','Sinh'}},
	['Brai'] = {numeric='570', name='Braille', nameFr='braille', pva='Braille', direction='ltr', type='living', status='registered'},
	['Bugi'] = {numeric='367', name='Buginese', nameFr='bouguis', pva='Buginese', direction='ltr', type='living', status='registered', parent='Kawi', extensionsWith={'Java'}, altnames={'Lontara'}},
	['Buhd'] = {numeric='372', name='Buhid', nameFr='bouhide', pva='Buhid', direction='ltr', type='living', status='registered', parent='Kawi', extensionsWith={'Tglg','Hano','Tagb'}},

	-- ── C ─────────────────────────────────────────────────────
	['Cakm'] = {numeric='349', name='Chakma', nameFr='chakma', pva='Chakma', direction='ltr', type='living', status='registered', parent='Mymr', extensionsWith={'Beng','Mymr'}, altnames={'Ajhā Pāṭh','Ojhopath'}},
	['Cans'] = {numeric='440', name='Unified Canadian Aboriginal Syllabics', nameFr='syllabaire autochtone canadien unifié', pva='Canadian_Aboriginal', direction='ltr', type='living', status='registered', altnames={'UCAS','Inuktitut syllabics','Cree syllabics'}},
	['Cari'] = {numeric='201', name='Carian', nameFr='carien', pva='Carian', direction='ltr', type='ancient', status='registered'},
	['Cham'] = {numeric='358', name='Cham', nameFr='cham (čam, tcham)', pva='Cham', direction='ltr', type='living', status='registered', parent='Brah', altnames={'Akhar Thrah'}},
	['Cher'] = {numeric='445', name='Cherokee', nameFr='cherokee', pva='Cherokee', direction='ltr', type='living', status='registered'},
	['Chrs'] = {numeric='109', name='Chorasmian', nameFr='chorasmien', pva='Chorasmian', direction='rtl', type='ancient', status='registered', parent='Armi', altnames={'Khwarezmian'}},
	['Copt'] = {numeric='204', name='Coptic', nameFr='copte', pva='Coptic', direction='ltr', type='historical', status='registered', parent='Grek', related={'Egyd'}},
	['Cpmn'] = {numeric='402', name='Cypro-Minoan', nameFr='syllabaire chypro-minoen', pva='Cypro_Minoan', direction='ltr', type='ancient', status='registered', parent='Lina', related={'Cprt'}},
	['Cprt'] = {numeric='403', name='Cypriot syllabary', nameFr='syllabaire chypriote', pva='Cypriot', direction='rtl', type='ancient', status='registered', parent='Cpmn', extensionsWith={'Linb'}, altnames={'Cypriot'}},
	['Cyrl'] = {numeric='220', name='Cyrillic', nameFr='cyrillique', pva='Cyrillic', direction='ltr', type='living', status='registered', parent='Grek', related={'Glag','Cyrs'}, extensionsWith={'Glag','Latn','Perm'}},
	['Cyrs'] = {numeric='221', name='Cyrillic (Old Church Slavonic variant)', nameFr='cyrillique (variante slavonne)', direction='ltr', type='variant', status='registered', parent='Cyrl', altnames={'Early Cyrillic','Old Cyrillic'}},

	-- ── D E ───────────────────────────────────────────────────
	['Deva'] = {numeric='315', name='Devanagari (Nagari)', nameFr='dévanâgarî', pva='Devanagari', direction='ltr', type='living', status='registered', parent='Brah', extensionsWith={'Beng','Guru','Gujr','Orya','Taml','Telu','Knda','Mlym','Gran','Shrd','Takr','Mahj','Khoj','Sind','Modi','Tirh','Dogr','Nand'}, altnames={'Nagari'}},
	['Diak'] = {numeric='342', name='Dives Akuru', nameFr='dives akuru', pva='Dives_Akuru', direction='ltr', type='historical', status='registered', parent='Gran', altnames={'Dhives Akuru','Evēla Akuru'}},
	['Dogr'] = {numeric='328', name='Dogra', nameFr='dogra', pva='Dogra', direction='ltr', type='historical', status='registered', parent='Takr', extensionsWith={'Deva','Takr'}, altnames={'Dogri script'}},
	['Dsrt'] = {numeric='250', name='Deseret (Mormon)', nameFr='déseret (mormon)', pva='Deseret', direction='ltr', type='historical', status='registered', altnames={'Mormon alphabet'}},
	['Dupl'] = {numeric='755', name='Duployan shorthand, Duployan stenography', nameFr='sténographie Duployé', pva='Duployan', direction='ltr', type='living', status='registered', altnames={'Duployan shorthand'}},
	['Egyd'] = {numeric='070', name='Egyptian demotic', nameFr='démotique égyptien', direction='rtl', type='ancient', status='registered', parent='Egyh', related={'Egyp','Copt'}, altnames={'Demotic'}},
	['Egyh'] = {numeric='060', name='Egyptian hieratic', nameFr='hiératique égyptien', direction='rtl', type='ancient', status='registered', parent='Egyp', related={'Egyd'}, altnames={'Hieratic'}},
	['Egyp'] = {numeric='050', name='Egyptian hieroglyphs', nameFr='hiéroglyphes égyptiens', pva='Egyptian_Hieroglyphs', direction='varies', type='ancient', status='registered', related={'Egyh','Egyd','Mero'}, altnames={'Medew Netcher'}},
	['Elba'] = {numeric='226', name='Elbasan', nameFr='elbasan', pva='Elbasan', direction='ltr', type='historical', status='registered'},
	['Elym'] = {numeric='128', name='Elymaic', nameFr='élymaïque', pva='Elymaic', direction='rtl', type='ancient', status='registered', parent='Armi'},
	['Ethi'] = {numeric='430', name='Ethiopic (Geʻez)', nameFr='éthiopien (geʻez, guèze)', pva='Ethiopic', direction='ltr', type='living', status='registered', parent='Sarb', altnames={'Ge\'ez','Geez','Fidel'}},

	-- ── G H ───────────────────────────────────────────────────
	['Geok'] = {numeric='241', name='Khutsuri (Asomtavruli and Nuskhuri)', nameFr='khoutsouri (assomtavrouli et nouskhouri)', direction='ltr', type='historical', status='registered', related={'Geor'}, altnames={'Asomtavruli','Nuskhuri'}},
	['Geor'] = {numeric='240', name='Georgian (Mkhedruli and Mtavruli)', nameFr='géorgien (mkhédrouli et mtavrouli)', pva='Georgian', direction='ltr', type='living', status='registered', related={'Geok'}, extensionsWith={'Latn'}, altnames={'Mkhedruli','Mtavruli'}},
	['Glag'] = {numeric='225', name='Glagolitic', nameFr='glagolitique', pva='Glagolitic', direction='ltr', type='historical', status='registered', related={'Cyrl'}, extensionsWith={'Cyrl'}},
	['Gong'] = {numeric='312', name='Gunjala Gondi', nameFr='gunjala gondî', pva='Gunjala_Gondi', direction='ltr', type='living', status='registered', parent='Brah'},
	['Gonm'] = {numeric='313', name='Masaram Gondi', nameFr='masaram gondî', pva='Masaram_Gondi', direction='ltr', type='living', status='registered', parent='Brah'},
	['Goth'] = {numeric='206', name='Gothic', nameFr='gotique', pva='Gothic', direction='ltr', type='ancient', status='registered', parent='Grek'},
	['Gran'] = {numeric='343', name='Grantha', nameFr='grantha', pva='Grantha', direction='ltr', type='historical', status='registered', parent='Brah', related={'Taml','Mlym','Sinh','Thai'}, extensionsWith={'Deva','Taml','Beng'}},
	['Grek'] = {numeric='200', name='Greek', nameFr='grec', pva='Greek', direction='ltr', type='living', status='registered', parent='Phnx', related={'Latn','Cyrl','Copt','Goth','Ital'}, extensionsWith={'Copt','Armn'}, altnames={'Ancient Greek script','Polytonic Greek','Hellenic'}, notes='Covers both Ancient Greek (including polytonic orthography and epigraphic archaic forms) and Modern Greek.'},
	['Gujr'] = {numeric='320', name='Gujarati', nameFr='goudjarâtî (gujrâtî)', pva='Gujarati', direction='ltr', type='living', status='registered', parent='Deva', extensionsWith={'Deva','Khoj'}},
	['Guru'] = {numeric='310', name='Gurmukhi', nameFr='gourmoukhî', pva='Gurmukhi', direction='ltr', type='living', status='registered', parent='Brah', extensionsWith={'Deva','Mult'}},
	['Hanb'] = {numeric='503', name='Han with Bopomofo (alias for Han + Bopomofo)', nameFr='han avec bopomofo (alias pour han + bopomofo)', direction='mixed', type='alias', status='registered', related={'Hani','Hant','Bopo'}},
	['Hang'] = {numeric='286', name='Hangul (Hangŭl, Hangeul)', nameFr='hangûl (hangŭl, hangeul)', pva='Hangul', direction='ltr', type='living', status='registered', related={'Kore','Hani'}, extensionsWith={'Hani','Hira','Kana','Bopo'}, altnames={'Hangeul','Chosŏn\'gŭl'}},
	['Hani'] = {numeric='500', name='Han (Hanzi, Kanji, Hanja)', nameFr='idéogrammes han (sinogrammes)', pva='Han', direction='varies', type='living', status='registered', related={'Hans','Hant','Hanb','Jpan','Kore','Hira','Kana','Bopo','Tang','Kitl','Jurc','Nshu'}, extensionsWith={'Hira','Kana','Bopo','Hang','Yiii'}, altnames={'Hanzi','Kanji','Hanja','Chữ Nôm','Hán-Nôm','Sawndip','Sinograms'}, notes='In Unicode and ISO 15924, Vietnamese Chữ Nôm (along with Tày Nôm and Zhuang Sawndip) is unified under Hani / Script=Han across CJK Unified Ideographs and Extensions A–I.'},
	['Hano'] = {numeric='371', name='Hanunoo (Hanunóo)', nameFr='hanounóo', pva='Hanunoo', direction='ltr', type='living', status='registered', parent='Kawi', extensionsWith={'Tglg','Buhd','Tagb'}},
	['Hans'] = {numeric='501', name='Han (Simplified variant)', nameFr='idéogrammes han (variante simplifiée)', direction='ltr', type='variant', status='registered', parent='Hani', altnames={'Simplified Chinese','Giản thể'}},
	['Hant'] = {numeric='502', name='Han (Traditional variant)', nameFr='idéogrammes han (variante traditionnelle)', direction='varies', type='variant', status='registered', parent='Hani', altnames={'Traditional Chinese','Phồn thể'}},
	['Hatr'] = {numeric='127', name='Hatran', nameFr='hatréen', pva='Hatran', direction='rtl', type='ancient', status='registered', parent='Armi'},
	['Hebr'] = {numeric='125', name='Hebrew', nameFr='hébreu', pva='Hebrew', direction='rtl', type='living', status='registered', parent='Armi', related={'Phnx','Samr'}},
	['Hira'] = {numeric='410', name='Hiragana', nameFr='hiragana', pva='Hiragana', direction='varies', type='living', status='registered', parent='Hani', related={'Kana','Hrkt','Jpan'}, extensionsWith={'Kana','Hani'}},
	['Hluw'] = {numeric='080', name='Anatolian Hieroglyphs (Luwian Hieroglyphs, Hittite Hieroglyphs)', nameFr='hiéroglyphes anatoliens (hiéroglyphes louvites, hiéroglyphes hittites)', pva='Anatolian_Hieroglyphs', direction='boustrophedon', type='ancient', status='registered', altnames={'Luwian Hieroglyphs','Hittite Hieroglyphs'}},
	['Hmng'] = {numeric='450', name='Pahawh Hmong', nameFr='pahawh hmong', pva='Pahawh_Hmong', direction='ltr', type='living', status='registered'},
	['Hmnp'] = {numeric='451', name='Nyiakeng Puachue Hmong', nameFr='nyiakeng puachue hmong', pva='Nyiakeng_Puachue_Hmong', direction='ltr', type='living', status='registered'},
	['Hrkt'] = {numeric='412', name='Japanese syllabaries (alias for Hiragana + Katakana)', nameFr='syllabaires japonais (alias pour hiragana + katakana)', pva='Katakana_Or_Hiragana', direction='varies', type='alias', status='registered', related={'Hira','Kana','Jpan'}, altnames={'Kana syllabaries'}},
	['Hung'] = {numeric='176', name='Old Hungarian (Hungarian Runic)', nameFr='runes hongroises (ancien hongrois)', pva='Old_Hungarian', direction='rtl', type='historical', status='registered', parent='Orkh', altnames={'Hungarian Runic','Rovás'}},

	-- ── I J K ─────────────────────────────────────────────────
	['Inds'] = {numeric='610', name='Indus (Harappan)', nameFr='indus', direction='rtl', type='undeciphered', status='registered', altnames={'Harappan','Indus Valley script'}},
	['Ital'] = {numeric='210', name='Old Italic (Etruscan, Oscan, etc.)', nameFr='ancien italique (étrusque, osque, etc.)', pva='Old_Italic', direction='varies', type='ancient', status='registered', parent='Grek', related={'Latn','Runr'}, altnames={'Etruscan','Oscan','Umbrian'}},
	['Java'] = {numeric='361', name='Javanese', nameFr='javanais', pva='Javanese', direction='ltr', type='living', status='registered', parent='Kawi', extensionsWith={'Bugi'}, altnames={'Hanacaraka','Carakan'}},
	['Jpan'] = {numeric='413', name='Japanese (alias for Han + Hiragana + Katakana)', nameFr='japonais (alias pour han + hiragana + katakana)', direction='varies', type='alias', status='registered', related={'Hani','Hira','Kana','Hrkt'}},
	['Jurc'] = {numeric='510', name='Jurchen', nameFr='jurchen', direction='ttb', type='historical', status='registered', parent='Kitl', related={'Hani'}},
	['Kali'] = {numeric='357', name='Kayah Li', nameFr='kayah li', pva='Kayah_Li', direction='ltr', type='living', status='registered', extensionsWith={'Mymr'}},
	['Kana'] = {numeric='411', name='Katakana', nameFr='katakana', pva='Katakana', direction='varies', type='living', status='registered', parent='Hani', related={'Hira','Hrkt','Jpan'}, extensionsWith={'Hira','Hani'}},
	['Kawi'] = {numeric='368', name='Kawi', nameFr='kawi', pva='Kawi', direction='ltr', type='historical', status='registered', parent='Gran', related={'Java','Bali','Sund','Batk','Bugi','Tglg'}, altnames={'Old Javanese script'}},
	['Khar'] = {numeric='305', name='Kharoshthi', nameFr='kharochthî', pva='Kharoshthi', direction='rtl', type='ancient', status='registered', parent='Armi'},
	['Khmr'] = {numeric='355', name='Khmer', nameFr='khmer', pva='Khmer', direction='ltr', type='living', status='registered', parent='Brah', related={'Thai','Laoo'}},
	['Khoj'] = {numeric='322', name='Khojki', nameFr='khojkî', pva='Khojki', direction='ltr', type='historical', status='registered', parent='Brah', extensionsWith={'Arab','Deva','Gujr'}},
	['Kitl'] = {numeric='505', name='Khitan large script', nameFr='grande écriture khitan', direction='ttb', type='historical', status='registered', related={'Hani','Kits','Jurc'}},
	['Kits'] = {numeric='288', name='Khitan small script', nameFr='petite écriture khitan', pva='Khitan_Small_Script', direction='ttb', type='historical', status='registered', related={'Kitl','Hani'}},
	['Knda'] = {numeric='345', name='Kannada', nameFr='kannara (canara)', pva='Kannada', direction='ltr', type='living', status='registered', parent='Brah', related={'Telu'}, extensionsWith={'Deva','Telu','Nand'}},
	['Kore'] = {numeric='287', name='Korean (alias for Hangul + Han)', nameFr='coréen (alias pour hangûl + han)', direction='varies', type='alias', status='registered', related={'Hang','Hani'}},
	['Kthi'] = {numeric='317', name='Kaithi', nameFr='kaithî', pva='Kaithi', direction='ltr', type='historical', status='registered', parent='Brah', extensionsWith={'Deva'}},

	-- ── L ─────────────────────────────────────────────────────
	['Lana'] = {numeric='351', name='Tai Tham (Lanna)', nameFr='taï tham (lanna)', pva='Tai_Tham', direction='ltr', type='living', status='registered', parent='Mymr', altnames={'Lanna','Tua Mueang','Dhamma script'}},
	['Laoo'] = {numeric='356', name='Lao', nameFr='laotien', pva='Lao', direction='ltr', type='living', status='registered', parent='Khmr', related={'Thai'}},
	['Latf'] = {numeric='217', name='Latin (Fraktur variant)', nameFr='latin (variante brisée)', direction='ltr', type='variant', status='registered', parent='Latn', altnames={'Fraktur','Blackletter'}},
	['Latg'] = {numeric='216', name='Latin (Gaelic variant)', nameFr='latin (variante gaélique)', direction='ltr', type='variant', status='registered', parent='Latn', altnames={'Gaelic script','Insular script'}},
	['Latn'] = {numeric='215', name='Latin', nameFr='latin', pva='Latin', direction='ltr', type='living', status='registered', parent='Ital', related={'Grek','Latf','Latg'}, extensionsWith={'Grek','Cyrl','Geor'}, altnames={'Roman','Quốc ngữ'}, notes='Used globally including modern Vietnamese Chữ Quốc ngữ.'},
	['Lepc'] = {numeric='335', name='Lepcha (Róng)', nameFr='lepcha (róng)', pva='Lepcha', direction='ltr', type='living', status='registered', parent='Tibt', altnames={'Róng'}},
	['Limb'] = {numeric='336', name='Limbu', nameFr='limbou', pva='Limbu', direction='ltr', type='living', status='registered', parent='Tibt', extensionsWith={'Deva'}, altnames={'Sirijonga'}},
	['Lina'] = {numeric='400', name='Linear A', nameFr='linéaire A', pva='Linear_A', direction='ltr', type='undeciphered', status='registered', related={'Linb','Cpmn'}},
	['Linb'] = {numeric='401', name='Linear B', nameFr='linéaire B', pva='Linear_B', direction='ltr', type='ancient', status='registered', parent='Lina', extensionsWith={'Cprt'}, altnames={'Mycenaean Greek script'}},
	['Lisu'] = {numeric='399', name='Lisu (Fraser)', nameFr='lisu (Fraser)', pva='Lisu', direction='ltr', type='living', status='registered', altnames={'Fraser alphabet'}},
	['Lyci'] = {numeric='202', name='Lycian', nameFr='lycien', pva='Lycian', direction='ltr', type='ancient', status='registered', parent='Grek'},
	['Lydi'] = {numeric='116', name='Lydian', nameFr='lydien', pva='Lydian', direction='rtl', type='ancient', status='registered', parent='Grek'},

	-- ── M N ───────────────────────────────────────────────────
	['Mahj'] = {numeric='314', name='Mahajani', nameFr='mahâdjanî', pva='Mahajani', direction='ltr', type='historical', status='registered', parent='Brah', extensionsWith={'Deva'}},
	['Mand'] = {numeric='140', name='Mandaic, Mandaean', nameFr='mandéen', pva='Mandaic', direction='rtl', type='living', status='registered', parent='Armi', extensionsWith={'Arab'}, altnames={'Mandaean'}},
	['Mani'] = {numeric='139', name='Manichaean', nameFr='manichéen', pva='Manichaean', direction='rtl', type='historical', status='registered', parent='Syre', extensionsWith={'Syrc'}},
	['Marc'] = {numeric='332', name='Marchen', nameFr='marchen', pva='Marchen', direction='ltr', type='historical', status='registered', parent='Tibt', altnames={'Zhang-Zhung'}},
	['Maya'] = {numeric='090', name='Mayan hieroglyphs', nameFr='hiéroglyphes mayas', direction='ltr', type='ancient', status='registered', altnames={'Maya script','Maya glyphs'}},
	['Merc'] = {numeric='101', name='Meroitic Cursive', nameFr='cursif méroïtique', pva='Meroitic_Cursive', direction='rtl', type='ancient', status='registered', parent='Egyd', related={'Mero'}},
	['Mero'] = {numeric='100', name='Meroitic Hieroglyphs', nameFr='hiéroglyphes méroïtiques', pva='Meroitic_Hieroglyphs', direction='rtl', type='ancient', status='registered', parent='Egyp', related={'Merc'}},
	['Miao'] = {numeric='282', name='Miao (Pollard)', nameFr='miao (Pollard)', pva='Miao', direction='ltr', type='living', status='registered', altnames={'Pollard script'}},
	['Mlym'] = {numeric='347', name='Malayalam', nameFr='malayâlam', pva='Malayalam', direction='ltr', type='living', status='registered', parent='Gran', extensionsWith={'Deva','Taml'}},
	['Modi'] = {numeric='324', name='Modi, Moḍī', nameFr='modî', pva='Modi', direction='ltr', type='historical', status='registered', parent='Deva', extensionsWith={'Deva'}, altnames={'Moḍī'}},
	['Mong'] = {numeric='145', name='Mongolian', nameFr='mongol', pva='Mongolian', direction='ttb', type='living', status='registered', parent='Ougr', extensionsWith={'Phag'}, altnames={'Hudum Mongol bichig','Clear Script','Todo','Manchu'}},
	['Mtei'] = {numeric='337', name='Meitei Mayek (Meithei, Meetei)', nameFr='meitei mayek', pva='Meetei_Mayek', direction='ltr', type='living', status='registered', parent='Brah', altnames={'Meithei','Manipuri script'}},
	['Mult'] = {numeric='323', name='Multani', nameFr='multânî', pva='Multani', direction='ltr', type='historical', status='registered', parent='Brah', extensionsWith={'Guru'}},
	['Mymr'] = {numeric='350', name='Myanmar (Burmese)', nameFr='birman', pva='Myanmar', direction='ltr', type='living', status='registered', parent='Brah', extensionsWith={'Cakm','Kali','Talu'}, altnames={'Burmese'}},
	['Nand'] = {numeric='311', name='Nandinagari', nameFr='nandinâgarî', pva='Nandinagari', direction='ltr', type='historical', status='registered', parent='Brah', extensionsWith={'Deva','Knda'}},
	['Narb'] = {numeric='106', name='Old North Arabian (Ancient North Arabian)', nameFr='nord-arabique', pva='Old_North_Arabian', direction='rtl', type='ancient', status='registered', related={'Sarb'}, altnames={'Ancient North Arabian'}},
	['Nbat'] = {numeric='159', name='Nabataean', nameFr='nabatéen', pva='Nabataean', direction='rtl', type='ancient', status='registered', parent='Armi', related={'Arab'}},
	['Newa'] = {numeric='333', name='Newa, Newar, Newari, Nepāla lipi', nameFr='néwa, néwar, néwari, nepāla lipi', pva='Newa', direction='ltr', type='living', status='registered', parent='Brah', altnames={'Pracalit','Nepāla lipi','Newar'}},
	['Nkoo'] = {numeric='165', name='N’Ko', nameFr='n’ko', pva='Nko', direction='rtl', type='living', status='registered', altnames={'N\'Ko'}},
	['Nshu'] = {numeric='499', name='Nüshu', nameFr='nüshu', pva='Nushu', direction='ttb', type='historical', status='registered', related={'Hani'}, altnames={'Women\'s script'}},

	-- ── O P R ─────────────────────────────────────────────────
	['Ogam'] = {numeric='212', name='Ogham', nameFr='ogam', pva='Ogham', direction='ltr', type='ancient', status='registered'},
	['Olck'] = {numeric='261', name='Ol Chiki (Ol Cemet’, Ol, Santali)', nameFr='ol tchiki', pva='Ol_Chiki', direction='ltr', type='living', status='registered', altnames={'Santali alphabet','Ol Cemet\''}},
	['Orkh'] = {numeric='175', name='Old Turkic, Orkhon Runic', nameFr='orkhon', pva='Old_Turkic', direction='rtl', type='ancient', status='registered', altnames={'Orkhon','Göktürk','Turkic runes'}},
	['Orya'] = {numeric='327', name='Oriya (Odia)', nameFr='oriyâ (odia)', pva='Oriya', direction='ltr', type='living', status='registered', parent='Brah', extensionsWith={'Deva'}, altnames={'Odia'}},
	['Osge'] = {numeric='219', name='Osage', nameFr='osage', pva='Osage', direction='ltr', type='living', status='registered'},
	['Osma'] = {numeric='260', name='Osmanya', nameFr='osmanais', pva='Osmanya', direction='ltr', type='historical', status='registered', altnames={'Cismaaniya'}},
	['Ougr'] = {numeric='143', name='Old Uyghur', nameFr='ancien ouïgour', pva='Old_Uyghur', direction='ttb', type='historical', status='registered', parent='Sogd', related={'Mong'}},
	['Palm'] = {numeric='126', name='Palmyrene', nameFr='palmyrénien', pva='Palmyrene', direction='rtl', type='ancient', status='registered', parent='Armi'},
	['Perm'] = {numeric='227', name='Old Permic', nameFr='ancien permien', pva='Old_Permic', direction='ltr', type='historical', status='registered', extensionsWith={'Cyrl'}, altnames={'Abur','Anbur'}},
	['Phag'] = {numeric='331', name='Phags-pa', nameFr='’phags pa', pva='Phags_Pa', direction='ttb', type='historical', status='registered', parent='Tibt', extensionsWith={'Mong'}, altnames={'ʼPhags-pa'}},
	['Phli'] = {numeric='131', name='Inscriptional Pahlavi', nameFr='pehlevi des inscriptions', pva='Inscriptional_Pahlavi', direction='rtl', type='ancient', status='registered', parent='Armi', related={'Phlp','Avst'}},
	['Phlp'] = {numeric='132', name='Psalter Pahlavi', nameFr='pehlevi des psautiers', pva='Psalter_Pahlavi', direction='rtl', type='ancient', status='registered', parent='Phli', extensionsWith={'Arab','Syrc'}},
	['Phnx'] = {numeric='115', name='Phoenician', nameFr='phénicien', pva='Phoenician', direction='rtl', type='ancient', status='registered', related={'Grek','Armi','Hebr','Sarb','Tfng'}, altnames={'Paleo-Hebrew','Punic'}},
	['Prti'] = {numeric='130', name='Inscriptional Parthian', nameFr='parthe des inscriptions', pva='Inscriptional_Parthian', direction='rtl', type='ancient', status='registered', parent='Armi'},
	['Rjng'] = {numeric='363', name='Rejang (Redjang, Kaganga)', nameFr='redjang (kaganga)', pva='Rejang', direction='ltr', type='living', status='registered', parent='Kawi', altnames={'Kaganga'}},
	['Rohg'] = {numeric='167', name='Hanifi Rohingya', nameFr='hanifi rohingya', pva='Hanifi_Rohingya', direction='rtl', type='living', status='registered', extensionsWith={'Arab'}},
	['Roro'] = {numeric='620', name='Rongorongo', nameFr='rongorongo', direction='boustrophedon', type='undeciphered', status='registered', altnames={'Easter Island script'}},
	['Runr'] = {numeric='211', name='Runic', nameFr='runique', pva='Runic', direction='ltr', type='ancient', status='registered', parent='Ital', altnames={'Futhark','Fuþark','Futhorc'}},

	-- ── S ─────────────────────────────────────────────────────
	['Samr'] = {numeric='123', name='Samaritan', nameFr='samaritain', pva='Samaritan', direction='rtl', type='living', status='registered', parent='Phnx', related={'Hebr'}},
	['Sarb'] = {numeric='105', name='Old South Arabian', nameFr='sud-arabique, himyarite', pva='Old_South_Arabian', direction='rtl', type='ancient', status='registered', related={'Ethi','Narb'}, altnames={'Musnad','Himyaritic','Sabaean'}},
	['Saur'] = {numeric='344', name='Saurashtra', nameFr='saurachtra', pva='Saurashtra', direction='ltr', type='living', status='registered', parent='Brah'},
	['Sgnw'] = {numeric='095', name='SignWriting', nameFr='SignWriting', pva='SignWriting', direction='ttb', type='living', status='registered', altnames={'Sutton SignWriting'}},
	['Shaw'] = {numeric='281', name='Shavian (Shaw)', nameFr='shavien (Shaw)', pva='Shavian', direction='ltr', type='living', status='registered', altnames={'Shaw alphabet'}},
	['Shrd'] = {numeric='319', name='Sharada, Śāradā', nameFr='charada, çâradâ', pva='Sharada', direction='ltr', type='historical', status='registered', parent='Brah', extensionsWith={'Deva'}, altnames={'Śāradā'}},
	['Sidd'] = {numeric='302', name='Siddham, Siddhaṃ, Siddhamātṛkā', nameFr='siddham', pva='Siddham', direction='ltr', type='historical', status='registered', parent='Brah', altnames={'Siddhaṃ','Siddhamātṛkā','Bonji'}},
	['Sind'] = {numeric='318', name='Khudawadi, Sindhi', nameFr='khoudawadî, sindhî', pva='Khudawadi', direction='ltr', type='historical', status='registered', parent='Brah', extensionsWith={'Deva'}, altnames={'Sindhi script'}},
	['Sinh'] = {numeric='348', name='Sinhala', nameFr='singhalais', pva='Sinhala', direction='ltr', type='living', status='registered', parent='Gran', altnames={'Sinhalese'}},
	['Sogd'] = {numeric='141', name='Sogdian', nameFr='sogdien', pva='Sogdian', direction='rtl', type='historical', status='registered', parent='Sogo', related={'Ougr'}},
	['Sogo'] = {numeric='142', name='Old Sogdian', nameFr='ancien sogdien', pva='Old_Sogdian', direction='rtl', type='ancient', status='registered', parent='Armi', related={'Sogd'}},
	['Sora'] = {numeric='398', name='Sora Sompeng', nameFr='sora sompeng', pva='Sora_Sompeng', direction='ltr', type='living', status='registered', altnames={'Sorang Sompeng'}},
	['Soyo'] = {numeric='329', name='Soyombo', nameFr='soyombo', pva='Soyombo', direction='ltr', type='historical', status='registered', parent='Brah'},
	['Sund'] = {numeric='362', name='Sundanese', nameFr='sondanais', pva='Sundanese', direction='ltr', type='living', status='registered', parent='Kawi', altnames={'Aksara Sunda'}},
	['Sylo'] = {numeric='316', name='Syloti Nagri', nameFr='sylotî nâgrî', pva='Syloti_Nagri', direction='ltr', type='living', status='registered', parent='Brah', extensionsWith={'Beng'}},
	['Syrc'] = {numeric='135', name='Syriac', nameFr='syriaque', pva='Syriac', direction='rtl', type='living', status='registered', parent='Armi', related={'Syre','Syrj','Syrn'}, extensionsWith={'Arab'}},
	['Syre'] = {numeric='138', name='Syriac (Estrangelo variant)', nameFr='syriaque (variante estranghélo)', direction='rtl', type='variant', status='registered', parent='Syrc', altnames={'Estrangelo'}},
	['Syrj'] = {numeric='137', name='Syriac (Western variant)', nameFr='syriaque (variante occidentale)', direction='rtl', type='variant', status='registered', parent='Syrc', altnames={'Serto'}},
	['Syrn'] = {numeric='136', name='Syriac (Eastern variant)', nameFr='syriaque (variante orientale)', direction='rtl', type='variant', status='registered', parent='Syrc', altnames={'Madnhaya','Nestorian'}},

	-- ── T U V W X Y ───────────────────────────────────────────
	['Tagb'] = {numeric='373', name='Tagbanwa', nameFr='tagbanoua', pva='Tagbanwa', direction='ltr', type='living', status='registered', parent='Kawi', extensionsWith={'Tglg','Hano','Buhd'}},
	['Takr'] = {numeric='321', name='Takri, Ṭākrī, Ṭāṅkrī', nameFr='tâkrî', pva='Takri', direction='ltr', type='historical', status='registered', parent='Shrd', extensionsWith={'Deva','Dogr'}, altnames={'Ṭākrī'}},
	['Tale'] = {numeric='353', name='Tai Le', nameFr='taï-le', pva='Tai_Le', direction='ltr', type='living', status='registered', parent='Mymr', altnames={'Dehong Dai'}},
	['Talu'] = {numeric='354', name='New Tai Lue', nameFr='nouveau taï-lue', pva='New_Tai_Lue', direction='ltr', type='living', status='registered', parent='Lana'},
	['Taml'] = {numeric='346', name='Tamil', nameFr='tamoul', pva='Tamil', direction='ltr', type='living', status='registered', parent='Brah', related={'Gran','Mlym'}, extensionsWith={'Deva','Gran'}},
	['Tang'] = {numeric='520', name='Tangut', nameFr='tangoute', pva='Tangut', direction='ttb', type='historical', status='registered', related={'Hani'}, altnames={'Xixia','Western Xia script'}},
	['Tavt'] = {numeric='359', name='Tai Viet', nameFr='taï viêt', pva='Tai_Viet', direction='ltr', type='living', status='registered', parent='Brah', altnames={'Chữ Thái Việt','Tai Dam'}},
	['Telu'] = {numeric='340', name='Telugu', nameFr='télougou', pva='Telugu', direction='ltr', type='living', status='registered', parent='Brah', related={'Knda'}, extensionsWith={'Deva','Knda'}},
	['Tfng'] = {numeric='120', name='Tifinagh (Berber)', nameFr='tifinagh (berbère)', pva='Tifinagh', direction='ltr', type='living', status='registered', parent='Phnx', altnames={'Berber','Neo-Tifinagh','Libyco-Berber'}},
	['Tglg'] = {numeric='370', name='Tagalog (Baybayin, Alibata)', nameFr='tagal (baybayin, alibata)', pva='Tagalog', direction='ltr', type='historical', status='registered', parent='Kawi', extensionsWith={'Hano','Buhd','Tagb'}, altnames={'Baybayin','Alibata'}},
	['Thaa'] = {numeric='170', name='Thaana', nameFr='thâna', pva='Thaana', direction='rtl', type='living', status='registered', extensionsWith={'Arab'}},
	['Thai'] = {numeric='352', name='Thai', nameFr='thaï', pva='Thai', direction='ltr', type='living', status='registered', parent='Khmr', related={'Laoo','Tavt'}},
	['Tibt'] = {numeric='330', name='Tibetan', nameFr='tibétain', pva='Tibetan', direction='ltr', type='living', status='registered', parent='Brah', related={'Phag','Marc','Lepc'}},
	['Tirh'] = {numeric='326', name='Tirhuta', nameFr='tirhouta', pva='Tirhuta', direction='ltr', type='living', status='registered', parent='Brah', extensionsWith={'Deva','Beng'}, altnames={'Mithilakshar'}},
	['Ugar'] = {numeric='040', name='Ugaritic', nameFr='ougaritique', pva='Ugaritic', direction='ltr', type='ancient', status='registered', related={'Xsux','Phnx'}, altnames={'Ugaritic cuneiform'}},
	['Vaii'] = {numeric='470', name='Vai', nameFr='vaï', pva='Vai', direction='ltr', type='living', status='registered'},
	['Vith'] = {numeric='228', name='Vithkuqi', nameFr='vithkuqi', pva='Vithkuqi', direction='ltr', type='historical', status='registered', altnames={'Büthakukye'}},
	['Wcho'] = {numeric='283', name='Wancho', nameFr='wantcho', pva='Wancho', direction='ltr', type='living', status='registered'},
	['Xpeo'] = {numeric='030', name='Old Persian', nameFr='cunéiforme perse', pva='Old_Persian', direction='ltr', type='ancient', status='registered', related={'Xsux'}, altnames={'Old Persian cuneiform'}},
	['Xsux'] = {numeric='020', name='Cuneiform, Sumero-Akkadian', nameFr='cunéiforme suméro-akkadien', pva='Cuneiform', direction='ltr', type='ancient', status='registered', related={'Ugar','Xpeo'}, altnames={'Sumero-Akkadian cuneiform','Sumerian cuneiform','Akkadian cuneiform','Assyrian cuneiform','Hittite cuneiform'}},
	['Yezi'] = {numeric='192', name='Yezidi', nameFr='yézidi', pva='Yezidi', direction='rtl', type='historical', status='registered'},
	['Yiii'] = {numeric='460', name='Yi', nameFr='yi', pva='Yi', direction='ltr', type='living', status='registered', extensionsWith={'Hani'}, altnames={'Nuosu','Liangshan Yi'}},

	-- ── Q Z (Private-use & Special ISO 15924 codes) ───────────
	['Zanb'] = {numeric='339', name='Zanabazar Square (Zanabazarin Dörböljin Useg, Xewtee Dörböljin Bicig, Horizontal Square Script)', nameFr='carré zanabazar', pva='Zanabazar_Square', direction='ltr', type='historical', status='registered', parent='Brah', altnames={'Horizontal Square Script'}},
	['Qaaa'] = {numeric='900', name='Reserved for private use (start)', nameFr='réservé à l’usage privé (début)', direction='varies', type='private-use', status='private-use'},
	['Qabx'] = {numeric='949', name='Reserved for private use (end)', nameFr='réservé à l’usage privé (fin)', direction='varies', type='private-use', status='private-use'},
	['Zsye'] = {numeric='993', name='Symbols (Emoji variant)', nameFr='symboles (variante émoji)', direction='varies', type='special', status='special', related={'Zsym'}, altnames={'Emoji'}},
	['Zinh'] = {numeric='994', name='Code for inherited script', nameFr='codet pour écriture héritée', pva='Inherited', direction='varies', type='special', status='special', deprecatedAliases={'Qaai'}},
	['Zmth'] = {numeric='995', name='Mathematical notation', nameFr='notation mathématique', direction='ltr', type='special', status='special'},
	['Zsym'] = {numeric='996', name='Symbols', nameFr='symboles', direction='varies', type='special', status='special'},
	['Zxxx'] = {numeric='997', name='Code for unwritten documents', nameFr='codet pour les documents non écrits', direction='varies', type='special', status='special'},
	['Zyyy'] = {numeric='998', name='Code for undetermined script', nameFr='codet pour écriture indéterminée', pva='Common', direction='varies', type='special', status='special'},
	['Zzzz'] = {numeric='999', name='Code for uncoded script', nameFr='codet pour écriture non codée', pva='Unknown', direction='varies', type='special', status='special'},
}

-- ============================================================
-- 2. Nạp /tran (bản dịch DRY) & dữ liệu Unicode (nếu có)
-- ============================================================
local function loadOptionalTable(modName)
	if mw and mw.loadData then
		local ok, d = pcall(mw.loadData, modName)
		if ok and type(d) == 'table' then return d end
	end
	local ok, d = pcall(require, modName)
	if ok and type(d) == 'table' then return d end
	return nil
end

local tranData = loadOptionalTable('Module:I18n/ISO 15924/tran')
	or loadOptionalTable('Module:I18n/ISO 15924/data')
	or {}
-- Hỗ trợ cả cấu trúc bảng dịch phẳng { ['Latn'] = { vi = ... } }
-- lẫn cấu trúc mở rộng { scripts = { ... } }
local extraScripts = type(tranData.scripts) == 'table' and tranData.scripts or nil
if extraScripts then
	tranData = type(tranData.translations) == 'table' and tranData.translations or {}
end

local unicodeData = loadOptionalTable('Module:I18n/Unicode/data')

-- ============================================================
-- 3. Unified alias registry (Module:I18n/Alias)
--    Đồng bộ: Alpha-4 > Numeric / Unicode PVA > Tên EN/FR
--             > Deprecated (Qaai) > Bản dịch (/tran) > altnames.
-- ============================================================
local Alias = require('Module:I18n/Alias')
local NS = 'iso15924'

local function normalize(s)
	local k = Alias.normalizers.default(s)
	if k:match('^%d%d?$') then k = string.rep('0', 3 - #k) .. k end
	-- Hỗ trợ đối sánh tên PVA có dấu gạch dưới (vd: "Egyptian_Hieroglyphs")
	k = k:gsub('_', ' ')
	return k
end

local function sortedKeys(t)
	local keys = {}
	for k in pairs(t) do keys[#keys + 1] = k end
	table.sort(keys)
	return keys
end

local function activeRecords()
	if not extraScripts then return baseData end
	local merged = {}
	for k, v in pairs(baseData) do merged[k] = v end
	for k, v in pairs(extraScripts) do merged[k] = v end
	return merged
end

local function loader(api)
	local records = activeRecords()
	local codes = sortedKeys(records)

	for _, code in ipairs(codes) do
		local r = records[code]
		api.addRecord(code, r)
		if r.numeric then api.register(r.numeric, code, 'official') end
		if r.pva then
			api.register(r.pva, code, 'official')
			local spaced = r.pva:gsub('_', ' ')
			if spaced ~= r.pva then api.register(spaced, code, 'official') end
		end
		if r.name   then api.register(r.name, code, 'name') end
		if r.nameFr then api.register(r.nameFr, code, 'name') end
		if r.deprecatedAliases then
			for _, dep in ipairs(r.deprecatedAliases) do api.register(dep, code, 'deprecated') end
		end
		if r.altnames then
			for _, alt in ipairs(r.altnames) do api.register(alt, code, 'project') end
		end
	end

	-- Đồng bộ hai chiều với bảng PropertyValueAliases `sc` từ Module:I18n/Unicode/data
	local sc = unicodeData and unicodeData.values and unicodeData.values.sc
	if sc then
		for _, v in ipairs(sc) do
			if v.short and records[v.short] then
				if v.long then api.register(v.long, v.short, 'official') end
				if v.aliases then
					for _, a in ipairs(v.aliases) do api.register(a, v.short, 'official') end
				end
				if v.deprecated then
					for _, d in ipairs(v.deprecated) do api.register(d, v.short, 'deprecated') end
				end
			end
		end
	end

	for _, code in ipairs(codes) do
		local row = tranData[code]
		if type(row) == 'table' then
			for _, lang in ipairs(sortedKeys(row)) do
				api.register(row[lang], code, 'translation')
			end
		end
	end
end

Alias.define(NS, { loader = loader, normalize = normalize })

-- ============================================================
-- 4. Public API
-- ============================================================

--- Phân giải mã Alpha-4, mã số 3 chữ số, PVA, tên hoặc alias về mã chuẩn Alpha-4.
--  @return code, kind | nil, info
function M.resolve(input)
	return Alias.resolve(NS, input)
end

--- Trả về toàn bộ metadata của một hệ chữ viết.
function M.getData(code)
	if not code then return nil end
	local records = activeRecords()
	local c = Alias.resolve(NS, code)
	return c and records[c] or nil
end

--- Liệt kê danh sách tất cả mã Alpha-4 (tùy chọn lọc theo `type`: 'ancient', 'historical', 'living'…).
function M.getAllCodes(filterType)
	local all = Alias.getCanonicals(NS)
	if not filterType then return all end
	local records = activeRecords()
	local out = {}
	for _, c in ipairs(all) do
		if records[c] and records[c].type == filterType then
			out[#out + 1] = c
		end
	end
	return out
end

--- Tra ngược mọi alias của một mã hệ chữ.
function M.getAliases(code)
	local c = Alias.resolve(NS, code)
	return c and Alias.getAliases(NS, c) or {}
end

--- Kiểm tra toàn vẹn dữ liệu & xung đột alias.
function M.validate()
	return Alias.validate(NS)
end

--- Thông tin nguồn chuẩn & phiên bản.
function M.getMeta()
	return M._meta
end

--- Tra cứu tên hệ chữ viết theo ngôn ngữ đích.
--  Thứ tự: /tran[targetLang] → /tran[fallbacks] → nameFr (khi lang='fr') → name (tiếng Anh).
function M.getName(code, targetLang, fallbacks)
	if not code then return nil end
	local records = activeRecords()
	local c = Alias.resolve(NS, code)
	local r = c and records[c]
	if not r then return code end

	if not targetLang or targetLang == 'en' then
		return r.name or c
	end

	local function checkTran(lang)
		local row = tranData[c]
		return lang and row and row[lang] or nil
	end

	-- A. Đích danh ngôn ngữ yêu cầu
	local result = checkTran(targetLang)
	if result then return result end

	-- B. Quét chuỗi fallback (không chạm 'en')
	if fallbacks and fallbacks[targetLang] then
		for _, fl in ipairs(fallbacks[targetLang]) do
			if fl == 'en' then break end
			result = checkTran(fl)
			if result then return result end
		end
	end

	-- C. Tên tiếng Pháp chính thức từ chuẩn ISO 15924 nếu cần 'fr'
	if targetLang == 'fr' and r.nameFr then
		return r.nameFr
	end

	-- D. DRY Fallback về tên tiếng Anh chuẩn
	return r.name or c
end

return M
