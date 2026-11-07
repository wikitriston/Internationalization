--  ============================================================
--  Module:I18n/ISO 15924/tran
--  Bảng dịch tên hệ chữ viết (ISO 15924) sang các ngôn ngữ khác
--
--  Quy tắc DRY bắt buộc:
--    · Key ngoài = mã Alpha-4 ISO 15924 (Titlecase, ví dụ: 'Latn', 'Hani')
--    · Key trong = mã ngôn ngữ đích (BCP 47 lowercase)
--    · KHÔNG khai báo tên tiếng Anh ('en') → đã có trong baseData
--    · Tên tiếng Pháp chuẩn ISO ('nameFr') đã có sẵn trong baseData;
--      chỉ khai báo 'fr' khi cần dạng viết hoa tiêu chuẩn hiển thị
--    · KHÔNG khai báo ngôn ngữ nào nếu tên giống hệt tiếng Anh
--
--  Nguồn tham chiếu:
--    · Unicode CLDR Script Names & ISO 15924 Registration Authority
--  ============================================================

-- luacheck: ignore
return {

-- ── A B ──────────────────────────────────────────────────────
['Adlm'] = {
	vi = 'Chữ Adlam',
	zh = '阿德拉姆文', ['zh-hant'] = '阿德拉姆文',
	ru = 'Адлам', ar = 'أدلام', ja = 'アドラム文字', ko = '아들람 문자',
},
['Aghb'] = {
	vi = 'Chữ Albania Kavkaz',
	zh = '高加索阿尔巴尼亚文', ['zh-hant'] = '高加索阿爾巴尼亞文',
	de = 'Kaukasisch-Albanisch', es = 'Albanés caucásico',
	ru = 'Кавказско-албанское письмо', ja = 'カフカス・アルバニア文字', ko = '코카서스 알바니아 문자',
},
['Ahom'] = {
	vi = 'Chữ Ahom',
	zh = '阿洪姆文', ['zh-hant'] = '阿洪姆文',
	ru = 'Ахом', ja = 'アーホム文字', ko = '아홈 문자',
},
['Arab'] = {
	vi = 'Chữ Ả Rập',
	zh = '阿拉伯文', ['zh-hant'] = '阿拉伯文',
	fr = 'Arabe', de = 'Arabisch', es = 'Árabe', it = 'Arabo', pt = 'Árabe',
	ru = 'Арабское письмо', ar = 'العربية', ja = 'アラビア文字', ko = '아랍 문자',
},
['Aran'] = {
	vi = 'Chữ Ả Rập Nastaliq',
	zh = '波斯体阿拉伯文', ['zh-hant'] = '波斯體阿拉伯文',
	de = 'Arabisch (Nastaliq)', es = 'Árabe nastaliq',
	ru = 'Насталик', ar = 'نستعليق', ja = 'ナスタアリーク体', ko = '나스탈리크체',
},
['Armi'] = {
	vi = 'Chữ Aram Đế quốc',
	zh = '帝国亚拉姆文', ['zh-hant'] = '帝國亞拉姆文',
	de = 'Reichsaramäisch', es = 'Arameo imperial',
	ru = 'Имперское арамейское письмо', ar = 'الآرامية الإمبراطورية',
	ja = '帝国アラム文字', ko = '제국 아람 문자',
},
['Armn'] = {
	vi = 'Chữ Armenia',
	zh = '亚美尼亚文', ['zh-hant'] = '亞美尼亞文',
	fr = 'Arménien', de = 'Armenisch', es = 'Armenio', it = 'Armeno', pt = 'Armênio',
	ru = 'Армянское письмо', ar = 'الأرمنية', ja = 'アルメニア文字', ko = '아르메니아 문자',
},
['Avst'] = {
	vi = 'Chữ Avesta',
	zh = '阿维斯陀文', ['zh-hant'] = '阿維斯陀文',
	de = 'Avestisch', es = 'Avéstico',
	ru = 'Авестийское письмо', ar = 'الأفستية', ja = 'アヴェスター文字', ko = '아베스타 문자',
},
['Bali'] = {
	vi = 'Chữ Bali',
	zh = '巴厘文', ['zh-hant'] = '峇里文',
	de = 'Balinesisch', es = 'Balinés',
	ru = 'Балийское письмо', ar = 'البالية', ja = 'バリ文字', ko = '발리 문자',
},
['Bamu'] = {
	vi = 'Chữ Bamum',
	zh = '巴姆穆文', ['zh-hant'] = '巴姆穆文',
	ru = 'Бамум', ja = 'バムン文字', ko = '바뭄 문자',
},
['Batk'] = {
	vi = 'Chữ Batak',
	zh = '巴塔克文', ['zh-hant'] = '巴塔克文',
	ru = 'Батакское письмо', ja = 'バタック文字', ko = '바탁 문자',
},
['Beng'] = {
	vi = 'Chữ Bengal',
	zh = '孟加拉文', ['zh-hant'] = '孟加拉文',
	de = 'Bengalisch', es = 'Bengalí', it = 'Bengalese',
	ru = 'Бенгальское письмо', ar = 'البنغالية', ja = 'ベンガル文字', ko = '벵골 문자',
},
['Bopo'] = {
	vi = 'Chú âm phù hiệu (Bopomofo)',
	zh = '注音符号', ['zh-hant'] = '注音符號',
	ru = 'Чжуинь', ar = 'بوبوموفو', ja = '注音字母', ko = '주음부호',
},
['Brah'] = {
	vi = 'Chữ Brahmi',
	zh = '婆罗米文', ['zh-hant'] = '婆羅米文',
	ru = 'Брахми', ar = 'البراهمية', ja = 'ブラーフミー文字', ko = '브라흐미 문자',
},
['Brai'] = {
	vi = 'Chữ nổi Braille',
	zh = '盲文', ['zh-hant'] = '點字',
	de = 'Brailleschrift',
	ru = 'Шрифт Брайля', ar = 'برايل', ja = 'ブライユ点字', ko = '브라유 점자',
},
['Bugi'] = {
	vi = 'Chữ Bugis (Lontara)',
	zh = '布吉文', ['zh-hant'] = '布吉文',
	de = 'Buginesisch', es = 'Buginés',
	ru = 'Бугийское письмо', ja = 'ブギス文字', ko = '부기 문자',
},
['Buhd'] = {
	vi = 'Chữ Buhid',
	zh = '布希德文', ['zh-hant'] = '布希德文',
	ru = 'Бухид', ja = 'ブヒッド文字', ko = '부히드 문자',
},

-- ── C D E ────────────────────────────────────────────────────
['Cakm'] = {
	vi = 'Chữ Chakma',
	zh = '查克马文', ['zh-hant'] = '查克馬文',
	ru = 'Чакма', ja = 'チャクマ文字', ko = '차크마 문자',
},
['Cans'] = {
	vi = 'Âm tiết thổ dân Canada thống nhất',
	zh = '加拿大原住民统一音节文字', ['zh-hant'] = '加拿大原住民統一音節文字',
	de = 'Kanadische Silbenschrift', es = 'Silabario aborigen canadiense unificado',
	ru = 'Канадское слоговое письмо', ja = '統合カナダ先住民音節文字', ko = '통합 캐나다 토착민 음절문자',
},
['Cari'] = {
	vi = 'Chữ Caria',
	zh = '卡里亚文', ['zh-hant'] = '卡里亞文',
	de = 'Karisch', es = 'Cario',
	ru = 'Карийское письмо', ja = 'カリア文字', ko = '카리아 문자',
},
['Cham'] = {
	vi = 'Chữ Chăm',
	zh = '占文', ['zh-hant'] = '占文',
	ru = 'Чамское письмо', ja = 'チャム文字', ko = '참 문자',
},
['Cher'] = {
	vi = 'Chữ Cherokee',
	zh = '切罗基文', ['zh-hant'] = '切羅基文',
	ru = 'Чероки', ar = 'الشيروكية', ja = 'チェロキー文字', ko = '체로키 문자',
},
['Copt'] = {
	vi = 'Chữ Copt',
	zh = '科普特文', ['zh-hant'] = '科普特文',
	de = 'Koptisch', es = 'Copto', it = 'Copto', pt = 'Copta',
	ru = 'Коптское письмо', ar = 'القبطية', ja = 'コプト文字', ko = '콥트 문자',
},
['Cpmn'] = {
	vi = 'Chữ Síp-Minoa',
	zh = '塞浦路斯-米诺斯文', ['zh-hant'] = '賽普勒斯-米諾斯文',
	de = 'Kypro-Minoisch', es = 'Chiprominoico',
	ru = 'Кипро-минойское письмо', ja = 'キュプロ・ミノア文字', ko = '키프로스 미노아 문자',
},
['Cprt'] = {
	vi = 'Âm tiết Síp cổ',
	zh = '塞浦路斯音节文字', ['zh-hant'] = '賽普勒斯音節文字',
	de = 'Kyprische Silbenschrift', es = 'Silabario chipriota',
	ru = 'Кипрское слоговое письмо', ja = 'キプロス音節文字', ko = '키프로스 음절문자',
},
['Cyrl'] = {
	vi = 'Chữ Kirin',
	zh = '西里尔文', ['zh-hant'] = '西里爾文',
	fr = 'Cyrillique', de = 'Kyrillisch', es = 'Cirílico', it = 'Cirillico', pt = 'Cirílico',
	ru = 'Кириллица', ar = 'السيريلية', ja = 'キリル文字', ko = '키릴 문자',
},
['Cyrs'] = {
	vi = 'Chữ Kirin Slavơ Nhà thờ cổ',
	zh = '古教会斯拉夫西里尔文', ['zh-hant'] = '古教會斯拉夫西里爾文',
	de = 'Altkirchenslawisch-Kyrillisch', es = 'Cirílico eslavo eclesiástico antiguo',
	ru = 'Старославянская кириллица', ja = '古代教会スラヴ語キリル文字', ko = '고대 교회 슬라브어 키릴 문자',
},
['Deva'] = {
	vi = 'Chữ Devanagari',
	zh = '天城文', ['zh-hant'] = '天城文',
	ru = 'Деванагари', ar = 'الديفاناغارية', ja = 'デーヴァナーガリー', ko = '데바나가리 문자',
},
['Egyd'] = {
	vi = 'Chữ bình dân Ai Cập (Demotic)',
	zh = '埃及世俗体', ['zh-hant'] = '埃及世俗體',
	de = 'Demotisch', es = 'Demótico egipcio',
	ru = 'Демотическое письмо', ar = 'الديموطيقية المصرية', ja = 'デモティック', ko = '민중문자',
},
['Egyh'] = {
	vi = 'Chữ thầy tu Ai Cập (Hieratic)',
	zh = '埃及僧侣体', ['zh-hant'] = '埃及僧侶體',
	de = 'Hieratisch', es = 'Hierático egipcio',
	ru = 'Иератическое письмо', ar = 'الهيراطيقية المصرية', ja = 'ヒエラティック', ko = '신관문자',
},
['Egyp'] = {
	vi = 'Chữ tượng hình Ai Cập',
	zh = '埃及圣书体', ['zh-hant'] = '埃及聖書體',
	de = 'Ägyptische Hieroglyphen', es = 'Jeroglíficos egipcios', it = 'Geroglifici egizi', pt = 'Hieróglifos egípcios',
	ru = 'Египетские иероглифы', ar = 'الهيروغليفية المصرية', ja = 'エジプト聖刻文字', ko = '이집트 상형문자',
},
['Ethi'] = {
	vi = 'Chữ Ethiopia (Geʻez)',
	zh = '埃塞俄比亚文', ['zh-hant'] = '衣索比亞文',
	de = 'Äthiopisch', es = 'Etíope', it = 'Etiopico',
	ru = 'Эфиопское письмо', ar = 'الجعزية', ja = 'エチオピア文字', ko = '에티오피아 문자',
},

-- ── G H I J K ────────────────────────────────────────────────
['Geok'] = {
	vi = 'Chữ Khutsuri Gruzia cổ',
	zh = '格鲁吉亚教会体', ['zh-hant'] = '喬治亞教會體',
	ru = 'Хуцури', ja = 'フツリ', ko = '후추리 문자',
},
['Geor'] = {
	vi = 'Chữ Gruzia',
	zh = '格鲁吉亚文', ['zh-hant'] = '喬治亞文',
	de = 'Georgisch', es = 'Georgiano', it = 'Georgiano', pt = 'Georgiano',
	ru = 'Грузинское письмо', ar = 'الجورجية', ja = 'ジョージア文字', ko = '조지아 문자',
},
['Glag'] = {
	vi = 'Chữ Glagolitic',
	zh = '格拉哥里文', ['zh-hant'] = '格拉哥里文',
	de = 'Glagolitisch', es = 'Glagolítico', it = 'Glagolitico',
	ru = 'Глаголица', ar = 'الغلاغوليتسية', ja = 'グラゴル文字', ko = '글라골 문자',
},
['Goth'] = {
	vi = 'Chữ Goth',
	zh = '哥特文', ['zh-hant'] = '哥德文',
	de = 'Gotisch', es = 'Gótico', it = 'Gotico', pt = 'Gótico',
	ru = 'Готское письмо', ar = 'القوطية', ja = 'ゴート文字', ko = '고트 문자',
},
['Gran'] = {
	vi = 'Chữ Grantha',
	zh = '格兰塔文', ['zh-hant'] = '格蘭塔文',
	ru = 'Грантха', ja = 'グランタ文字', ko = '그란타 문자',
},
['Grek'] = {
	vi = 'Chữ Hy Lạp',
	zh = '希腊文', ['zh-hant'] = '希臘文',
	fr = 'Grec', de = 'Griechisch', es = 'Griego', it = 'Greco', pt = 'Grego',
	ru = 'Греческое письмо', ar = 'اليونانية', ja = 'ギリシア文字', ko = '그리스 문자',
},
['Gujr'] = {
	vi = 'Chữ Gujarat',
	zh = '古吉拉特文', ['zh-hant'] = '古吉拉特文',
	ru = 'Гуджарати', ar = 'الكجراتية', ja = 'グジャラート文字', ko = '구자라트 문자',
},
['Guru'] = {
	vi = 'Chữ Gurmukhi',
	zh = '古木基文', ['zh-hant'] = '古木基文',
	ru = 'Гурмукхи', ar = 'الكرمكهي', ja = 'グルムキー文字', ko = '구르무키 문자',
},
['Hanb'] = {
	vi = 'Chữ Hán kèm Chú âm',
	zh = '汉字注音混合', ['zh-hant'] = '漢字注音混合',
	ja = '漢字（注音符号付き）', ko = '주음 병기 한자',
},
['Hang'] = {
	vi = 'Chữ Hangul',
	zh = '谚文', ['zh-hant'] = '諺文',
	de = 'Hangul', es = 'Hangul',
	ru = 'Хангыль', ar = 'الهانغول', ja = 'ハングル', ko = '한글',
},
['Hani'] = {
	vi = 'Chữ Hán (Hán-Nôm)',
	zh = '汉字', ['zh-hant'] = '漢字',
	de = 'Chinesische Schrift', es = 'Sinogramas Han',
	ru = 'Китайское письмо', ar = 'المقاطع الصينية (هان)', ja = '漢字', ko = '한자',
},
['Hans'] = {
	vi = 'Chữ Hán giản thể',
	zh = '简体中文', ['zh-hant'] = '簡體漢字',
	de = 'Vereinfachtes Chinesisch', es = 'Han simplificado',
	ru = 'Упрощённое китайское письмо', ar = 'الهان المبسطة', ja = '簡体字', ko = '간체자',
},
['Hant'] = {
	vi = 'Chữ Hán phồn thể',
	zh = '繁体中文', ['zh-hant'] = '繁體漢字',
	de = 'Traditionelles Chinesisch', es = 'Han tradicional',
	ru = 'Традиционное китайское письмо', ar = 'الهان التقليدية', ja = '繁体字', ko = '번체자',
},
['Hebr'] = {
	vi = 'Chữ Do Thái (Hebrew)',
	zh = '希伯来文', ['zh-hant'] = '希伯來文',
	fr = 'Hébreu', de = 'Hebräisch', es = 'Hebreo', it = 'Ebraico', pt = 'Hebraico',
	ru = 'Еврейское письмо', ar = 'العبرية', ja = 'ヘブライ文字', ko = '히브리 문자',
},
['Hira'] = {
	vi = 'Chữ Hiragana',
	zh = '平假名', ['zh-hant'] = '平假名',
	ru = 'Хирагана', ar = 'الهيراغانا', ja = 'ひらがな', ko = '히라가나',
},
['Hluw'] = {
	vi = 'Chữ tượng hình Anatolia',
	zh = '安纳托利亚象形文字', ['zh-hant'] = '安納托利亞象形文字',
	de = 'Anatolische Hieroglyphen', es = 'Jeroglíficos anatolios',
	ru = 'Анатолийские иероглифы', ja = 'アナトリア象形文字', ko = '아나톨리아 상형문자',
},
['Hrkt'] = {
	vi = 'Chữ âm tiết tiếng Nhật (Kana)',
	zh = '假名', ['zh-hant'] = '日文假名',
	ru = 'Кана', ja = '仮名', ko = '가나',
},
['Hung'] = {
	vi = 'Chữ Hungary cổ (Rovás)',
	zh = '古匈牙利文', ['zh-hant'] = '古匈牙利文',
	de = 'Altungarisch', es = 'Húngaro antiguo',
	ru = 'Венгерские руны', ja = '古ハンガリー文字', ko = '고대 헝가리 문자',
},
['Inds'] = {
	vi = 'Chữ sông Ấn (Harappa)',
	zh = '印度河文字', ['zh-hant'] = '印度河文字',
	de = 'Indus-Schrift', es = 'Escritura del Indo',
	ru = 'Письмо долины Инда', ja = 'インダス文字', ko = '인더스 문자',
},
['Ital'] = {
	vi = 'Chữ Ý cổ (Etrusca)',
	zh = '古意大利字母', ['zh-hant'] = '古義大利字母',
	de = 'Altitalisch', es = 'Itálico antiguo',
	ru = 'Древнеиталийское письмо', ja = '古代イタリア文字', ko = '고대 이탈리아 문자',
},
['Java'] = {
	vi = 'Chữ Java',
	zh = '爪哇文', ['zh-hant'] = '爪哇文',
	de = 'Javanisch', es = 'Javanés',
	ru = 'Яванское письмо', ar = 'الجاوية', ja = 'ジャワ文字', ko = '자와 문자',
},
['Jpan'] = {
	vi = 'Hệ chữ Nhật Bản',
	zh = '日文文字体系', ['zh-hant'] = '日文文字體系',
	de = 'Japanische Schrift', es = 'Escritura japonesa',
	ru = 'Японское письмо', ar = 'الكتابة اليابانية', ja = '日本語の文字', ko = '일본 문자',
},
['Jurc'] = {
	vi = 'Chữ Nữ Chân',
	zh = '女真文', ['zh-hant'] = '女真文',
	ru = 'Чжурчжэньское письмо', ja = '女真文字', ko = '여진 문자',
},
['Kana'] = {
	vi = 'Chữ Katakana',
	zh = '片假名', ['zh-hant'] = '片假名',
	ru = 'Катакана', ar = 'الكاتاكانا', ja = 'カタカナ', ko = '가타카나',
},
['Kawi'] = {
	vi = 'Chữ Kawi',
	zh = '卡维文', ['zh-hant'] = '卡維文',
	ru = 'Кави', ja = 'カウィ文字', ko = '카위 문자',
},
['Khar'] = {
	vi = 'Chữ Kharoshthi',
	zh = '佉卢文', ['zh-hant'] = '佉盧文',
	ru = 'Кхароштхи', ar = 'الخروشتية', ja = 'カローシュティー文字', ko = '카로슈티 문자',
},
['Khmr'] = {
	vi = 'Chữ Khmer',
	zh = '高棉文', ['zh-hant'] = '高棉文',
	de = 'Khmer-Schrift', es = 'Jemer',
	ru = 'Кхмерское письмо', ar = 'الخميرية', ja = 'クメール文字', ko = '크메르 문자',
},
['Kitl'] = {
	vi = 'Chữ Khiết Đan lớn',
	zh = '契丹大字', ['zh-hant'] = '契丹大字',
	ru = 'Киданьское большое письмо', ja = '契丹大字', ko = '거란 대자',
},
['Kits'] = {
	vi = 'Chữ Khiết Đan nhỏ',
	zh = '契丹小字', ['zh-hant'] = '契丹小字',
	ru = 'Киданьское малое письмо', ja = '契丹小字', ko = '거란 소자',
},
['Knda'] = {
	vi = 'Chữ Kannada',
	zh = '卡纳达文', ['zh-hant'] = '卡納達文',
	ru = 'Каннада', ar = 'الكنادية', ja = 'カンナダ文字', ko = '칸나다 문자',
},
['Kore'] = {
	vi = 'Hệ chữ Hàn Quốc (Hangul + Hán)',
	zh = '韩文混合体系', ['zh-hant'] = '韓文混合體系',
	de = 'Koreanische Schrift', es = 'Escritura coreana',
	ru = 'Корейское смешанное письмо', ja = '韓国語の文字', ko = '국한문혼용',
},

-- ── L M N O P R ──────────────────────────────────────────────
['Lana'] = {
	vi = 'Chữ Tai Tham (Lanna)',
	zh = '老傣文', ['zh-hant'] = '老傣文',
	ru = 'Ланна', ja = 'ラーンナー文字', ko = '란나 문자',
},
['Laoo'] = {
	vi = 'Chữ Lào',
	zh = '老挝文', ['zh-hant'] = '寮文',
	de = 'Laotisch', es = 'Laosiano',
	ru = 'Лаосское письмо', ar = 'اللاوية', ja = 'ラーオ文字', ko = '라오 문자',
},
['Latf'] = {
	vi = 'Chữ Latinh Fraktur',
	zh = '德文尖角体拉丁文', ['zh-hant'] = '德文尖角體拉丁文',
	de = 'Lateinisch (Fraktur)', es = 'Latín fraktur',
	ru = 'Фрактура', ja = 'フラクトゥール', ko = '프락투어',
},
['Latg'] = {
	vi = 'Chữ Latinh Gael',
	zh = '盖尔体拉丁文', ['zh-hant'] = '蓋爾體拉丁文',
	de = 'Lateinisch (Gälisch)', es = 'Latín gaélico',
	ru = 'Гэльский латинский шрифт', ja = 'ゲール文字', ko = '게일 문자',
},
['Latn'] = {
	vi = 'Chữ Latinh',
	zh = '拉丁文', ['zh-hant'] = '拉丁文',
	de = 'Lateinisch', es = 'Latino', it = 'Latino', pt = 'Latino',
	ru = 'Латиница', ar = 'اللاتينية', ja = 'ラテン文字', ko = '로마자',
},
['Lina'] = {
	vi = 'Chữ Linear A',
	zh = '线形文字A', ['zh-hant'] = '線形文字A',
	de = 'Linear-A-Schrift', es = 'Lineal A',
	ru = 'Линейное письмо А', ja = '線文字A', ko = '선문자 A',
},
['Linb'] = {
	vi = 'Chữ Linear B',
	zh = '线形文字B', ['zh-hant'] = '線形文字B',
	de = 'Linear-B-Schrift', es = 'Lineal B',
	ru = 'Линейное письмо Б', ja = '線文字B', ko = '선문자 B',
},
['Lyci'] = {
	vi = 'Chữ Lycia',
	zh = '吕基亚文', ['zh-hant'] = '呂基亞文',
	de = 'Lykisch', es = 'Licio',
	ru = 'Ликийское письмо', ja = 'リュキア文字', ko = '리키아 문자',
},
['Lydi'] = {
	vi = 'Chữ Lydia',
	zh = '吕底亚文', ['zh-hant'] = '呂底亞文',
	de = 'Lydisch', es = 'Lidio',
	ru = 'Лидийское письмо', ja = 'リュディア文字', ko = '리디아 문자',
},
['Mani'] = {
	vi = 'Chữ Minh giáo (Manichaean)',
	zh = '摩尼文', ['zh-hant'] = '摩尼文',
	de = 'Manichäisch', es = 'Maniqueo',
	ru = 'Манихейское письмо', ja = 'マニ文字', ko = '마니 문자',
},
['Maya'] = {
	vi = 'Chữ tượng hình Maya',
	zh = '玛雅象形文字', ['zh-hant'] = '馬雅象形文字',
	de = 'Maya-Schrift', es = 'Jeroglíficos mayas',
	ru = 'Письмо майя', ar = 'الهيروغليفية المايانية', ja = 'マヤ文字', ko = '마야 문자',
},
['Merc'] = {
	vi = 'Chữ thảo Meroë',
	zh = '麦罗埃草书', ['zh-hant'] = '麥羅埃草書',
	ru = 'Мероитское курсивное письмо', ja = 'メロエ草書体', ko = '메로에 필기체',
},
['Mero'] = {
	vi = 'Chữ tượng hình Meroë',
	zh = '麦罗埃圣书体', ['zh-hant'] = '麥羅埃聖書體',
	ru = 'Мероитские иероглифы', ja = 'メロエ聖刻文字', ko = '메로에 상형문자',
},
['Mlym'] = {
	vi = 'Chữ Malayalam',
	zh = '马拉雅拉姆文', ['zh-hant'] = '馬拉雅拉姆文',
	ru = 'Малаялам', ar = 'الماليالامية', ja = 'マラヤーラム文字', ko = '말라얄람 문자',
},
['Mong'] = {
	vi = 'Chữ Mông Cổ truyền thống',
	zh = '传统蒙古文', ['zh-hant'] = '傳統蒙古文',
	de = 'Mongolische Schrift', es = 'Mongol tradicional',
	ru = 'Старомонгольское письмо', ar = 'المغولية', ja = 'モンゴル文字', ko = '몽골 문자',
},
['Mymr'] = {
	vi = 'Chữ Miến Điện',
	zh = '缅甸文', ['zh-hant'] = '緬甸文',
	de = 'Birmanisch', es = 'Birmano',
	ru = 'Бирманское письмо', ar = 'البورمية', ja = 'ビルマ文字', ko = '버마 문자',
},
['Nbat'] = {
	vi = 'Chữ Nabataea',
	zh = '纳巴泰文', ['zh-hant'] = '納巴泰文',
	de = 'Nabatäisch', es = 'Nabateo',
	ru = 'Набатейское письмо', ar = 'النبطية', ja = 'ナバテア文字', ko = '나바테아 문자',
},
['Nkoo'] = {
	vi = 'Chữ N’Ko',
	zh = '西非书面文字', ['zh-hant'] = '西非書面文字',
	ru = 'Нко', ar = 'إنكو', ja = 'ンコ文字', ko = '응코 문자',
},
['Nshu'] = {
	vi = 'Chữ Nữ Thư',
	zh = '女书', ['zh-hant'] = '女書',
	ru = 'Нюй-шу', ja = '女書', ko = '여서',
},
['Ogam'] = {
	vi = 'Chữ Ogham',
	zh = '欧甘文', ['zh-hant'] = '歐甘文',
	ru = 'Огамическое письмо', ja = 'オガム文字', ko = '오검 문자',
},
['Orkh'] = {
	vi = 'Chữ Đột Quyết cổ (Orkhon)',
	zh = '古突厥文', ['zh-hant'] = '古突厥文',
	de = 'Orchon-Runen', es = 'Túrquico antiguo',
	ru = 'Древнетюркское руническое письмо', ja = '突厥文字', ko = '돌궐 문자',
},
['Orya'] = {
	vi = 'Chữ Odia (Oriya)',
	zh = '奥里亚文', ['zh-hant'] = '奧里亞文',
	ru = 'Ория', ar = 'الأورية', ja = 'オリヤー文字', ko = '오디아 문자',
},
['Ougr'] = {
	vi = 'Chữ Duy Ngô Nhĩ cổ',
	zh = '回鹘文', ['zh-hant'] = '回鶻文',
	de = 'Altuigurisch', es = 'Uigur antiguo',
	ru = 'Староуйгурское письмо', ja = 'ウイグル文字', ko = '고대 위구르 문자',
},
['Palm'] = {
	vi = 'Chữ Palmyra',
	zh = '帕尔迈拉文', ['zh-hant'] = '帕爾邁拉文',
	de = 'Palmyrenisch', es = 'Palmireno',
	ru = 'Пальмирское письмо', ar = 'التدمرية', ja = 'パルミラ文字', ko = '팔미라 문자',
},
['Phag'] = {
	vi = 'Chữ Phags-pa (Bát Tư Ba)',
	zh = '八思巴文', ['zh-hant'] = '八思巴文',
	ru = 'Квадратное письмо Пагба-ламы', ja = 'パスパ文字', ko = '파스파 문자',
},
['Phli'] = {
	vi = 'Chữ Pahlavi bia ký',
	zh = '碑铭巴列维文', ['zh-hant'] = '碑銘巴列維文',
	ru = 'Пехлевийское лапидарное письмо', ja = '碑文パフラヴィー文字', ko = '명문 팔라비 문자',
},
['Phnx'] = {
	vi = 'Chữ Phoenicia',
	zh = '腓尼基字母', ['zh-hant'] = '腓尼基字母',
	de = 'Phönizisch', es = 'Fenicio', it = 'Fenicio', pt = 'Fenício',
	ru = 'Финикийское письмо', ar = 'الفينيقية', ja = 'フェニキア文字', ko = '페니키아 문자',
},
['Prti'] = {
	vi = 'Chữ Parthia bia ký',
	zh = '碑铭帕提亚文', ['zh-hant'] = '碑銘帕提亞文',
	ru = 'Парфянское лапидарное письмо', ja = '碑文パルティア文字', ko = '명문 파르티아 문자',
},
['Roro'] = {
	vi = 'Chữ Rongorongo',
	zh = '朗格朗格文', ['zh-hant'] = '朗格朗格文',
	ru = 'Ронго-ронго', ja = 'ロンゴロンゴ', ko = '롱고롱고',
},
['Runr'] = {
	vi = 'Chữ Rune',
	zh = '卢恩字母', ['zh-hant'] = '盧恩字母',
	de = 'Runenschrift', es = 'Rúnico', it = 'Runico', pt = 'Rúnico',
	ru = 'Руническое письмо', ar = 'الرونية', ja = 'ルーン文字', ko = '룬 문자',
},

-- ── S T U V X Y Z ────────────────────────────────────────────
['Samr'] = {
	vi = 'Chữ Samaria',
	zh = '撒玛利亚文', ['zh-hant'] = '撒瑪利亞文',
	de = 'Samaritanisch', es = 'Samaritano',
	ru = 'Самаритянское письмо', ar = 'السامرية', ja = 'サマリア文字', ko = '사마리아 문자',
},
['Sarb'] = {
	vi = 'Chữ Nam Ả Rập cổ',
	zh = '古南阿拉伯文', ['zh-hant'] = '古南阿拉伯文',
	de = 'Altsüdarabisch', es = 'Sudarábigo antiguo',
	ru = 'Южноаравийское письмо', ar = 'المسند (العربية الجنوبية القديمة)',
	ja = '古代南アラビア文字', ko = '고대 남아라비아 문자',
},
['Shrd'] = {
	vi = 'Chữ Sharada',
	zh = '夏拉达文', ['zh-hant'] = '夏拉達文',
	ru = 'Шарада', ja = 'シャーラダー文字', ko = '샤라다 문자',
},
['Sidd'] = {
	vi = 'Chữ Tất Đàm (Siddham)',
	zh = '悉昙文', ['zh-hant'] = '悉曇文',
	ru = 'Сиддхам', ja = '梵字（悉曇文字）', ko = '실담 문자',
},
['Sinh'] = {
	vi = 'Chữ Sinhala',
	zh = '僧伽罗文', ['zh-hant'] = '僧伽羅文',
	de = 'Singhalesisch', es = 'Cingalés',
	ru = 'Сингальское письмо', ar = 'السنهالية', ja = 'シンハラ文字', ko = '싱할라 문자',
},
['Sogd'] = {
	vi = 'Chữ Sogdiana',
	zh = '粟特文', ['zh-hant'] = '粟特文',
	de = 'Sogdisch', es = 'Sogdiano',
	ru = 'Согдийское письмо', ja = 'ソグド文字', ko = '소그드 문자',
},
['Sund'] = {
	vi = 'Chữ Sunda',
	zh = '巽他文', ['zh-hant'] = '巽他文',
	de = 'Sundanesisch', es = 'Sondanés',
	ru = 'Сунданское письмо', ja = 'スンダ文字', ko = '순다 문자',
},
['Syrc'] = {
	vi = 'Chữ Syriac',
	zh = '叙利亚文', ['zh-hant'] = '敘利亞文',
	de = 'Syrisch', es = 'Siríaco', it = 'Siriaco', pt = 'Siríaco',
	ru = 'Сирийское письмо', ar = 'السريانية', ja = 'シリア文字', ko = '시리아 문자',
},
['Taml'] = {
	vi = 'Chữ Tamil',
	zh = '泰米尔文', ['zh-hant'] = '坦米爾文',
	ru = 'Тамильское письмо', ar = 'التاميلية', ja = 'タミル文字', ko = '타밀 문자',
},
['Tang'] = {
	vi = 'Chữ Tây Hạ (Tangut)',
	zh = '西夏文', ['zh-hant'] = '西夏文',
	de = 'Tangutisch',
	ru = 'Тангутское письмо', ja = '西夏文字', ko = '서하 문자',
},
['Tavt'] = {
	vi = 'Chữ Thái Việt',
	zh = '越南傣文', ['zh-hant'] = '越南傣文',
	ru = 'Тай-вьет', ja = 'タイ・ヴィエト文字', ko = '타이비엣 문자',
},
['Telu'] = {
	vi = 'Chữ Telugu',
	zh = '泰卢固文', ['zh-hant'] = '泰盧固文',
	ru = 'Телугу', ar = 'التيلوغوية', ja = 'テルグ文字', ko = '텔루구 문자',
},
['Tfng'] = {
	vi = 'Chữ Tifinagh (Berber)',
	zh = '提非纳文', ['zh-hant'] = '提非納文',
	ru = 'Тифинаг', ar = 'تيفيناغ', ja = 'ティフィナグ文字', ko = '티피나그 문자',
},
['Tglg'] = {
	vi = 'Chữ Baybayin (Tagalog cổ)',
	zh = '贝贝因文', ['zh-hant'] = '貝貝因文',
	ru = 'Байбайин', ja = 'バイバイン', ko = '바이바이인 문자',
},
['Thaa'] = {
	vi = 'Chữ Thaana',
	zh = '塔纳文', ['zh-hant'] = '塔納文',
	ru = 'Таана', ar = 'تانا', ja = 'ターナ文字', ko = '타나 문자',
},
['Thai'] = {
	vi = 'Chữ Thái',
	zh = '泰文', ['zh-hant'] = '泰文',
	de = 'Thailändisch', es = 'Tailandés',
	ru = 'Тайское письмо', ar = 'التايلاندية', ja = 'タイ文字', ko = '타이어 문자',
},
['Tibt'] = {
	vi = 'Chữ Tây Tạng',
	zh = '藏文', ['zh-hant'] = '藏文',
	de = 'Tibetisch', es = 'Tibetano', it = 'Tibetano', pt = 'Tibetano',
	ru = 'Тибетское письмо', ar = 'التبتية', ja = 'チベット文字', ko = '티베트 문자',
},
['Ugar'] = {
	vi = 'Chữ Ugarit',
	zh = '乌加里特文', ['zh-hant'] = '烏加里特文',
	de = 'Ugaritisch', es = 'Ugarítico',
	ru = 'Угаритское письмо', ar = 'الأوغاريتية', ja = 'ウガリット文字', ko = '우가리트 문자',
},
['Vaii'] = {
	vi = 'Chữ Vai',
	zh = '瓦伊文', ['zh-hant'] = '瓦伊文',
	ru = 'Ваи', ja = 'ヴァイ文字', ko = '바이 문자',
},
['Xpeo'] = {
	vi = 'Chữ hình nêm Ba Tư cổ',
	zh = '古波斯楔形文字', ['zh-hant'] = '古波斯楔形文字',
	de = 'Altpersische Keilschrift', es = 'Persa antiguo',
	ru = 'Древнеперсидская клинопись', ar = 'المسمارية الفارسية القديمة',
	ja = '古代ペルシア楔形文字', ko = '고대 페르시아 설형문자',
},
['Xsux'] = {
	vi = 'Chữ hình nêm Sumer-Akkad',
	zh = '苏美尔-阿卡德楔形文字', ['zh-hant'] = '蘇美-阿卡德楔形文字',
	de = 'Keilschrift', es = 'Cuneiforme sumerio-acadio', it = 'Cuneiforme', pt = 'Cuneiforme',
	ru = 'Клинопись', ar = 'المسمارية السومرية الأكدية', ja = '楔形文字', ko = '쐐기 문자',
},
['Yiii'] = {
	vi = 'Chữ Di (Yi)',
	zh = '彝文', ['zh-hant'] = '彝文',
	ru = 'И (письмо)', ja = 'イ文字', ko = '이 문자',
},
['Zinh'] = {
	vi = 'Hệ chữ kế thừa',
	zh = '继承用脚本代码', ['zh-hant'] = '繼承用文字代碼',
	ru = 'Унаследованное письмо', ja = '継承用スクリプト', ko = '상속 문자',
},
['Zmth'] = {
	vi = 'Ký hiệu toán học',
	zh = '数学记号', ['zh-hant'] = '數學記號',
	ru = 'Математическая нотация', ja = '数学記号', ko = '수학 기호',
},
['Zsye'] = {
	vi = 'Biểu tượng Emoji',
	zh = '绘文字', ['zh-hant'] = '繪文字',
	ru = 'Эмодзи', ja = '絵文字', ko = '이모지',
},
['Zsym'] = {
	vi = 'Ký hiệu biểu tượng',
	zh = '符号代码', ['zh-hant'] = '符號代碼',
	ru = 'Символы', ja = '記号', ko = '기호 문자',
},
['Zxxx'] = {
	vi = 'Tài liệu không chữ viết',
	zh = '非书写代码', ['zh-hant'] = '非書寫代碼',
	ru = 'Бесписьменный код', ja = '非記述コード', ko = '구전 미기록',
},
['Zyyy'] = {
	vi = 'Hệ chữ chung (Chưa xác định)',
	zh = '通用脚本代码', ['zh-hant'] = '通用文字代碼',
	ru = 'Общеупотребительное письмо', ja = '共通スクリプト', ko = '공통 문자',
},
['Zzzz'] = {
	vi = 'Hệ chữ chưa mã hóa',
	zh = '未编码脚本', ['zh-hant'] = '未編碼文字',
	ru = 'Некодированное письмо', ja = '未定義スクリプト', ko = '미부호화 문자',
},

}
