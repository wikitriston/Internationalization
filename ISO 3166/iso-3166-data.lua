--  ============================================================
--  Module:I18n/ISO 3166/tran
--  Bảng dịch tên quốc gia và vùng lãnh thổ (ISO 3166) sang các ngôn ngữ khác
--
--  Quy tắc DRY bắt buộc:
--    · Key ngoài = mã Alpha-2 ISO 3166-1 (UPPERCASE), khớp baseData
--    · Key trong = mã ngôn ngữ đích (BCP 47 lowercase)
--    · KHÔNG khai báo tên tiếng Anh ('en') → đã có sẵn trong baseData
--    · KHÔNG khai báo ngôn ngữ nào nếu cách viết giống hệt tiếng Anh
--      (ví dụ: "Andorra" viết giống nhau trong vi/en/es/de → bỏ)
--
--  Nguồn tham chiếu:
--    · Unicode CLDR Territory Names & Liên Hợp Quốc (UN M49)
--  ============================================================

-- luacheck: ignore
return {
	-- ── A B ──────────────────────────────────────────────────
	["AE"] = {
		vi = "Các Tiểu vương quốc Ả Rập Thống nhất",
		fr = "Émirats arabes unis", de = "Vereinigte Arabische Emirate",
		es = "Emiratos Árabes Unidos", it = "Emirati Arabi Uniti", pt = "Emirados Árabes Unidos",
		ru = "Объединённые Арабские Эмираты", ar = "الإمارات العربية المتحدة",
		zh = "阿联酋", ["zh-hant"] = "阿拉伯聯合大公國",
		ja = "アラブ首長国連邦", ko = "아랍에미리트",
	},
	["AF"] = {
		es = "Afganistán",
		ru = "Афганистан", ar = "أفغانستان",
		zh = "阿富汗", ["zh-hant"] = "阿富汗", ja = "アフガニスタン", ko = "아프가니스탄",
	},
	["AL"] = {
		fr = "Albanie", de = "Albanien",
		ru = "Албания", ar = "ألبانيا",
		zh = "阿尔巴尼亚", ["zh-hant"] = "阿爾巴尼亞", ja = "アルバニア", ko = "알바니아",
	},
	["AM"] = {
		fr = "Arménie", de = "Armenien",
		ru = "Армения", ar = "أرمينيا",
		zh = "亚美尼亚", ["zh-hant"] = "亞美尼亞", ja = "アルメニア", ko = "아르메니아",
	},
	["AO"] = {
		ru = "Ангола", ar = "أنغولا",
		zh = "安哥拉", ["zh-hant"] = "安哥拉", ja = "アンゴラ", ko = "앙골라",
	},
	["AQ"] = {
		vi = "Châu Nam Cực",
		fr = "Antarctique", de = "Antarktis", es = "Antártida", it = "Antartide", pt = "Antártida",
		ru = "Антарктида", ar = "القارة القطبية الجنوبية",
		zh = "南极洲", ["zh-hant"] = "南極洲", ja = "南極", ko = "남극",
	},
	["AR"] = {
		fr = "Argentine", de = "Argentinien",
		ru = "Аргентина", ar = "الأرجنتين",
		zh = "阿根廷", ["zh-hant"] = "阿根廷", ja = "アルゼンチン", ko = "아르헨티나",
	},
	["AT"] = {
		vi = "Áo",
		fr = "Autriche", de = "Österreich", pt = "Áustria",
		ru = "Австрия", ar = "النمسا",
		zh = "奥地利", ["zh-hant"] = "奧地利", ja = "オーストリア", ko = "오스트리아",
	},
	["AU"] = {
		vi = "Úc",
		fr = "Australie", de = "Australien", pt = "Austrália",
		ru = "Австралия", ar = "أستراليا",
		zh = "澳大利亚", ["zh-hant"] = "澳洲", ja = "オーストラリア", ko = "오스트레일리아",
	},
	["AZ"] = {
		fr = "Azerbaïdjan", de = "Aserbaidschan", es = "Azerbaiyán", it = "Azerbaigian", pt = "Azerbaijão",
		ru = "Азербайджан", ar = "أذربيجان",
		zh = "阿塞拜疆", ["zh-hant"] = "亞塞拜然", ja = "アゼルバイジャン", ko = "아제르바이잔",
	},
	["BA"] = {
		vi = "Bosna và Hercegovina",
		fr = "Bosnie-Herzégovine", de = "Bosnien und Herzegowina", es = "Bosnia y Herzegovina",
		ru = "Босния и Герцеговина", ar = "البوسنة والهرسك",
		zh = "波黑", ["zh-hant"] = "波士尼亞與赫塞哥維納", ja = "ボスニア・ヘルツェゴビナ", ko = "보스니아 헤르체고비나",
	},
	["BD"] = {
		de = "Bangladesch", es = "Bangladés",
		ru = "Бангладеш", ar = "بنغلاديش",
		zh = "孟加拉国", ["zh-hant"] = "孟加拉", ja = "バングラデシュ", ko = "방글라데시",
	},
	["BE"] = {
		vi = "Bỉ",
		fr = "Belgique", de = "Belgien", es = "Bélgica", it = "Belgio", pt = "Bélgica",
		ru = "Бельгия", ar = "بلجيكا",
		zh = "比利时", ["zh-hant"] = "比利時", ja = "ベルギー", ko = "벨기에",
	},
	["BG"] = {
		fr = "Bulgarie", de = "Bulgarien", pt = "Bulgária",
		ru = "Болгария", ar = "بلغاريا",
		zh = "保加利亚", ["zh-hant"] = "保加利亞", ja = "ブルガリア", ko = "불가리아",
	},
	["BH"] = {
		fr = "Bahreïn", es = "Baréin", pt = "Barein",
		ru = "Бахрейн", ar = "البحرين",
		zh = "巴林", ["zh-hant"] = "巴林", ja = "バーレーン", ko = "바레인",
	},
	["BN"] = {
		es = "Brunéi",
		ru = "Бруней", ar = "بروناي",
		zh = "文莱", ["zh-hant"] = "汶萊", ja = "ブルネイ", ko = "브루나이",
	},
	["BO"] = {
		fr = "Bolivie", de = "Bolivien", pt = "Bolívia",
		ru = "Боливия", ar = "بوليفيا",
		zh = "玻利维亚", ["zh-hant"] = "玻利維亞", ja = "ボリビア", ko = "볼리비아",
	},
	["BR"] = {
		vi = "Brasil",
		fr = "Brésil", de = "Brasilien", es = "Brasil", it = "Brasile", pt = "Brasil",
		ru = "Бразилия", ar = "البرازيل",
		zh = "巴西", ["zh-hant"] = "巴西", ja = "ブラジル", ko = "브라질",
	},
	["BT"] = {
		fr = "Bhoutan", es = "Bután", pt = "Butão",
		ru = "Бутан", ar = "بوتان",
		zh = "不丹", ["zh-hant"] = "不丹", ja = "ブータン", ko = "부탄",
	},
	["BY"] = {
		fr = "Biélorussie", es = "Bielorrusia", it = "Bielorussia", pt = "Bielorrússia",
		ru = "Беларусь", ar = "بيلاروس",
		zh = "白俄罗斯", ["zh-hant"] = "白俄羅斯", ja = "ベラルーシ", ko = "벨라루스",
	},

	-- ── C D E F ──────────────────────────────────────────────
	["CA"] = {
		es = "Canadá", pt = "Canadá",
		ru = "Канада", ar = "كندا",
		zh = "加拿大", ["zh-hant"] = "加拿大", ja = "カナダ", ko = "캐나다",
	},
	["CD"] = {
		vi = "Cộng hòa Dân chủ Congo",
		fr = "République démocratique du Congo", de = "Demokratische Republik Kongo",
		es = "República Democrática del Congo", it = "Repubblica Democratica del Congo",
		ru = "Демократическая Республика Конго", ar = "جمهورية الكونغو الديمقراطية",
		zh = "刚果民主共和国", ["zh-hant"] = "剛果民主共和國", ja = "コンゴ民主共和国", ko = "콩고 민주 공화국",
	},
	["CF"] = {
		vi = "Cộng hòa Trung Phi",
		fr = "République centrafricaine", de = "Zentralafrikanische Republik", es = "República Centroafricana",
		ru = "Центральноафриканская Республика", ar = "جمهورية أفريقيا الوسطى",
		zh = "中非共和国", ["zh-hant"] = "中非共和國", ja = "中央アフリカ共和国", ko = "중앙아프리카 공화국",
	},
	["CG"] = {
		vi = "Cộng hòa Congo",
		fr = "République du Congo", de = "Republik Kongo", es = "República del Congo",
		ru = "Республика Конго", ar = "جمهورية الكونغو",
		zh = "刚果共和国", ["zh-hant"] = "剛果共和國", ja = "コンゴ共和国", ko = "콩고 공화국",
	},
	["CH"] = {
		vi = "Thụy Sĩ",
		fr = "Suisse", de = "Schweiz", es = "Suiza", it = "Svizzera", pt = "Suíça",
		ru = "Швейцария", ar = "سويسرا",
		zh = "瑞士", ["zh-hant"] = "瑞士", ja = "スイス", ko = "스위스",
	},
	["CI"] = {
		vi = "Bờ Biển Ngà",
		de = "Elfenbeinküste", es = "Costa de Marfil", it = "Costa d'Avorio", pt = "Costa do Marfim",
		ru = "Кот-д’Ивуар", ar = "ساحل العاج",
		zh = "科特迪瓦", ["zh-hant"] = "象牙海岸", ja = "コートジボワール", ko = "코트디부아르",
	},
	["CL"] = {
		fr = "Chili", it = "Cile",
		ru = "Чили", ar = "تشيلي",
		zh = "智利", ["zh-hant"] = "智利", ja = "チリ", ko = "칠레",
	},
	["CM"] = {
		fr = "Cameroun", de = "Kamerun", es = "Camerún", it = "Camerun", pt = "Camarões",
		ru = "Камерун", ar = "الكاميرون",
		zh = "喀麦隆", ["zh-hant"] = "喀麥隆", ja = "カメルーン", ko = "카메룬",
	},
	["CN"] = {
		vi = "Trung Quốc",
		fr = "Chine", de = "Volksrepublik China", it = "Cina",
		ru = "Китай", ar = "الصين",
		zh = "中国", ["zh-hant"] = "中國", ja = "中国", ko = "중국",
	},
	["CO"] = {
		fr = "Colombie", de = "Kolumbien", pt = "Colômbia",
		ru = "Колумбия", ar = "كولومبيا",
		zh = "哥伦比亚", ["zh-hant"] = "哥倫比亞", ja = "コロンビア", ko = "콜롬비아",
	},
	["CU"] = {
		de = "Kuba",
		ru = "Куба", ar = "كوبا",
		zh = "古巴", ["zh-hant"] = "古巴", ja = "キューバ", ko = "쿠바",
	},
	["CY"] = {
		vi = "Síp",
		fr = "Chypre", de = "Zypern", es = "Chipre", it = "Cipro", pt = "Chipre",
		ru = "Кипр", ar = "قبرص",
		zh = "塞浦路斯", ["zh-hant"] = "賽普勒斯", ja = "キプロス", ko = "키프로스",
	},
	["CZ"] = {
		vi = "Cộng hòa Séc",
		fr = "Tchéquie", de = "Tschechien", es = "Chequia", it = "Cechia", pt = "Chéquia",
		ru = "Чехия", ar = "التشيك",
		zh = "捷克", ["zh-hant"] = "捷克", ja = "チェコ", ko = "체코",
	},
	["DE"] = {
		vi = "Đức",
		fr = "Allemagne", de = "Deutschland", es = "Alemania", it = "Germania", pt = "Alemanha",
		ru = "Германия", ar = "ألمانيا",
		zh = "德国", ["zh-hant"] = "德國", ja = "ドイツ", ko = "독일",
	},
	["DK"] = {
		vi = "Đan Mạch",
		fr = "Danemark", de = "Dänemark", es = "Dinamarca", it = "Danimarca", pt = "Dinamarca",
		ru = "Дания", ar = "الدنمارك",
		zh = "丹麦", ["zh-hant"] = "丹麥", ja = "デンマーク", ko = "덴마크",
	},
	["DO"] = {
		vi = "Cộng hòa Dominica",
		fr = "République dominicaine", de = "Dominikanische Republik", es = "República Dominicana",
		ru = "Доминиканская Республика", ar = "جمهورية الدومينيكان",
		zh = "多米尼加", ["zh-hant"] = "多明尼加", ja = "ドミニカ共和国", ko = "도미니카 공화국",
	},
	["DZ"] = {
		vi = "Algérie",
		fr = "Algérie", de = "Algerien", es = "Argelia", pt = "Argélia",
		ru = "Алжир", ar = "الجزائر",
		zh = "阿尔及利亚", ["zh-hant"] = "阿爾及利亞", ja = "アルジェリア", ko = "알제리",
	},
	["EC"] = {
		fr = "Équateur", pt = "Equador",
		ru = "Эквадор", ar = "الإكوادور",
		zh = "厄瓜多尔", ["zh-hant"] = "厄瓜多", ja = "エクアドル", ko = "에콰도르",
	},
	["EE"] = {
		fr = "Estonie", de = "Estland", pt = "Estónia",
		ru = "Эстония", ar = "إستونيا",
		zh = "爱沙尼亚", ["zh-hant"] = "愛沙尼亞", ja = "エストニア", ko = "에스토니아",
	},
	["EG"] = {
		vi = "Ai Cập",
		fr = "Égypte", de = "Ägypten", es = "Egipto", it = "Egitto", pt = "Egito",
		ru = "Египет", ar = "مصر",
		zh = "埃及", ["zh-hant"] = "埃及", ja = "エジプト", ko = "이집트",
	},
	["ES"] = {
		vi = "Tây Ban Nha",
		fr = "Espagne", de = "Spanien", es = "España", it = "Spagna", pt = "Espanha",
		ru = "Испания", ar = "إسبانيا",
		zh = "西班牙", ["zh-hant"] = "西班牙", ja = "スペイン", ko = "스페인",
	},
	["ET"] = {
		fr = "Éthiopie", de = "Äthiopien", es = "Etiopía", it = "Etiopia", pt = "Etiópia",
		ru = "Эфиопия", ar = "إثيوبيا",
		zh = "埃塞俄比亚", ["zh-hant"] = "衣索比亞", ja = "エチオピア", ko = "에티오피아",
	},
	["FI"] = {
		vi = "Phần Lan",
		fr = "Finlande", de = "Finnland", es = "Finlandia", it = "Finlandia", pt = "Finlândia",
		ru = "Финляндия", ar = "فنلندا",
		zh = "芬兰", ["zh-hant"] = "芬蘭", ja = "フィンランド", ko = "핀란드",
	},
	["FR"] = {
		vi = "Pháp",
		de = "Frankreich", es = "Francia", it = "Francia", pt = "França",
		ru = "Франция", ar = "فرنسا",
		zh = "法国", ["zh-hant"] = "法國", ja = "フランス", ko = "프랑스",
	},

	-- ── G H I J K L ──────────────────────────────────────────
	["GB"] = {
		vi = "Vương quốc Liên hiệp Anh",
		fr = "Royaume-Uni", de = "Vereinigtes Königreich", es = "Reino Unido",
		it = "Regno Unito", pt = "Reino Unido",
		ru = "Великобритания", ar = "المملكة المتحدة",
		zh = "英国", ["zh-hant"] = "英國", ja = "イギリス", ko = "영국",
	},
	["GB-ENG"] = {
		vi = "Anh",
		fr = "Angleterre", it = "Inghilterra", es = "Inglaterra", pt = "Inglaterra",
		ru = "Англия", ar = "إنجلترا",
		zh = "英格兰", ["zh-hant"] = "英格蘭", ja = "イングランド", ko = "잉글랜드",
	},
	["GB-NIR"] = {
		vi = "Bắc Ireland",
		fr = "Irlande du Nord", de = "Nordirland", es = "Irlanda del Norte",
		ru = "Северная Ирландия", ar = "أيرلندا الشمالية",
		zh = "北爱尔兰", ["zh-hant"] = "北愛爾蘭", ja = "北アイルランド", ko = "북아일랜드",
	},
	["GB-SCT"] = {
		fr = "Écosse", de = "Schottland", es = "Escocia", it = "Scozia", pt = "Escócia",
		ru = "Шотландия", ar = "اسكتلندا",
		zh = "苏格兰", ["zh-hant"] = "蘇格蘭", ja = "スコットランド", ko = "스코틀랜드",
	},
	["GB-WLS"] = {
		vi = "Xứ Wales",
		fr = "Pays de Galles", es = "Gales", it = "Galles", pt = "País de Gales",
		ru = "Уэльс", ar = "ويلز",
		zh = "威尔士", ["zh-hant"] = "威爾斯", ja = "ウェールズ", ko = "웨일스",
	},
	["GE"] = {
		vi = "Gruzia",
		fr = "Géorgie", de = "Georgien", pt = "Geórgia",
		ru = "Грузия", ar = "جورجيا",
		zh = "格鲁吉亚", ["zh-hant"] = "喬治亞", ja = "ジョージア", ko = "조지아",
	},
	["GR"] = {
		vi = "Hy Lạp",
		fr = "Grèce", de = "Griechenland", es = "Grecia", it = "Grecia", pt = "Grécia",
		ru = "Греция", ar = "اليونان",
		zh = "希腊", ["zh-hant"] = "希臘", ja = "ギリシャ", ko = "그리스",
	},
	["HK"] = {
		vi = "Hồng Kông",
		ru = "Гонконг", ar = "هونغ كونغ",
		zh = "香港", ["zh-hant"] = "香港", ja = "香港", ko = "홍콩",
	},
	["HR"] = {
		fr = "Croatie", de = "Kroatien", es = "Croacia", it = "Croazia", pt = "Croácia",
		ru = "Хорватия", ar = "كرواتيا",
		zh = "克罗地亚", ["zh-hant"] = "克羅埃西亞", ja = "クロアチア", ko = "크로아티아",
	},
	["HU"] = {
		fr = "Hongrie", de = "Ungarn", es = "Hungría", it = "Ungheria", pt = "Hungria",
		ru = "Венгрия", ar = "المجر",
		zh = "匈牙利", ["zh-hant"] = "匈牙利", ja = "ハンガリー", ko = "헝가리",
	},
	["ID"] = {
		fr = "Indonésie", de = "Indonesien", pt = "Indonésia",
		ru = "Индонезия", ar = "إندونيسيا",
		zh = "印度尼西亚", ["zh-hant"] = "印尼", ja = "インドネシア", ko = "인도네시아",
	},
	["IE"] = {
		fr = "Irlande", de = "Irland", es = "Irlanda", it = "Irlanda", pt = "Irlanda",
		ru = "Ирландия", ar = "أيرلندا",
		zh = "爱尔兰", ["zh-hant"] = "愛爾蘭", ja = "アイルランド", ko = "아일랜드",
	},
	["IL"] = {
		fr = "Israël",
		ru = "Израиль", ar = "إسرائيل",
		zh = "以色列", ["zh-hant"] = "以色列", ja = "イスラエル", ko = "이스라엘",
	},
	["IN"] = {
		vi = "Ấn Độ",
		fr = "Inde", de = "Indien", pt = "Índia",
		ru = "Индия", ar = "الهند",
		zh = "印度", ["zh-hant"] = "印度", ja = "インド", ko = "인도",
	},
	["IQ"] = {
		de = "Irak", es = "Irak", pt = "Iraque",
		ru = "Ирак", ar = "العراق",
		zh = "伊拉克", ["zh-hant"] = "伊拉克", ja = "イラク", ko = "이라크",
	},
	["IR"] = {
		es = "Irán", pt = "Irão",
		ru = "Иран", ar = "إيران",
		zh = "伊朗", ["zh-hant"] = "伊朗", ja = "イラン", ko = "이란",
	},
	["IS"] = {
		fr = "Islande", de = "Island", es = "Islandia", it = "Islanda", pt = "Islândia",
		ru = "Исландия", ar = "آيسلندا",
		zh = "冰岛", ["zh-hant"] = "冰島", ja = "アイスランド", ko = "아이슬란드",
	},
	["IT"] = {
		vi = "Ý",
		fr = "Italie", de = "Italien", es = "Italia", it = "Italia", pt = "Itália",
		ru = "Италия", ar = "إيطاليا",
		zh = "意大利", ["zh-hant"] = "義大利", ja = "イタリア", ko = "이탈리아",
	},
	["JP"] = {
		vi = "Nhật Bản",
		fr = "Japon", es = "Japón", it = "Giappone", pt = "Japão",
		ru = "Япония", ar = "اليابان",
		zh = "日本", ["zh-hant"] = "日本", ja = "日本国", ko = "일본",
	},
	["KH"] = {
		vi = "Campuchia",
		fr = "Cambodge", de = "Kambodscha", es = "Camboya", it = "Cambogia", pt = "Camboja",
		ru = "Камбоджа", ar = "كمبوديا",
		zh = "柬埔寨", ["zh-hant"] = "柬埔寨", ja = "カンボジア", ko = "캄보디아",
	},
	["KP"] = {
		vi = "Triều Tiên",
		fr = "Corée du Nord", de = "Nordkorea", es = "Corea del Norte", it = "Corea del Nord", pt = "Coreia do Norte",
		ru = "КНДР", ar = "كوريا الشمالية",
		zh = "朝鲜", ["zh-hant"] = "北韓", ja = "北朝鮮", ko = "조선민주주의인민공화국",
	},
	["KR"] = {
		vi = "Hàn Quốc",
		fr = "Corée du Sud", de = "Südkorea", es = "Corea del Sur", it = "Corea del Sud", pt = "Coreia do Sul",
		ru = "Республика Корея", ar = "كوريا الجنوبية",
		zh = "韩国", ["zh-hant"] = "南韓", ja = "韓国", ko = "대한민국",
	},
	["KZ"] = {
		de = "Kasachstan", es = "Kazajistán", it = "Kazakistan", pt = "Cazaquistão",
		ru = "Казахстан", ar = "كازاخستان",
		zh = "哈萨克斯坦", ["zh-hant"] = "哈薩克", ja = "カザフスタン", ko = "카자흐스탄",
	},
	["LA"] = {
		vi = "Lào",
		ru = "Лаос", ar = "لاوس",
		zh = "老挝", ["zh-hant"] = "寮國", ja = "ラオス", ko = "라오스",
	},
	["LB"] = {
		vi = "Liban",
		fr = "Liban", de = "Libanon", es = "Líbano", it = "Libano", pt = "Líbano",
		ru = "Ливан", ar = "لبنان",
		zh = "黎巴嫩", ["zh-hant"] = "黎巴嫩", ja = "レバノン", ko = "레바논",
	},
	["LT"] = {
		vi = "Litva",
		fr = "Lituanie", de = "Litauen", es = "Lituania", it = "Lituania", pt = "Lituânia",
		ru = "Литва", ar = "ليتوانيا",
		zh = "立陶宛", ["zh-hant"] = "立陶宛", ja = "リトアニア", ko = "리투아니아",
	},
	["LV"] = {
		fr = "Lettonie", de = "Lettland", es = "Letonia", it = "Lettonia", pt = "Letónia",
		ru = "Латвия", ar = "لاتفيا",
		zh = "拉脱维亚", ["zh-hant"] = "拉脫維亞", ja = "ラトビア", ko = "라트비아",
	},

	-- ── M N O P Q R ──────────────────────────────────────────
	["MA"] = {
		vi = "Maroc",
		fr = "Maroc", de = "Marokko", es = "Marruecos", it = "Marocco", pt = "Marrocos",
		ru = "Марокко", ar = "المغرب",
		zh = "摩洛哥", ["zh-hant"] = "摩洛哥", ja = "モロッコ", ko = "모로코",
	},
	["MM"] = {
		vi = "Myanmar (Miến Điện)",
		fr = "Birmanie", es = "Birmania", it = "Birmania", pt = "Mianmar",
		ru = "Мьянма", ar = "ميانمار",
		zh = "缅甸", ["zh-hant"] = "緬甸", ja = "ミャンマー", ko = "미얀마",
	},
	["MN"] = {
		vi = "Mông Cổ",
		fr = "Mongolie", de = "Mongolei", pt = "Mongólia",
		ru = "Монголия", ar = "منغوليا",
		zh = "蒙古国", ["zh-hant"] = "蒙古國", ja = "モンゴル国", ko = "몽골",
	},
	["MO"] = {
		vi = "Ma Cao",
		ru = "Макао", ar = "ماكاو",
		zh = "澳门", ["zh-hant"] = "澳門", ja = "マカオ", ko = "마카오",
	},
	["MX"] = {
		fr = "Mexique", de = "Mexiko", es = "México", it = "Messico", pt = "México",
		ru = "Мексика", ar = "المكسيك",
		zh = "墨西哥", ["zh-hant"] = "墨西哥", ja = "メキシコ", ko = "멕시코",
	},
	["MY"] = {
		fr = "Malaisie", es = "Malasia", pt = "Malásia",
		ru = "Малайзия", ar = "ماليزيا",
		zh = "马来西亚", ["zh-hant"] = "馬來西亞", ja = "マレーシア", ko = "말레이시아",
	},
	["NL"] = {
		vi = "Hà Lan",
		fr = "Pays-Bas", de = "Niederlande", es = "Países Bajos", it = "Paesi Bassi", pt = "Países Baixos",
		ru = "Нидерланды", ar = "هولندا",
		zh = "荷兰", ["zh-hant"] = "荷蘭", ja = "オランダ", ko = "네덜란드",
	},
	["NO"] = {
		vi = "Na Uy",
		fr = "Norvège", de = "Norwegen", es = "Noruega", it = "Norvegia", pt = "Noruega",
		ru = "Норвегия", ar = "النرويج",
		zh = "挪威", ["zh-hant"] = "挪威", ja = "ノルウェー", ko = "노르웨이",
	},
	["NP"] = {
		fr = "Népal",
		ru = "Непал", ar = "نيبال",
		zh = "尼泊尔", ["zh-hant"] = "尼泊爾", ja = "ネパール", ko = "네팔",
	},
	["NZ"] = {
		fr = "Nouvelle-Zélande", de = "Neuseeland", es = "Nueva Zelanda", it = "Nuova Zelanda", pt = "Nova Zelândia",
		ru = "Новая Зеландия", ar = "نيوزيلندا",
		zh = "新西兰", ["zh-hant"] = "紐西蘭", ja = "ニュージーランド", ko = "뉴질랜드",
	},
	["PH"] = {
		de = "Philippinen", es = "Filipinas", it = "Filippine", pt = "Filipinas",
		ru = "Филиппины", ar = "الفلبين",
		zh = "菲律宾", ["zh-hant"] = "菲律賓", ja = "フィリピン", ko = "필리핀",
	},
	["PK"] = {
		es = "Pakistán", pt = "Paquistão",
		ru = "Пакистан", ar = "باكستان",
		zh = "巴基斯坦", ["zh-hant"] = "巴基斯坦", ja = "パキスタン", ko = "파키스탄",
	},
	["PL"] = {
		vi = "Ba Lan",
		fr = "Pologne", de = "Polen", es = "Polonia", it = "Polonia", pt = "Polónia",
		ru = "Польша", ar = "بولندا",
		zh = "波兰", ["zh-hant"] = "波蘭", ja = "ポーランド", ko = "폴란드",
	},
	["PS"] = {
		es = "Palestina", it = "Palestina", pt = "Palestina",
		ru = "Палестина", ar = "فلسطين",
		zh = "巴勒斯坦", ["zh-hant"] = "巴勒斯坦", ja = "パレスチナ", ko = "팔레스타인",
	},
	["PT"] = {
		vi = "Bồ Đào Nha",
		it = "Portogallo",
		ru = "Португалия", ar = "البرتغال",
		zh = "葡萄牙", ["zh-hant"] = "葡萄牙", ja = "ポルトガル", ko = "포르투갈",
	},
	["QA"] = {
		de = "Katar", es = "Catar", pt = "Catar",
		ru = "Катар", ar = "قطر",
		zh = "卡塔尔", ["zh-hant"] = "卡達", ja = "カタール", ko = "카타르",
	},
	["RO"] = {
		fr = "Roumanie", de = "Rumänien", es = "Rumania", pt = "Roménia",
		ru = "Румыния", ar = "رومانيا",
		zh = "罗马尼亚", ["zh-hant"] = "羅馬尼亞", ja = "ルーマニア", ko = "루마니아",
	},
	["RS"] = {
		fr = "Serbie", de = "Serbien", pt = "Sérvia",
		ru = "Сербия", ar = "صربيا",
		zh = "塞尔维亚", ["zh-hant"] = "塞爾維亞", ja = "セルビア", ko = "세르비아",
	},
	["RU"] = {
		vi = "Nga",
		fr = "Russie", de = "Russland", es = "Rusia", pt = "Rússia",
		ru = "Россия", ar = "روسيا",
		zh = "俄罗斯", ["zh-hant"] = "俄羅斯", ja = "ロシア", ko = "러시아",
	},

	-- ── S T U V X Z ──────────────────────────────────────────
	["SA"] = {
		vi = "Ả Rập Xê Út",
		fr = "Arabie saoudite", de = "Saudi-Arabien", es = "Arabia Saudita",
		it = "Arabia Saudita", pt = "Arábia Saudita",
		ru = "Саудовская Аравия", ar = "المملكة العربية السعودية",
		zh = "沙特阿拉伯", ["zh-hant"] = "沙烏地阿拉伯", ja = "サウジアラビア", ko = "사우디아라비아",
	},
	["SE"] = {
		vi = "Thụy Điển",
		fr = "Suède", de = "Schweden", es = "Suecia", it = "Svezia", pt = "Suécia",
		ru = "Швеция", ar = "السويد",
		zh = "瑞典", ["zh-hant"] = "瑞典", ja = "スウェーデン", ko = "스웨덴",
	},
	["SG"] = {
		fr = "Singapour", de = "Singapur", es = "Singapur", pt = "Singapura",
		ru = "Сингапур", ar = "سنغافورة",
		zh = "新加坡", ["zh-hant"] = "新加坡", ja = "シンガポール", ko = "싱가포르",
	},
	["SK"] = {
		fr = "Slovaquie", de = "Slowakei", es = "Eslovaquia", it = "Slovacchia", pt = "Eslováquia",
		ru = "Словакия", ar = "سلوفاكيا",
		zh = "斯洛伐克", ["zh-hant"] = "斯洛伐克", ja = "スロバキア", ko = "슬로바키아",
	},
	["SY"] = {
		fr = "Syrie", de = "Syrien", es = "Siria", it = "Siria", pt = "Síria",
		ru = "Сирия", ar = "سوريا",
		zh = "叙利亚", ["zh-hant"] = "敘利亞", ja = "シリア", ko = "시리아",
	},
	["TH"] = {
		vi = "Thái Lan",
		fr = "Thaïlande", es = "Tailandia", it = "Thailandia", pt = "Tailândia",
		ru = "Таиланд", ar = "تايلاند",
		zh = "泰国", ["zh-hant"] = "泰國", ja = "タイ王国", ko = "태국",
	},
	["TL"] = {
		vi = "Đông Timor",
		fr = "Timor oriental", de = "Osttimor", es = "Timor Oriental", it = "Timor Est",
		ru = "Восточный Тимор", ar = "تيمور الشرقية",
		zh = "东帝汶", ["zh-hant"] = "東帝汶", ja = "東ティモール", ko = "동티모르",
	},
	["TR"] = {
		vi = "Thổ Nhĩ Kỳ",
		fr = "Turquie", de = "Türkei", es = "Turquía", it = "Turchia", pt = "Turquia",
		ru = "Турция", ar = "تركيا",
		zh = "土耳其", ["zh-hant"] = "土耳其", ja = "トルコ", ko = "튀르키예",
	},
	["TW"] = {
		vi = "Đài Loan",
		es = "Taiwán",
		ru = "Тайвань", ar = "تايوان",
		zh = "台湾", ["zh-hant"] = "臺灣", ja = "台湾", ko = "대만",
	},
	["UA"] = {
		vi = "Ukraina",
		es = "Ucrania", it = "Ucraina", pt = "Ucrânia",
		ru = "Украина", ar = "أوكرانيا",
		zh = "乌克兰", ["zh-hant"] = "烏克蘭", ja = "ウクライナ", ko = "우크라이나",
	},
	["US"] = {
		vi = "Hoa Kỳ",
		fr = "États-Unis", de = "Vereinigte Staaten", es = "Estados Unidos",
		it = "Stati Uniti", pt = "Estados Unidos",
		ru = "США", ar = "الولايات المتحدة",
		zh = "美国", ["zh-hant"] = "美國", ja = "アメリカ合衆国", ko = "미국",
	},
	["VA"] = {
		vi = "Thành Vatican",
		fr = "Cité du Vatican", de = "Vatikanstadt", es = "Ciudad del Vaticano",
		it = "Città del Vaticano", pt = "Cidade do Vaticano",
		ru = "Ватикан", ar = "الفاتيكان",
		zh = "梵蒂冈", ["zh-hant"] = "梵蒂岡", ja = "バチカン", ko = "바티칸 시국",
	},
	["VN"] = {
		vi = "Việt Nam",
		pt = "Vietname",
		ru = "Вьетнам", ar = "فيتنام",
		zh = "越南", ["zh-hant"] = "越南", ja = "ベトナム", ko = "베트남",
	},
	["XK"] = {
		ru = "Косово", ar = "كوسوفو",
		zh = "科索沃", ["zh-hant"] = "科索沃", ja = "コソボ", ko = "코소보",
	},
	["ZA"] = {
		vi = "Nam Phi",
		fr = "Afrique du Sud", de = "Südafrika", es = "Sudáfrica", it = "Sudafrica", pt = "África do Sul",
		ru = "ЮАР", ar = "جنوب أفريقيا",
		zh = "南非", ["zh-hant"] = "南非", ja = "南アフリカ共和国", ko = "남아프리카 공화국",
	},
}
