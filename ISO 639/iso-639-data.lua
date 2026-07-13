--  ============================================================
--  Module:I18n/ISO 639/tran
--  Bảng dịch tên ngôn ngữ sang các ngôn ngữ khác
--
--  Quy tắc DRY bắt buộc:
--    · Key ngoài = mã Alpha-2 ISO 639-1 (lowercase), khớp baseData
--    · Key trong = mã ngôn ngữ đích (BCP 47 lowercase)
--    · KHÔNG khai báo tên tiếng Anh ('en') ở đây → đã có trong baseData
--    · KHÔNG khai báo ngôn ngữ nào nếu tên giống hệt tiếng Anh
--      (ví dụ: Basque → "Basque" trong tiếng Tây Ban Nha → bỏ)
--    · Ưu tiên tên thông dụng / phổ biến nhất tại ngôn ngữ đích
--
--  Cấu trúc:
--    ['alpha2'] = {
--        ['lang_đích'] = 'Tên ngôn ngữ tại lang_đích',
--        ...
--    },
--  ============================================================

-- luacheck: ignore
return {

-- ── a ────────────────────────────────────────────────────────
['aa'] = {
	vi = 'Tiếng Afar',
	zh = '阿法尔语', ['zh-hant'] = '阿法爾語',
	fr = 'Afar', de = 'Afar', es = 'Afar',
	ru = 'Афарский',
	ar = 'الأفارية',
},
['ab'] = {
	vi = 'Tiếng Abkhazia',
	zh = '阿布哈兹语', ['zh-hant'] = '阿布哈茲語',
	fr = 'Abkhaze', de = 'Abchasisch', es = 'Abjasio',
	ru = 'Абхазский',
	ar = 'الأبخازية',
},
['af'] = {
	vi = 'Tiếng Afrikaans',
	zh = '南非荷兰语', ['zh-hant'] = '南非荷蘭語',
	fr = 'Afrikaans', de = 'Afrikaans', es = 'Afrikáans',
	ru = 'Африкаанс',
	ar = 'الأفريقانية',
	ja = 'アフリカーンス語', ko = '아프리칸스어',
},
['ak'] = {
	vi = 'Tiếng Akan',
	zh = '阿坎语', ['zh-hant'] = '阿坎語',
	fr = 'Akan', de = 'Akan', es = 'Akan',
	ru = 'Акан',
},
['am'] = {
	vi = 'Tiếng Amharic',
	zh = '阿姆哈拉语', ['zh-hant'] = '阿姆哈拉語',
	fr = 'Amharique', de = 'Amharisch', es = 'Amhárico',
	ru = 'Амхарский',
	ar = 'الأمهرية',
},
['ar'] = {
	vi = 'Tiếng Ả Rập',
	zh = '阿拉伯语', ['zh-hant'] = '阿拉伯語',
	fr = 'Arabe', de = 'Arabisch', es = 'Árabe',
	ru = 'Арабский',
	ja = 'アラビア語', ko = '아랍어',
	pt = 'Árabe', it = 'Arabo',
},
['az'] = {
	vi = 'Tiếng Azerbaijan',
	zh = '阿塞拜疆语', ['zh-hant'] = '亞塞拜然語',
	fr = 'Azerbaïdjanais', de = 'Aserbaidschanisch', es = 'Azerbaiyano',
	ru = 'Азербайджанский',
	ar = 'الأذربيجانية',
	ja = 'アゼルバイジャン語', ko = '아제르바이잔어',
},

-- ── b ────────────────────────────────────────────────────────
['be'] = {
	vi = 'Tiếng Belarus',
	zh = '白俄罗斯语', ['zh-hant'] = '白俄羅斯語',
	fr = 'Biélorusse', de = 'Weißrussisch', es = 'Bielorruso',
	ru = 'Белорусский',
	ja = 'ベラルーシ語', ko = '벨라루스어',
},
['bg'] = {
	vi = 'Tiếng Bulgaria',
	zh = '保加利亚语', ['zh-hant'] = '保加利亞語',
	fr = 'Bulgare', de = 'Bulgarisch', es = 'Búlgaro',
	ru = 'Болгарский',
	ja = 'ブルガリア語', ko = '불가리아어',
},
['bm'] = {
	vi = 'Tiếng Bambara',
	zh = '班巴拉语', ['zh-hant'] = '班巴拉語',
	fr = 'Bambara', de = 'Bambara', es = 'Bambara',
	ru = 'Бамана',
},
['bn'] = {
	vi = 'Tiếng Bengal',
	zh = '孟加拉语', ['zh-hant'] = '孟加拉語',
	fr = 'Bengali', de = 'Bengalisch', es = 'Bengalí',
	ru = 'Бенгальский',
	ar = 'البنغالية',
	ja = 'ベンガル語', ko = '벵골어',
},
['bo'] = {
	vi = 'Tiếng Tây Tạng',
	zh = '藏语', ['zh-hant'] = '藏語',
	fr = 'Tibétain', de = 'Tibetisch', es = 'Tibetano',
	ru = 'Тибетский',
	ja = 'チベット語', ko = '티베트어',
},
['br'] = {
	vi = 'Tiếng Breton',
	zh = '布列塔尼语', ['zh-hant'] = '布列塔尼語',
	fr = 'Breton', de = 'Bretonisch', es = 'Bretón',
	ru = 'Бретонский',
},
['bs'] = {
	vi = 'Tiếng Bosnia',
	zh = '波斯尼亚语', ['zh-hant'] = '波士尼亞語',
	fr = 'Bosnien', de = 'Bosnisch', es = 'Bosnio',
	ru = 'Боснийский',
	ja = 'ボスニア語', ko = '보스니아어',
},
['my'] = {
	vi = 'Tiếng Miến Điện',
	zh = '缅甸语', ['zh-hant'] = '緬甸語',
	fr = 'Birman', de = 'Birmanisch', es = 'Birmano',
	ru = 'Бирманский',
	ar = 'البورمية',
	ja = 'ビルマ語', ko = '버마어',
},

-- ── c ────────────────────────────────────────────────────────
['ca'] = {
	vi = 'Tiếng Catalan',
	zh = '加泰罗尼亚语', ['zh-hant'] = '加泰隆尼亞語',
	fr = 'Catalan', de = 'Katalanisch', es = 'Catalán',
	ru = 'Каталанский',
	ja = 'カタルーニャ語', ko = '카탈루냐어',
},
['cs'] = {
	vi = 'Tiếng Séc',
	zh = '捷克语', ['zh-hant'] = '捷克語',
	fr = 'Tchèque', de = 'Tschechisch', es = 'Checo',
	ru = 'Чешский',
	ja = 'チェコ語', ko = '체코어',
},
['cy'] = {
	vi = 'Tiếng Wales',
	zh = '威尔士语', ['zh-hant'] = '威爾斯語',
	fr = 'Gallois', de = 'Walisisch', es = 'Galés',
	ru = 'Валлийский',
	ja = 'ウェールズ語', ko = '웨일스어',
},

-- ── d ────────────────────────────────────────────────────────
['da'] = {
	vi = 'Tiếng Đan Mạch',
	zh = '丹麦语', ['zh-hant'] = '丹麥語',
	fr = 'Danois', de = 'Dänisch', es = 'Danés',
	ru = 'Датский',
	ja = 'デンマーク語', ko = '덴마크어',
},
['de'] = {
	vi = 'Tiếng Đức',
	zh = '德语', ['zh-hant'] = '德語',
	fr = 'Allemand', es = 'Alemán', it = 'Tedesco',
	ru = 'Немецкий',
	ar = 'الألمانية',
	ja = 'ドイツ語', ko = '독일어',
	pt = 'Alemão',
},

-- ── e ────────────────────────────────────────────────────────
['el'] = {
	vi = 'Tiếng Hy Lạp',
	zh = '希腊语', ['zh-hant'] = '希臘語',
	fr = 'Grec', de = 'Griechisch', es = 'Griego',
	ru = 'Греческий',
	ar = 'اليونانية',
	ja = 'ギリシャ語', ko = '그리스어',
},
['en'] = {   -- Ví dụ: 'English' trong tiếng khác
	vi = 'Tiếng Anh',
	zh = '英语', ['zh-hant'] = '英語',
	fr = 'Anglais', de = 'Englisch', es = 'Inglés', it = 'Inglese',
	ru = 'Английский',
	ar = 'الإنجليزية',
	ja = '英語', ko = '영어',
	pt = 'Inglês',
},
['eo'] = {
	vi = 'Tiếng Esperanto',
	zh = '世界语', ['zh-hant'] = '世界語',
	fr = 'Espéranto', de = 'Esperanto', es = 'Esperanto',
	ru = 'Эсперанто',
	ja = 'エスペラント語', ko = '에스페란토',
},
['es'] = {
	vi = 'Tiếng Tây Ban Nha',
	zh = '西班牙语', ['zh-hant'] = '西班牙語',
	fr = 'Espagnol', de = 'Spanisch', it = 'Spagnolo',
	ru = 'Испанский',
	ar = 'الإسبانية',
	ja = 'スペイン語', ko = '스페인어',
	pt = 'Espanhol',
},
['et'] = {
	vi = 'Tiếng Estonia',
	zh = '爱沙尼亚语', ['zh-hant'] = '愛沙尼亞語',
	fr = 'Estonien', de = 'Estnisch', es = 'Estonio',
	ru = 'Эстонский',
	ja = 'エストニア語', ko = '에스토니아어',
},
['eu'] = {
	vi = 'Tiếng Basque',
	zh = '巴斯克语', ['zh-hant'] = '巴斯克語',
	fr = 'Basque', de = 'Baskisch',
	ru = 'Баскский',
	ja = 'バスク語', ko = '바스크어',
},

-- ── f ────────────────────────────────────────────────────────
['fa'] = {
	vi = 'Tiếng Ba Tư',
	zh = '波斯语', ['zh-hant'] = '波斯語',
	fr = 'Persan', de = 'Persisch', es = 'Persa',
	ru = 'Персидский',
	ar = 'الفارسية',
	ja = 'ペルシャ語', ko = '페르시아어',
},
['fi'] = {
	vi = 'Tiếng Phần Lan',
	zh = '芬兰语', ['zh-hant'] = '芬蘭語',
	fr = 'Finnois', de = 'Finnisch', es = 'Finlandés',
	ru = 'Финский',
	ja = 'フィンランド語', ko = '핀란드어',
},
['fr'] = {
	vi = 'Tiếng Pháp',
	zh = '法语', ['zh-hant'] = '法語',
	de = 'Französisch', es = 'Francés', it = 'Francese',
	ru = 'Французский',
	ar = 'الفرنسية',
	ja = 'フランス語', ko = '프랑스어',
	pt = 'Francês',
},

-- ── g ────────────────────────────────────────────────────────
['ga'] = {
	vi = 'Tiếng Ireland',
	zh = '爱尔兰语', ['zh-hant'] = '愛爾蘭語',
	fr = 'Irlandais', de = 'Irisch', es = 'Irlandés',
	ru = 'Ирландский',
	ja = 'アイルランド語', ko = '아일랜드어',
},
['gl'] = {
	vi = 'Tiếng Galicia',
	zh = '加利西亚语', ['zh-hant'] = '加利西亞語',
	fr = 'Galicien', de = 'Galizisch', es = 'Gallego',
	ru = 'Галисийский',
},
['gu'] = {
	vi = 'Tiếng Gujarati',
	zh = '古吉拉特语', ['zh-hant'] = '古吉拉特語',
	fr = 'Gujarati', de = 'Gujaratisch', es = 'Guyaratí',
	ru = 'Гуджаратский',
	ar = 'الغوجاراتية',
},

-- ── h ────────────────────────────────────────────────────────
['ha'] = {
	vi = 'Tiếng Hausa',
	zh = '豪萨语', ['zh-hant'] = '豪薩語',
	fr = 'Haoussa', de = 'Haussa', es = 'Hausa',
	ru = 'Хауса',
	ar = 'الهوسا',
},
['he'] = {
	vi = 'Tiếng Do Thái',
	zh = '希伯来语', ['zh-hant'] = '希伯來語',
	fr = 'Hébreu', de = 'Hebräisch', es = 'Hebreo',
	ru = 'Иврит',
	ar = 'العبرية',
	ja = 'ヘブライ語', ko = '히브리어',
},
['hi'] = {
	vi = 'Tiếng Hindi',
	zh = '印地语', ['zh-hant'] = '印地語',
	fr = 'Hindi', de = 'Hindi', es = 'Hindi',
	ru = 'Хинди',
	ar = 'الهندية',
	ja = 'ヒンディー語', ko = '힌디어',
},
['hr'] = {
	vi = 'Tiếng Croatia',
	zh = '克罗地亚语', ['zh-hant'] = '克羅埃西亞語',
	fr = 'Croate', de = 'Kroatisch', es = 'Croata',
	ru = 'Хорватский',
	ja = 'クロアチア語', ko = '크로아티아어',
},
['ht'] = {
	vi = 'Tiếng Creole Haiti',
	zh = '海地克里奥尔语', ['zh-hant'] = '海地克里奧爾語',
	fr = 'Créole haïtien', de = 'Haitianisches Kreol', es = 'Criollo haitiano',
	ru = 'Гаитянский креольский',
},
['hu'] = {
	vi = 'Tiếng Hungary',
	zh = '匈牙利语', ['zh-hant'] = '匈牙利語',
	fr = 'Hongrois', de = 'Ungarisch', es = 'Húngaro',
	ru = 'Венгерский',
	ja = 'ハンガリー語', ko = '헝가리어',
},
['hy'] = {
	vi = 'Tiếng Armenia',
	zh = '亚美尼亚语', ['zh-hant'] = '亞美尼亞語',
	fr = 'Arménien', de = 'Armenisch', es = 'Armenio',
	ru = 'Армянский',
	ar = 'الأرمنية',
	ja = 'アルメニア語', ko = '아르메니아어',
},

-- ── i ────────────────────────────────────────────────────────
['id'] = {
	vi = 'Tiếng Indonesia',
	zh = '印度尼西亚语', ['zh-hant'] = '印度尼西亞語',
	fr = 'Indonésien', de = 'Indonesisch', es = 'Indonesio',
	ru = 'Индонезийский',
	ar = 'الإندونيسية',
	ja = 'インドネシア語', ko = '인도네시아어',
},
['is'] = {
	vi = 'Tiếng Iceland',
	zh = '冰岛语', ['zh-hant'] = '冰島語',
	fr = 'Islandais', de = 'Isländisch', es = 'Islandés',
	ru = 'Исландский',
	ja = 'アイスランド語', ko = '아이슬란드어',
},
['it'] = {
	vi = 'Tiếng Ý',
	zh = '意大利语', ['zh-hant'] = '義大利語',
	fr = 'Italien', de = 'Italienisch', es = 'Italiano',
	ru = 'Итальянский',
	ar = 'الإيطالية',
	ja = 'イタリア語', ko = '이탈리아어',
	pt = 'Italiano',
},

-- ── j ────────────────────────────────────────────────────────
['ja'] = {
	vi = 'Tiếng Nhật',
	zh = '日语', ['zh-hant'] = '日語',
	fr = 'Japonais', de = 'Japanisch', es = 'Japonés',
	ru = 'Японский',
	ar = 'اليابانية',
	ko = '일본어', it = 'Giapponese',
	pt = 'Japonês',
},
['jv'] = {
	vi = 'Tiếng Java',
	zh = '爪哇语', ['zh-hant'] = '爪哇語',
	fr = 'Javanais', de = 'Javanisch', es = 'Javanés',
	ru = 'Яванский',
},

-- ── k ────────────────────────────────────────────────────────
['ka'] = {
	vi = 'Tiếng Georgia',
	zh = '格鲁吉亚语', ['zh-hant'] = '喬治亞語',
	fr = 'Géorgien', de = 'Georgisch', es = 'Georgiano',
	ru = 'Грузинский',
	ar = 'الجورجية',
	ja = 'ジョージア語', ko = '조지아어',
},
['kk'] = {
	vi = 'Tiếng Kazakhstan',
	zh = '哈萨克语', ['zh-hant'] = '哈薩克語',
	fr = 'Kazakh', de = 'Kasachisch', es = 'Kazajo',
	ru = 'Казахский',
	ar = 'الكازاخستانية',
},
['km'] = {
	vi = 'Tiếng Khmer',
	zh = '高棉语', ['zh-hant'] = '高棉語',
	fr = 'Khmer', de = 'Khmer', es = 'Jemer',
	ru = 'Кхмерский',
	ar = 'الخميرية',
	ja = 'クメール語', ko = '크메르어',
},
['kn'] = {
	vi = 'Tiếng Kannada',
	zh = '卡纳达语', ['zh-hant'] = '坎那達語',
	fr = 'Kannada', de = 'Kannada', es = 'Canarés',
	ru = 'Каннада',
},
['ko'] = {
	vi = 'Tiếng Hàn',
	zh = '韩语', ['zh-hant'] = '韓語',
	fr = 'Coréen', de = 'Koreanisch', es = 'Coreano',
	ru = 'Корейский',
	ar = 'الكورية',
	ja = '韓国語', it = 'Coreano',
	pt = 'Coreano',
},
['ku'] = {
	vi = 'Tiếng Kurd',
	zh = '库尔德语', ['zh-hant'] = '庫德語',
	fr = 'Kurde', de = 'Kurdisch', es = 'Kurdo',
	ru = 'Курдский',
	ar = 'الكردية',
},
['ky'] = {
	vi = 'Tiếng Kyrgyz',
	zh = '吉尔吉斯语', ['zh-hant'] = '吉爾吉斯語',
	fr = 'Kirghiz', de = 'Kirgisisch', es = 'Kirguís',
	ru = 'Киргизский',
},

-- ── l ────────────────────────────────────────────────────────
['la'] = {
	vi = 'Tiếng Latinh',
	zh = '拉丁语', ['zh-hant'] = '拉丁語',
	fr = 'Latin', de = 'Latein', es = 'Latín',
	ru = 'Латинский',
	ja = 'ラテン語', ko = '라틴어',
},
['lb'] = {
	vi = 'Tiếng Luxembourg',
	zh = '卢森堡语', ['zh-hant'] = '盧森堡語',
	fr = 'Luxembourgeois', de = 'Luxemburgisch', es = 'Luxemburgués',
	ru = 'Люксембургский',
},
['lo'] = {
	vi = 'Tiếng Lào',
	zh = '老挝语', ['zh-hant'] = '寮語',
	fr = 'Laotien', de = 'Laotisch', es = 'Laosiano',
	ru = 'Лаосский',
	ar = 'اللاوية',
	ja = 'ラオス語', ko = '라오어',
},
['lt'] = {
	vi = 'Tiếng Litva',
	zh = '立陶宛语', ['zh-hant'] = '立陶宛語',
	fr = 'Lituanien', de = 'Litauisch', es = 'Lituano',
	ru = 'Литовский',
	ja = 'リトアニア語', ko = '리투아니아어',
},
['lv'] = {
	vi = 'Tiếng Latvia',
	zh = '拉脱维亚语', ['zh-hant'] = '拉脫維亞語',
	fr = 'Letton', de = 'Lettisch', es = 'Letón',
	ru = 'Латышский',
	ja = 'ラトビア語', ko = '라트비아어',
},

-- ── m ────────────────────────────────────────────────────────
['mg'] = {
	vi = 'Tiếng Malagasy',
	zh = '马达加斯加语', ['zh-hant'] = '馬達加斯加語',
	fr = 'Malgache', de = 'Madagassisch', es = 'Malgache',
	ru = 'Малагасийский',
},
['mi'] = {
	vi = 'Tiếng Māori',
	zh = '毛利语', ['zh-hant'] = '毛利語',
	fr = 'Maori', de = 'Maorisch', es = 'Maorí',
	ru = 'Маорийский',
	ja = 'マオリ語', ko = '마오리어',
},
['mk'] = {
	vi = 'Tiếng Macedonia',
	zh = '马其顿语', ['zh-hant'] = '馬其頓語',
	fr = 'Macédonien', de = 'Mazedonisch', es = 'Macedonio',
	ru = 'Македонский',
	ja = 'マケドニア語', ko = '마케도니아어',
},
['ml'] = {
	vi = 'Tiếng Malayalam',
	zh = '马拉雅拉姆语', ['zh-hant'] = '馬拉雅拉姆語',
	fr = 'Malayalam', de = 'Malayalamisch', es = 'Malayalam',
	ru = 'Малаялам',
	ar = 'المالايالامية',
},
['mn'] = {
	vi = 'Tiếng Mông Cổ',
	zh = '蒙古语', ['zh-hant'] = '蒙古語',
	fr = 'Mongol', de = 'Mongolisch', es = 'Mongol',
	ru = 'Монгольский',
	ar = 'المنغولية',
	ja = 'モンゴル語', ko = '몽골어',
},
['mr'] = {
	vi = 'Tiếng Marathi',
	zh = '马拉地语', ['zh-hant'] = '馬拉地語',
	fr = 'Marathi', de = 'Marathi', es = 'Maratí',
	ru = 'Маратхи',
	ar = 'الماراثية',
},
['ms'] = {
	vi = 'Tiếng Mã Lai',
	zh = '马来语', ['zh-hant'] = '馬來語',
	fr = 'Malais', de = 'Malaiisch', es = 'Malayo',
	ru = 'Малайский',
	ar = 'الملايوية',
	ja = 'マレー語', ko = '말레이어',
},
['mt'] = {
	vi = 'Tiếng Malta',
	zh = '马耳他语', ['zh-hant'] = '馬爾他語',
	fr = 'Maltais', de = 'Maltesisch', es = 'Maltés',
	ru = 'Мальтийский',
	ja = 'マルタ語', ko = '몰타어',
},

-- ── n ────────────────────────────────────────────────────────
['ne'] = {
	vi = 'Tiếng Nepal',
	zh = '尼泊尔语', ['zh-hant'] = '尼泊爾語',
	fr = 'Népalais', de = 'Nepalesisch', es = 'Nepalés',
	ru = 'Непальский',
	ar = 'النيبالية',
},
['nl'] = {
	vi = 'Tiếng Hà Lan',
	zh = '荷兰语', ['zh-hant'] = '荷蘭語',
	fr = 'Néerlandais', de = 'Niederländisch', es = 'Neerlandés',
	ru = 'Нидерландский',
	ar = 'الهولندية',
	ja = 'オランダ語', ko = '네덜란드어',
	it = 'Olandese', pt = 'Neerlandês',
},
['no'] = {
	vi = 'Tiếng Na Uy',
	zh = '挪威语', ['zh-hant'] = '挪威語',
	fr = 'Norvégien', de = 'Norwegisch', es = 'Noruego',
	ru = 'Норвежский',
	ja = 'ノルウェー語', ko = '노르웨이어',
},

-- ── o ────────────────────────────────────────────────────────
['or'] = {
	vi = 'Tiếng Odia',
	zh = '奥里亚语', ['zh-hant'] = '奧里亞語',
	fr = 'Odia', de = 'Oriya', es = 'Oriya',
	ru = 'Ория',
},

-- ── p ────────────────────────────────────────────────────────
['pa'] = {
	vi = 'Tiếng Punjab',
	zh = '旁遮普语', ['zh-hant'] = '旁遮普語',
	fr = 'Pendjabi', de = 'Punjabisch', es = 'Panyabí',
	ru = 'Панджаби',
	ar = 'البنجابية',
},
['pl'] = {
	vi = 'Tiếng Ba Lan',
	zh = '波兰语', ['zh-hant'] = '波蘭語',
	fr = 'Polonais', de = 'Polnisch', es = 'Polaco',
	ru = 'Польский',
	ar = 'البولندية',
	ja = 'ポーランド語', ko = '폴란드어',
},
['ps'] = {
	vi = 'Tiếng Pashto',
	zh = '普什图语', ['zh-hant'] = '普什圖語',
	fr = 'Pachto', de = 'Paschto', es = 'Pastún',
	ru = 'Пушту',
	ar = 'البشتونية',
},
['pt'] = {
	vi = 'Tiếng Bồ Đào Nha',
	zh = '葡萄牙语', ['zh-hant'] = '葡萄牙語',
	fr = 'Portugais', de = 'Portugiesisch', es = 'Portugués',
	ru = 'Португальский',
	ar = 'البرتغالية',
	ja = 'ポルトガル語', ko = '포르투갈어',
	it = 'Portoghese',
},

-- ── r ────────────────────────────────────────────────────────
['ro'] = {
	vi = 'Tiếng Romania',
	zh = '罗马尼亚语', ['zh-hant'] = '羅馬尼亞語',
	fr = 'Roumain', de = 'Rumänisch', es = 'Rumano',
	ru = 'Румынский',
	ja = 'ルーマニア語', ko = '루마니아어',
},
['ru'] = {
	vi = 'Tiếng Nga',
	zh = '俄语', ['zh-hant'] = '俄語',
	fr = 'Russe', de = 'Russisch', es = 'Ruso',
	ar = 'الروسية',
	ja = 'ロシア語', ko = '러시아어',
	it = 'Russo', pt = 'Russo',
},

-- ── s ────────────────────────────────────────────────────────
['sd'] = {
	vi = 'Tiếng Sindhi',
	zh = '信德语', ['zh-hant'] = '信德語',
	fr = 'Sindhi', de = 'Sindhi', es = 'Sindhi',
	ru = 'Синдхи',
	ar = 'السندية',
},
['si'] = {
	vi = 'Tiếng Sinhala',
	zh = '僧伽罗语', ['zh-hant'] = '僧伽羅語',
	fr = 'Cingalais', de = 'Singhalesisch', es = 'Cingalés',
	ru = 'Сингальский',
	ar = 'السنهالية',
},
['sk'] = {
	vi = 'Tiếng Slovak',
	zh = '斯洛伐克语', ['zh-hant'] = '斯洛伐克語',
	fr = 'Slovaque', de = 'Slowakisch', es = 'Eslovaco',
	ru = 'Словацкий',
	ja = 'スロバキア語', ko = '슬로바키아어',
},
['sl'] = {
	vi = 'Tiếng Slovenia',
	zh = '斯洛文尼亚语', ['zh-hant'] = '斯洛維尼亞語',
	fr = 'Slovène', de = 'Slowenisch', es = 'Esloveno',
	ru = 'Словенский',
	ja = 'スロベニア語', ko = '슬로베니아어',
},
['sm'] = {
	vi = 'Tiếng Samoa',
	zh = '萨摩亚语', ['zh-hant'] = '薩摩亞語',
	fr = 'Samoan', de = 'Samoanisch', es = 'Samoano',
	ru = 'Самоанский',
},
['sn'] = {
	vi = 'Tiếng Shona',
	zh = '绍纳语', ['zh-hant'] = '紹納語',
	fr = 'Shona', de = 'Shona', es = 'Shona',
	ru = 'Шона',
},
['so'] = {
	vi = 'Tiếng Somali',
	zh = '索马里语', ['zh-hant'] = '索馬里語',
	fr = 'Somali', de = 'Somali', es = 'Somalí',
	ru = 'Сомалийский',
	ar = 'الصومالية',
},
['sq'] = {
	vi = 'Tiếng Albania',
	zh = '阿尔巴尼亚语', ['zh-hant'] = '阿爾巴尼亞語',
	fr = 'Albanais', de = 'Albanisch', es = 'Albanés',
	ru = 'Албанский',
	ja = 'アルバニア語', ko = '알바니아어',
},
['sr'] = {
	vi = 'Tiếng Serbia',
	zh = '塞尔维亚语', ['zh-hant'] = '塞爾維亞語',
	fr = 'Serbe', de = 'Serbisch', es = 'Serbio',
	ru = 'Сербский',
	ja = 'セルビア語', ko = '세르비아어',
},
['ss'] = {
	vi = 'Tiếng Swati',
	zh = '斯瓦提语', ['zh-hant'] = '斯瓦提語',
	fr = 'Swati', de = 'Swazi', es = 'Suazi',
	ru = 'Свати',
},
['st'] = {
	vi = 'Tiếng Sotho miền Nam',
	zh = '南索托语', ['zh-hant'] = '南索托語',
	fr = 'Sotho du Sud', de = 'Süd-Sotho', es = 'Sotho meridional',
	ru = 'Сесото',
},
['su'] = {
	vi = 'Tiếng Sunda',
	zh = '巽他语', ['zh-hant'] = '巽他語',
	fr = 'Soundanais', de = 'Sundanesisch', es = 'Sundanés',
	ru = 'Сунданский',
},
['sv'] = {
	vi = 'Tiếng Thụy Điển',
	zh = '瑞典语', ['zh-hant'] = '瑞典語',
	fr = 'Suédois', de = 'Schwedisch', es = 'Sueco',
	ru = 'Шведский',
	ar = 'السويدية',
	ja = 'スウェーデン語', ko = '스웨덴어',
},
['sw'] = {
	vi = 'Tiếng Swahili',
	zh = '斯瓦希里语', ['zh-hant'] = '斯瓦希里語',
	fr = 'Swahili', de = 'Suaheli', es = 'Suajili',
	ru = 'Суахили',
	ar = 'السواحيلية',
	ja = 'スワヒリ語', ko = '스와힐리어',
},

-- ── t ────────────────────────────────────────────────────────
['ta'] = {
	vi = 'Tiếng Tamil',
	zh = '泰米尔语', ['zh-hant'] = '泰米爾語',
	fr = 'Tamoul', de = 'Tamilisch', es = 'Tamil',
	ru = 'Тамильский',
	ar = 'التاميلية',
	ja = 'タミル語', ko = '타밀어',
},
['te'] = {
	vi = 'Tiếng Telugu',
	zh = '泰卢固语', ['zh-hant'] = '泰盧固語',
	fr = 'Télougou', de = 'Telugu', es = 'Telugu',
	ru = 'Телугу',
	ar = 'التيلوغوية',
},
['tg'] = {
	vi = 'Tiếng Tajik',
	zh = '塔吉克语', ['zh-hant'] = '塔吉克語',
	fr = 'Tadjik', de = 'Tadschikisch', es = 'Tayiko',
	ru = 'Таджикский',
	ar = 'الطاجيكية',
},
['th'] = {
	vi = 'Tiếng Thái',
	zh = '泰语', ['zh-hant'] = '泰語',
	fr = 'Thaï', de = 'Thailändisch', es = 'Tailandés',
	ru = 'Тайский',
	ar = 'التايلاندية',
	ja = 'タイ語', ko = '태국어',
},
['ti'] = {
	vi = 'Tiếng Tigrinya',
	zh = '提格里尼亚语', ['zh-hant'] = '提格里尼亞語',
	fr = 'Tigrigna', de = 'Tigrinisch', es = 'Tigriña',
	ru = 'Тигринья',
	ar = 'التيغرينية',
},
['tk'] = {
	vi = 'Tiếng Turkmen',
	zh = '土库曼语', ['zh-hant'] = '土庫曼語',
	fr = 'Turkmène', de = 'Turkmenisch', es = 'Turcomano',
	ru = 'Туркменский',
},
['tl'] = {
	vi = 'Tiếng Tagalog',
	zh = '塔加洛语', ['zh-hant'] = '塔加洛語',
	fr = 'Tagalog', de = 'Tagalog', es = 'Tagalo',
	ru = 'Тагальский',
	ar = 'التاغالوغية',
	ja = 'タガログ語', ko = '타갈로그어',
},
['tn'] = {
	vi = 'Tiếng Tswana',
	zh = '茨瓦纳语', ['zh-hant'] = '茨瓦納語',
	fr = 'Tswana', de = 'Tswana', es = 'Setsuana',
	ru = 'Тсвана',
},
['tr'] = {
	vi = 'Tiếng Thổ Nhĩ Kỳ',
	zh = '土耳其语', ['zh-hant'] = '土耳其語',
	fr = 'Turc', de = 'Türkisch', es = 'Turco',
	ru = 'Турецкий',
	ar = 'التركية',
	ja = 'トルコ語', ko = '터키어',
},
['ts'] = {
	vi = 'Tiếng Tsonga',
	zh = '聪加语', ['zh-hant'] = '聰加語',
	fr = 'Tsonga', de = 'Tsonga', es = 'Tsonga',
	ru = 'Тсонга',
},
['tt'] = {
	vi = 'Tiếng Tatar',
	zh = '鞑靼语', ['zh-hant'] = '韃靼語',
	fr = 'Tatar', de = 'Tatarisch', es = 'Tártaro',
	ru = 'Татарский',
	ar = 'التترية',
},

-- ── u ────────────────────────────────────────────────────────
['ug'] = {
	vi = 'Tiếng Duy Ngô Nhĩ',
	zh = '维吾尔语', ['zh-hant'] = '維吾爾語',
	fr = 'Ouïghour', de = 'Uigurisch', es = 'Uigur',
	ru = 'Уйгурский',
	ar = 'الأويغورية',
},
['uk'] = {
	vi = 'Tiếng Ukraina',
	zh = '乌克兰语', ['zh-hant'] = '烏克蘭語',
	fr = 'Ukrainien', de = 'Ukrainisch', es = 'Ucraniano',
	ru = 'Украинский',
	ar = 'الأوكرانية',
	ja = 'ウクライナ語', ko = '우크라이나어',
},
['ur'] = {
	vi = 'Tiếng Urdu',
	zh = '乌尔都语', ['zh-hant'] = '烏爾都語',
	fr = 'Ourdou', de = 'Urdu', es = 'Urdu',
	ru = 'Урду',
	ar = 'الأردية',
	ja = 'ウルドゥー語', ko = '우르두어',
},
['uz'] = {
	vi = 'Tiếng Uzbek',
	zh = '乌兹别克语', ['zh-hant'] = '烏茲別克語',
	fr = 'Ouzbek', de = 'Usbekisch', es = 'Uzbeko',
	ru = 'Узбекский',
	ar = 'الأوزبكية',
},

-- ── v ────────────────────────────────────────────────────────
['vi'] = {
	vi = 'Tiếng Việt',
	zh = '越南语', ['zh-hant'] = '越南語',
	fr = 'Vietnamien', de = 'Vietnamesisch', es = 'Vietnamita',
	ru = 'Вьетнамский',
	ar = 'الفيتنامية',
	ja = 'ベトナム語', ko = '베트남어',
	it = 'Vietnamita', pt = 'Vietnamita',
},

-- ── w x y z ──────────────────────────────────────────────────
['wo'] = {
	vi = 'Tiếng Wolof',
	zh = '沃洛夫语', ['zh-hant'] = '沃洛夫語',
	fr = 'Wolof', de = 'Wolof', es = 'Wolof',
	ru = 'Волоф',
	ar = 'الولوفية',
},
['xh'] = {
	vi = 'Tiếng Xhosa',
	zh = '科萨语', ['zh-hant'] = '科薩語',
	fr = 'Xhosa', de = 'Xhosa', es = 'Xhosa',
	ru = 'Коса',
},
['yi'] = {
	vi = 'Tiếng Yiddish',
	zh = '意第绪语', ['zh-hant'] = '意第緒語',
	fr = 'Yiddish', de = 'Jiddisch', es = 'Yidis',
	ru = 'Идиш',
	ar = 'اليديشية',
},
['yo'] = {
	vi = 'Tiếng Yoruba',
	zh = '约鲁巴语', ['zh-hant'] = '約魯巴語',
	fr = 'Yoruba', de = 'Yoruba', es = 'Yoruba',
	ru = 'Йоруба',
	ar = 'اليوروبا',
},
['zh'] = {
	vi = 'Tiếng Trung',
	fr = 'Chinois', de = 'Chinesisch', es = 'Chino',
	ru = 'Китайский',
	ar = 'الصينية',
	ja = '中国語', ko = '중국어',
	it = 'Cinese', pt = 'Chinês',
},
['zu'] = {
	vi = 'Tiếng Zulu',
	zh = '祖鲁语', ['zh-hant'] = '祖魯語',
	fr = 'Zoulou', de = 'Zulu', es = 'Zulú',
	ru = 'Зулусский',
},

}
