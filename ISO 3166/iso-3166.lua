--  ============================================================
--  Module:I18n/ISO 3166
--  Tra cứu quốc gia & vùng lãnh thổ (ISO 3166-1 Alpha-2/3/Numeric & ISO 3166-3)
--
--  Nguồn chuẩn chính thức (Provenance):
--    · ISO 3166 Maintenance Agency (ISO 3166-1 & ISO 3166-3)
--    · United Nations Statistics Division (UN M49)
--    · Unicode CLDR Territory Containment & Aliases
--  ============================================================

local M = {}

M._meta = {
	standard = "ISO 3166-1 / ISO 3166-3",
	sources  = {
		"https://www.iso.org/iso-3166-country-codes.html",
		"https://unstats.un.org/unsd/methodology/m49/",
	},
	updated  = "2026-11-07",
}

-- 1. Base Data: Chỉ chứa tên gốc (English) và metadata
local baseData = {
  ["AD"] = {alpha3="AND",numeric="020",name="Andorra"},
  ["AE"] = {alpha3="ARE",numeric="784",name="United Arab Emirates",altnames={"UAE"}},
  ["AF"] = {alpha3="AFG",numeric="004",name="Afghanistan"},
  ["AG"] = {alpha3="ATG",numeric="028",name="Antigua and Barbuda"},
  ["AI"] = {alpha3="AIA",numeric="660",name="Anguilla"},
  ["AL"] = {alpha3="ALB",numeric="008",name="Albania"},
  ["AM"] = {alpha3="ARM",numeric="051",name="Armenia"},
  ["AO"] = {alpha3="AGO",numeric="024",name="Angola"},
  ["AQ"] = {alpha3="ATA",numeric="010",name="Antarctica"},
  ["AR"] = {alpha3="ARG",numeric="032",name="Argentina"},
  ["AS"] = {alpha3="ASM",numeric="016",name="American Samoa"},
  ["AT"] = {alpha3="AUT",numeric="040",name="Austria"},
  ["AU"] = {alpha3="AUS",numeric="036",name="Australia"},
  ["AW"] = {alpha3="ABW",numeric="533",name="Aruba"},
  ["AX"] = {alpha3="ALA",numeric="248",name="Åland Islands",altnames={"Aland Islands","Åland","Aland"}},
  ["AZ"] = {alpha3="AZE",numeric="031",name="Azerbaijan"},
  ["BA"] = {alpha3="BIH",numeric="070",name="Bosnia and Herzegovina",altnames={"Bosnia"}},
  ["BB"] = {alpha3="BRB",numeric="052",name="Barbados"},
  ["BD"] = {alpha3="BGD",numeric="050",name="Bangladesh"},
  ["BE"] = {alpha3="BEL",numeric="056",name="Belgium"},
  ["BF"] = {alpha3="BFA",numeric="854",name="Burkina Faso"},
  ["BG"] = {alpha3="BGR",numeric="100",name="Bulgaria"},
  ["BH"] = {alpha3="BHR",numeric="048",name="Bahrain"},
  ["BI"] = {alpha3="BDI",numeric="108",name="Burundi"},
  ["BJ"] = {alpha3="BEN",numeric="204",name="Benin"},
  ["BL"] = {alpha3="BLM",numeric="652",name="Saint Barthélemy",altnames={"St Barthelemy"}},
  ["BM"] = {alpha3="BMU",numeric="060",name="Bermuda"},
  ["BN"] = {alpha3="BRN",numeric="096",name="Brunei",isoname="Brunei Darussalam"},
  ["BO"] = {alpha3="BOL",numeric="068",name="Bolivia",isoname="Bolivia, Plurinational State of"},
  ["BQ"] = {alpha3="BES",numeric="535",name="Caribbean Netherlands",isoname="Bonaire, Sint Eustatius and Saba"},
  ["BR"] = {alpha3="BRA",numeric="076",name="Brazil"},
  ["BS"] = {alpha3="BHS",numeric="044",name="Bahamas"},
  ["BT"] = {alpha3="BTN",numeric="064",name="Bhutan"},
  ["BV"] = {alpha3="BVT",numeric="074",name="Bouvet Island"},
  ["BW"] = {alpha3="BWA",numeric="072",name="Botswana"},
  ["BY"] = {alpha3="BLR",numeric="112",name="Belarus"},
  ["BZ"] = {alpha3="BLZ",numeric="084",name="Belize"},
  ["CA"] = {alpha3="CAN",numeric="124",name="Canada"},
  ["CC"] = {alpha3="CCK",numeric="166",name="Cocos (Keeling) Islands",altnames={"Cocos Islands","Keeling Islands"}},
  ["CD"] = {alpha3="COD",numeric="180",name="Democratic Republic of the Congo",isoname="Congo, Democratic Republic of the",altnames={"Congo-Kinshasa","Congo–Kinshasa","DRC","DR Congo"}},
  ["CF"] = {alpha3="CAF",numeric="140",name="Central African Republic",altnames={"CAR"}},
  ["CG"] = {alpha3="COG",numeric="178",name="Republic of the Congo",isoname="Congo",altnames={"Congo-Brazzaville", "Congo–Brazzaville"}},
  ["CH"] = {alpha3="CHE",numeric="756",name="Switzerland"},
  ["CI"] = {alpha3="CIV",numeric="384",name="Côte d'Ivoire",altnames={"Ivory Coast"}},
  ["CK"] = {alpha3="COK",numeric="184",name="Cook Islands"},
  ["CL"] = {alpha3="CHL",numeric="152",name="Chile"},
  ["CM"] = {alpha3="CMR",numeric="120",name="Cameroon"},
  ["CN"] = {alpha3="CHN",numeric="156",name="China",altnames={"People's Republic of China","PRC"}},
  ["CO"] = {alpha3="COL",numeric="170",name="Colombia"},
  ["CR"] = {alpha3="CRI",numeric="188",name="Costa Rica"},
  ["CU"] = {alpha3="CUB",numeric="192",name="Cuba"},
  ["CV"] = {alpha3="CPV",numeric="132",name="Cabo Verde",altnames={"Cape Verde"}},
  ["CW"] = {alpha3="CUW",numeric="531",name="Curaçao",altnames={"Curacao"}},
  ["CX"] = {alpha3="CXR",numeric="162",name="Christmas Island"},
  ["CY"] = {alpha3="CYP",numeric="196",name="Cyprus"},
  ["CZ"] = {alpha3="CZE",numeric="203",name="Czech Republic",isoname="Czechia"},
  ["DE"] = {alpha3="DEU",numeric="276",name="Germany"},
  ["DJ"] = {alpha3="DJI",numeric="262",name="Djibouti"},
  ["DK"] = {alpha3="DNK",numeric="208",name="Denmark"},
  ["DM"] = {alpha3="DMA",numeric="212",name="Dominica"},
  ["DO"] = {alpha3="DOM",numeric="214",name="Dominican Republic"},
  ["DZ"] = {alpha3="DZA",numeric="012",name="Algeria"},
  ["EC"] = {alpha3="ECU",numeric="218",name="Ecuador"},
  ["EE"] = {alpha3="EST",numeric="233",name="Estonia"},
  ["EG"] = {alpha3="EGY",numeric="818",name="Egypt"},
  ["EH"] = {alpha3="ESH",numeric="732",name="Western Sahara"},
  ["ER"] = {alpha3="ERI",numeric="232",name="Eritrea"},
  ["ES"] = {alpha3="ESP",numeric="724",name="Spain"},
  ["ET"] = {alpha3="ETH",numeric="231",name="Ethiopia"},
  ["FI"] = {alpha3="FIN",numeric="246",name="Finland"},
  ["FJ"] = {alpha3="FJI",numeric="242",name="Fiji"},
  ["FK"] = {alpha3="FLK",numeric="238",name="Falkland Islands",isoname="Falkland Islands (Malvinas)",altnames={"Falklands","Islas Malvinas","Malvinas","Malvinas Islands"}},
  ["FM"] = {alpha3="FSM",numeric="583",name="Federated States of Micronesia",isoname="Micronesia, Federated States of",altnames={"Micronesia"}},
  ["FO"] = {alpha3="FRO",numeric="234",name="Faroe Islands",altnames={"Faroer","Faeroer"}},
  ["FR"] = {alpha3="FRA",numeric="250",name="France"},
  ["GA"] = {alpha3="GAB",numeric="266",name="Gabon"},
  ["GB"] = {alpha3="GBR",numeric="826",name="United Kingdom",isoname="United Kingdom of Great Britain and Northern Ireland",altnames={"UK","Great Britain"}},
	 -- Project-defined entries: "GB-xxx" keys follow ISO 3166-2 shape, but the
	 -- alpha3 values and numeric "000" are NOT ISO-assigned. They are kept for
	 -- backward compatibility; numeric "000" is never indexed (it was shared by
	 -- all five rows, making reverse lookup non-deterministic).
	 ["GB-ENG"] = {alpha3="ENG",numeric="000",name="England",status="project-defined"}, --Considered to be a country
	 ["GB-NIR"] = {alpha3="NIR",numeric="000",name="Northern Ireland",status="project-defined"}, --Considered to be a country
	 ["GB-SCT"] = {alpha3="SCT",numeric="000",name="Scotland",status="project-defined"}, --Considered to be a country
	 ["GB-WLS"] = {alpha3="WLS",numeric="000",name="Wales",status="project-defined"}, --Considered to be a country
	 ["GB-EAW"] = {alpha3="EAW",numeric="000",name="England and Wales",status="project-defined"}, --Considered to be a country
  ["GD"] = {alpha3="GRD",numeric="308",name="Grenada"},
  ["GE"] = {alpha3="GEO",numeric="268",name="Georgia"},
  ["GF"] = {alpha3="GUF",numeric="254",name="French Guiana"},
  ["GG"] = {alpha3="GGY",numeric="831",name="Guernsey"},
  ["GH"] = {alpha3="GHA",numeric="288",name="Ghana"},
  ["GI"] = {alpha3="GIB",numeric="292",name="Gibraltar"},
  ["GL"] = {alpha3="GRL",numeric="304",name="Greenland"},
  ["GM"] = {alpha3="GMB",numeric="270",name="Gambia"},
  ["GN"] = {alpha3="GIN",numeric="324",name="Guinea"},
  ["GP"] = {alpha3="GLP",numeric="312",name="Guadeloupe"},
  ["GQ"] = {alpha3="GNQ",numeric="226",name="Equatorial Guinea"},
  ["GR"] = {alpha3="GRC",numeric="300",name="Greece"},
  ["GS"] = {alpha3="SGS",numeric="239",name="South Georgia and the South Sandwich Islands"},
  ["GT"] = {alpha3="GTM",numeric="320",name="Guatemala"},
  ["GU"] = {alpha3="GUM",numeric="316",name="Guam"},
  ["GW"] = {alpha3="GNB",numeric="624",name="Guinea-Bissau",altnames={"Guinea–Bissau"}},
  ["GY"] = {alpha3="GUY",numeric="328",name="Guyana"},
  ["HK"] = {alpha3="HKG",numeric="344",name="Hong Kong",altnames={"Hong Kong SAR","HKSAR"}},
  ["HM"] = {alpha3="HMD",numeric="334",name="Heard Island and McDonald Islands",altnames={"Heard and McDonald Islands"}},
  ["HN"] = {alpha3="HND",numeric="340",name="Honduras"},
  ["HR"] = {alpha3="HRV",numeric="191",name="Croatia"},
  ["HT"] = {alpha3="HTI",numeric="332",name="Haiti"},
  ["HU"] = {alpha3="HUN",numeric="348",name="Hungary"},
  ["ID"] = {alpha3="IDN",numeric="360",name="Indonesia"},
  ["IE"] = {alpha3="IRL",numeric="372",name="Ireland",altnames={"Republic of Ireland"}},
  ["IL"] = {alpha3="ISR",numeric="376",name="Israel"},
  ["IM"] = {alpha3="IMN",numeric="833",name="Isle of Man"},
  ["IN"] = {alpha3="IND",numeric="356",name="India"},
  ["IO"] = {alpha3="IOT",numeric="086",name="British Indian Ocean Territory"},
  ["IQ"] = {alpha3="IRQ",numeric="368",name="Iraq"},
  ["IR"] = {alpha3="IRN",numeric="364",name="Iran",isoname="Iran, Islamic Republic of"},
  ["IS"] = {alpha3="ISL",numeric="352",name="Iceland"},
  ["IT"] = {alpha3="ITA",numeric="380",name="Italy"},
  ["JE"] = {alpha3="JEY",numeric="832",name="Jersey"},
  ["JM"] = {alpha3="JAM",numeric="388",name="Jamaica"},
  ["JO"] = {alpha3="JOR",numeric="400",name="Jordan"},
  ["JP"] = {alpha3="JPN",numeric="392",name="Japan"},
  ["KE"] = {alpha3="KEN",numeric="404",name="Kenya"},
  ["KG"] = {alpha3="KGZ",numeric="417",name="Kyrgyzstan"},
  ["KH"] = {alpha3="KHM",numeric="116",name="Cambodia"},
  ["KI"] = {alpha3="KIR",numeric="296",name="Kiribati"},
  ["KM"] = {alpha3="COM",numeric="174",name="Comoros"},
  ["KN"] = {alpha3="KNA",numeric="659",name="Saint Kitts and Nevis",altnames={"St Kitts and Nevis"}},
  ["KP"] = {alpha3="PRK",numeric="408",name="North Korea",isoname="Korea, Democratic People's Republic of",altnames={"Democratic People's Republic of Korea"}},
  ["KR"] = {alpha3="KOR",numeric="410",name="South Korea",isoname="Korea, Republic of",altnames={"Republic of Korea"}},
  ["KW"] = {alpha3="KWT",numeric="414",name="Kuwait"},
  ["KY"] = {alpha3="CYM",numeric="136",name="Cayman Islands"},
  ["KZ"] = {alpha3="KAZ",numeric="398",name="Kazakhstan"},
  ["LA"] = {alpha3="LAO",numeric="418",name="Laos",isoname="Lao People's Democratic Republic"},
  ["LB"] = {alpha3="LBN",numeric="422",name="Lebanon"},
  ["LC"] = {alpha3="LCA",numeric="662",name="Saint Lucia",altnames={"St Lucia"}},
  ["LI"] = {alpha3="LIE",numeric="438",name="Liechtenstein"},
  ["LK"] = {alpha3="LKA",numeric="144",name="Sri Lanka"},
  ["LR"] = {alpha3="LBR",numeric="430",name="Liberia"},
  ["LS"] = {alpha3="LSO",numeric="426",name="Lesotho"},
  ["LT"] = {alpha3="LTU",numeric="440",name="Lithuania"},
  ["LU"] = {alpha3="LUX",numeric="442",name="Luxembourg"},
  ["LV"] = {alpha3="LVA",numeric="428",name="Latvia"},
  ["LY"] = {alpha3="LBY",numeric="434",name="Libya"},
  ["MA"] = {alpha3="MAR",numeric="504",name="Morocco"},
  ["MC"] = {alpha3="MCO",numeric="492",name="Monaco"},
  ["MD"] = {alpha3="MDA",numeric="498",name="Moldova",isoname="Moldova, Republic of"},
  ["ME"] = {alpha3="MNE",numeric="499",name="Montenegro"},
  ["MF"] = {alpha3="MAF",numeric="663",name="Saint-Martin",isoname="Saint Martin (French part)",altnames={"Saint–Martin", "St Martin","St Martin (French part)","Collectivity of Saint Martin","Collectivity of St Martin"}},
  ["MG"] = {alpha3="MDG",numeric="450",name="Madagascar"},
  ["MH"] = {alpha3="MHL",numeric="584",name="Marshall Islands"},
  ["MK"] = {alpha3="MKD",numeric="807",name="North Macedonia",altnames={"Republic of North Macedonia","Macedonia","Republic of Macedonia","Macedonia, the former Yugoslav Republic of"}},
  ["ML"] = {alpha3="MLI",numeric="466",name="Mali"},
  ["MM"] = {alpha3="MMR",numeric="104",name="Myanmar",altnames={"Burma"}},
  ["MN"] = {alpha3="MNG",numeric="496",name="Mongolia"},
  ["MO"] = {alpha3="MAC",numeric="446",name="Macau",isoname="Macao",altnames={"Macau SAR","Macao SAR"}},
  ["MP"] = {alpha3="MNP",numeric="580",name="Northern Mariana Islands"},
  ["MQ"] = {alpha3="MTQ",numeric="474",name="Martinique"},
  ["MR"] = {alpha3="MRT",numeric="478",name="Mauritania"},
  ["MS"] = {alpha3="MSR",numeric="500",name="Montserrat"},
  ["MT"] = {alpha3="MLT",numeric="470",name="Malta"},
  ["MU"] = {alpha3="MUS",numeric="480",name="Mauritius"},
  ["MV"] = {alpha3="MDV",numeric="462",name="Maldives"},
  ["MW"] = {alpha3="MWI",numeric="454",name="Malawi"},
  ["MX"] = {alpha3="MEX",numeric="484",name="Mexico"},
  ["MY"] = {alpha3="MYS",numeric="458",name="Malaysia"},
  ["MZ"] = {alpha3="MOZ",numeric="508",name="Mozambique"},
  ["NA"] = {alpha3="NAM",numeric="516",name="Namibia"},
  ["NC"] = {alpha3="NCL",numeric="540",name="New Caledonia"},
  ["NE"] = {alpha3="NER",numeric="562",name="Niger"},
  ["NF"] = {alpha3="NFK",numeric="574",name="Norfolk Island"},
  ["NG"] = {alpha3="NGA",numeric="566",name="Nigeria"},
  ["NI"] = {alpha3="NIC",numeric="558",name="Nicaragua"},
  ["NL"] = {alpha3="NLD",numeric="528",name="Netherlands"},
  ["NO"] = {alpha3="NOR",numeric="578",name="Norway"},
  ["NP"] = {alpha3="NPL",numeric="524",name="Nepal"},
  ["NR"] = {alpha3="NRU",numeric="520",name="Nauru"},
  ["NU"] = {alpha3="NIU",numeric="570",name="Niue"},
  ["NZ"] = {alpha3="NZL",numeric="554",name="New Zealand",altnames={"Aotearoa"}},
  ["OM"] = {alpha3="OMN",numeric="512",name="Oman"},
  ["PA"] = {alpha3="PAN",numeric="591",name="Panama"},
  ["PE"] = {alpha3="PER",numeric="604",name="Peru"},
  ["PF"] = {alpha3="PYF",numeric="258",name="French Polynesia"},
  ["PG"] = {alpha3="PNG",numeric="598",name="Papua New Guinea"},
  ["PH"] = {alpha3="PHL",numeric="608",name="Philippines"},
  ["PK"] = {alpha3="PAK",numeric="586",name="Pakistan"},
  ["PL"] = {alpha3="POL",numeric="616",name="Poland"},
  ["PM"] = {alpha3="SPM",numeric="666",name="Saint Pierre and Miquelon",altnames={"St Pierre and Miquelon"}},
  ["PN"] = {alpha3="PCN",numeric="612",name="Pitcairn"},
  ["PR"] = {alpha3="PRI",numeric="630",name="Puerto Rico"},
  ["PS"] = {alpha3="PSE",numeric="275",name="Palestine",isoname="Palestine, State of",altnames={"State of Palestine"}},
  ["PT"] = {alpha3="PRT",numeric="620",name="Portugal"},
  ["PW"] = {alpha3="PLW",numeric="585",name="Palau"},
  ["PY"] = {alpha3="PRY",numeric="600",name="Paraguay"},
  ["QA"] = {alpha3="QAT",numeric="634",name="Qatar"},
  ["RE"] = {alpha3="REU",numeric="638",name="Réunion"},
  ["RO"] = {alpha3="ROU",numeric="642",name="Romania"},
  ["RS"] = {alpha3="SRB",numeric="688",name="Serbia"},
  ["RU"] = {alpha3="RUS",numeric="643",name="Russia",isoname="Russian Federation"},
  ["RW"] = {alpha3="RWA",numeric="646",name="Rwanda"},
  ["SA"] = {alpha3="SAU",numeric="682",name="Saudi Arabia"},
  ["SB"] = {alpha3="SLB",numeric="090",name="Solomon Islands"},
  ["SC"] = {alpha3="SYC",numeric="690",name="Seychelles"},
  ["SD"] = {alpha3="SDN",numeric="729",name="Sudan"},
  ["SE"] = {alpha3="SWE",numeric="752",name="Sweden"},
  ["SG"] = {alpha3="SGP",numeric="702",name="Singapore"},
  ["SH"] = {alpha3="SHN",numeric="654",name="Saint Helena, Ascension and Tristan da Cunha"},
  ["SI"] = {alpha3="SVN",numeric="705",name="Slovenia"},
  ["SJ"] = {alpha3="SJM",numeric="744",name="Svalbard and Jan Mayen"},
  ["SK"] = {alpha3="SVK",numeric="703",name="Slovakia"},
  ["SL"] = {alpha3="SLE",numeric="694",name="Sierra Leone"},
  ["SM"] = {alpha3="SMR",numeric="674",name="San Marino"},
  ["SN"] = {alpha3="SEN",numeric="686",name="Senegal"},
  ["SO"] = {alpha3="SOM",numeric="706",name="Somalia"},
  ["SR"] = {alpha3="SUR",numeric="740",name="Suriname"},
  ["SS"] = {alpha3="SSD",numeric="728",name="South Sudan"},
  ["ST"] = {alpha3="STP",numeric="678",name="São Tomé and Príncipe",isoname="Sao Tome and Principe",altnames={"Democratic Republic of Sao Tome and Principe"}},
  ["SV"] = {alpha3="SLV",numeric="222",name="El Salvador"},
  ["SX"] = {alpha3="SXM",numeric="534",name="Sint Maarten",isoname="Sint Maarten (Dutch part)",altnames={"St Maarten","Saint Martin (Dutch part)","St Martin (Dutch part)"}},
  ["SY"] = {alpha3="SYR",numeric="760",name="Syria",isoname="Syrian Arab Republic"},
  ["SZ"] = {alpha3="SWZ",numeric="748",name="Eswatini",altnames={"Swaziland"}},
  ["TC"] = {alpha3="TCA",numeric="796",name="Turks and Caicos Islands"},
  ["TD"] = {alpha3="TCD",numeric="148",name="Chad"},
  ["TF"] = {alpha3="ATF",numeric="260",name="French Southern and Antarctic Lands",isoname="French Southern Territories"},
  ["TG"] = {alpha3="TGO",numeric="768",name="Togo"},
  ["TH"] = {alpha3="THA",numeric="764",name="Thailand"},
  ["TJ"] = {alpha3="TJK",numeric="762",name="Tajikistan"},
  ["TK"] = {alpha3="TKL",numeric="772",name="Tokelau"},
  ["TL"] = {alpha3="TLS",numeric="626",name="Timor-Leste",altnames={"East Timor", "Timor–Leste"}},
  ["TM"] = {alpha3="TKM",numeric="795",name="Turkmenistan"},
  ["TN"] = {alpha3="TUN",numeric="788",name="Tunisia"},
  ["TO"] = {alpha3="TON",numeric="776",name="Tonga"},
  ["TR"] = {alpha3="TUR",numeric="792",name="Turkey",isoname="Türkiye"},
  ["TT"] = {alpha3="TTO",numeric="780",name="Trinidad and Tobago"},
  ["TV"] = {alpha3="TUV",numeric="798",name="Tuvalu"},
  ["TW"] = {alpha3="TWN",numeric="158",name="Taiwan",isoname="Taiwan, Province of China",altnames={"Republic of China"}},
  ["TZ"] = {alpha3="TZA",numeric="834",name="Tanzania",isoname="Tanzania, United Republic of"},
  ["UA"] = {alpha3="UKR",numeric="804",name="Ukraine"},
  ["UG"] = {alpha3="UGA",numeric="800",name="Uganda"},
  ["UM"] = {alpha3="UMI",numeric="581",name="United States Minor Outlying Islands"},
  ["US"] = {alpha3="USA",numeric="840",name="United States",isoname="United States of America",altnames={"US","USA","U.S."}},
  ["UY"] = {alpha3="URY",numeric="858",name="Uruguay"},
  ["UZ"] = {alpha3="UZB",numeric="860",name="Uzbekistan"},
  ["VA"] = {alpha3="VAT",numeric="336",name="Vatican City",isoname="Holy See",altnames={"Holy See (Vatican City State)","Vatican City State"}},
  ["VC"] = {alpha3="VCT",numeric="670",name="Saint Vincent and the Grenadines",altnames={"St Vincent and the Grenadines"}},
  ["VE"] = {alpha3="VEN",numeric="862",name="Venezuela",isoname="Venezuela, Bolivarian Republic of"},
  ["VG"] = {alpha3="VGB",numeric="092",name="British Virgin Islands",isoname="Virgin Islands (British)",altnames={"UK Virgin Islands","BVI"}},
  ["VI"] = {alpha3="VIR",numeric="850",name="United States Virgin Islands",isoname="Virgin Islands (U.S.)",altnames={"US Virgin Islands","USVI"}},
  ["VN"] = {alpha3="VNM",numeric="704",name="Vietnam",isoname="Viet Nam"},
  ["VU"] = {alpha3="VUT",numeric="548",name="Vanuatu"},
  ["WF"] = {alpha3="WLF",numeric="876",name="Wallis and Futuna"},
  ["WS"] = {alpha3="WSM",numeric="882",name="Samoa"},
  -- XK is a user-assigned code (ISO 3166-1 reserves "XA"–"XZ" for user assignment);
  -- alpha3/numeric are likewise not ISO-assigned.
  ["XK"] = {alpha3="XKX",numeric="926",name="Kosovo",isoname="Republic of Kosovo",altnames={"XXK", "UNK"},status="user-assigned"},
  ["YE"] = {alpha3="YEM",numeric="887",name="Yemen"},
  ["YT"] = {alpha3="MYT",numeric="175",name="Mayotte"},
  ["ZA"] = {alpha3="ZAF",numeric="710",name="South Africa"},
  ["ZM"] = {alpha3="ZMB",numeric="894",name="Zambia"},
  ["ZW"] = {alpha3="ZWE",numeric="716",name="Zimbabwe"}

}

-- 2. Mã bảo lưu đặc biệt (Exceptionally Reserved) & Mã lịch sử đã rút (ISO 3166-3)
--    Tách riêng khỏi baseData để KHÔNG nhầm lẫn với các mã ISO 3166-1 đang cấp phát.
local reservedData = {
	["AC"] = { name = "Ascension Island",          status = "exceptionally-reserved", related = "SH" },
	["CP"] = { name = "Clipperton Island",         status = "exceptionally-reserved", related = "FR" },
	["CQ"] = { name = "Island of Sark",            status = "exceptionally-reserved", related = "GG" },
	["DG"] = { name = "Diego Garcia",              status = "exceptionally-reserved", related = "IO" },
	["EA"] = { name = "Ceuta, Melilla",            status = "exceptionally-reserved", related = "ES" },
	["EU"] = { name = "European Union",            status = "exceptionally-reserved" },
	["EZ"] = { name = "Eurozone",                  status = "exceptionally-reserved" },
	["FX"] = { name = "France, Metropolitan",      status = "exceptionally-reserved", alpha3 = "FXX", numeric = "249", replacedBy = "FR" },
	["IC"] = { name = "Canary Islands",            status = "exceptionally-reserved", related = "ES" },
	["SU"] = { name = "USSR",                      status = "exceptionally-reserved", alpha3 = "SUN", numeric = "810", iso3166_3 = "SUHH" },
	["TA"] = { name = "Tristan da Cunha",          status = "exceptionally-reserved", related = "SH" },
	["UK"] = { name = "United Kingdom",            status = "exceptionally-reserved", replacedBy = "GB" },
	["UN"] = { name = "United Nations",            status = "exceptionally-reserved" },
}

local historicalData = {
	["AN"] = { iso3166_3 = "ANHH", alpha3 = "ANT", numeric = "530", name = "Netherlands Antilles",                 status = "withdrawn", withdrawn = "2010", splitInto = { "BQ", "CW", "SX" } },
	["BU"] = { iso3166_3 = "BUMM", alpha3 = "BUR", numeric = "104", name = "Burma",                                status = "withdrawn", withdrawn = "1989", replacedBy = "MM" },
	["CS"] = { iso3166_3 = "CSXX", alpha3 = "SCG", numeric = "891", name = "Serbia and Montenegro",                status = "withdrawn", withdrawn = "2006", splitInto = { "RS", "ME" }, formerCode = "CSHH (Czechoslovakia, 1993)" },
	["DD"] = { iso3166_3 = "DDDE", alpha3 = "DDR", numeric = "278", name = "German Democratic Republic",           status = "withdrawn", withdrawn = "1990", replacedBy = "DE" },
	["NT"] = { iso3166_3 = "NTHH", alpha3 = "NTZ", numeric = "536", name = "Neutral Zone",                         status = "withdrawn", withdrawn = "1993", splitInto = { "IQ", "SA" } },
	["TP"] = { iso3166_3 = "TPTL", alpha3 = "TMP", numeric = "626", name = "East Timor",                           status = "withdrawn", withdrawn = "2002", replacedBy = "TL" },
	["YD"] = { iso3166_3 = "YDYE", alpha3 = "YMD", numeric = "720", name = "Democratic Yemen",                     status = "withdrawn", withdrawn = "1990", replacedBy = "YE" },
	["YU"] = { iso3166_3 = "YUCS", alpha3 = "YUG", numeric = "891", name = "Yugoslavia",                           status = "withdrawn", withdrawn = "2003", splitInto = { "BA", "HR", "MK", "RS", "ME", "SI" } },
	["ZR"] = { iso3166_3 = "ZRCD", alpha3 = "ZAR", numeric = "180", name = "Zaire",                                status = "withdrawn", withdrawn = "1997", replacedBy = "CD" },
}

-- 3. Nạp an toàn dữ liệu Translation Hardtext (DRY)
local function loadOptionalTran(modName)
	if mw and mw.loadData then
		local ok, d = pcall(mw.loadData, modName)
		if ok and type(d) == "table" then return d end
	end
	local ok, d = pcall(require, modName)
	if ok and type(d) == "table" then return d end
	return nil
end

local tranData = loadOptionalTran("Module:I18n/ISO 3166/tran")
	or loadOptionalTran("Module:I18n/ISO 3166/data")
	or {}

-- 4. Unified alias registry (Module:I18n/Alias)
--    Mọi chỉ mục tra ngược (Alpha-3, Numeric, tên, altnames, mã kế thừa lịch sử,
--    bản dịch) được dựng DUY NHẤT từ baseData + historicalData + tranData, nên
--    không thể lệch khỏi bản ghi gốc.
local Alias = require("Module:I18n/Alias")
local NS = "iso3166"

--- Chuẩn hoá khoá: không phân biệt hoa thường; mã số được đệm 0 ("40" → "040").
local function normalize(s)
	local k = Alias.normalizers.default(s)
	if k:match("^%d%d?$") then k = string.rep("0", 3 - #k) .. k end
	return k
end

local function loader(api)
	local codes = {}
	for alpha2 in pairs(baseData) do codes[#codes + 1] = alpha2 end
	table.sort(codes)

	for _, alpha2 in ipairs(codes) do
		local d = baseData[alpha2]
		local isProject = d.status ~= nil -- 'project-defined' | 'user-assigned'
		api.addRecord(alpha2, d)
		if d.alpha3 then api.register(d.alpha3, alpha2, isProject and "project" or "official") end
		if d.numeric and d.numeric ~= "000" then
			api.register(d.numeric, alpha2, isProject and "project" or "official")
		end
		api.register(d.name, alpha2, "name")
		if d.isoname then api.register(d.isoname, alpha2, "name") end
		for _, alt in ipairs(d.altnames or {}) do api.register(alt, alpha2, "project") end
	end

	-- Đăng ký các mã bảo lưu / lịch sử có ánh xạ kế thừa 1-1 rõ ràng (vd: ZR → CD, BU → MM, UK → GB)
	local rCodes = {}
	for k in pairs(reservedData) do rCodes[#rCodes + 1] = k end
	table.sort(rCodes)
	for _, k in ipairs(rCodes) do
		local r = reservedData[k]
		if r.replacedBy and baseData[r.replacedBy] then
			api.register(k, r.replacedBy, "historical")
			if r.alpha3 then api.register(r.alpha3, r.replacedBy, "historical") end
			if r.numeric then api.register(r.numeric, r.replacedBy, "historical") end
		end
	end

	local hCodes = {}
	for k in pairs(historicalData) do hCodes[#hCodes + 1] = k end
	table.sort(hCodes)
	for _, k in ipairs(hCodes) do
		local h = historicalData[k]
		if h.replacedBy and baseData[h.replacedBy] then
			api.register(k, h.replacedBy, "historical")
			if h.iso3166_3 then api.register(h.iso3166_3, h.replacedBy, "historical") end
			if h.alpha3 then api.register(h.alpha3, h.replacedBy, "historical") end
			if h.numeric and h.numeric ~= baseData[h.replacedBy].numeric then
				api.register(h.numeric, h.replacedBy, "historical")
			end
		end
	end

	for _, alpha2 in ipairs(codes) do
		local row = tranData[alpha2]
		if type(row) == "table" then
			local langs = {}
			for lang in pairs(row) do langs[#langs + 1] = lang end
			table.sort(langs)
			for _, lang in ipairs(langs) do api.register(row[lang], alpha2, "translation") end
		end
	end
end

Alias.define(NS, { loader = loader, normalize = normalize })

--- Phân giải bất kỳ mã/tên/alias nào về Alpha-2.
--  @return alpha2, kind | nil, info (info.ambiguous khi mơ hồ)
function M.resolve(input)
	return Alias.resolve(NS, input)
end

--- Toàn bộ metadata của một quốc gia / vùng lãnh thổ đang cấp phát.
function M.getData(code)
	if not code then return nil end
	local alpha2 = Alias.resolve(NS, code)
	return alpha2 and baseData[alpha2] or nil
end

--- Tra cứu thông tin mã bảo lưu đặc biệt (Exceptionally Reserved, vd: 'EU', 'SU', 'UK').
function M.getReserved(code)
	if not code then return nil end
	local k = string.upper(Alias.normalizers.default(tostring(code)))
	return reservedData[k]
end

--- Tra cứu thông tin mã lịch sử đã rút khỏi ISO 3166-1 (ISO 3166-3, vd: 'YU', 'CS', 'AN', 'ZR').
function M.getHistorical(code)
	if not code then return nil end
	local k = string.upper(Alias.normalizers.default(tostring(code)))
	if historicalData[k] then return historicalData[k] end
	for _, h in pairs(historicalData) do
		if h.iso3166_3 == k or h.alpha3 == k then return h end
	end
	return nil
end

--- Liệt kê tất cả mã Alpha-2 trong baseData (tuỳ chọn lọc theo status:
--  'officially-assigned', 'project-defined', 'user-assigned').
function M.getAllCodes(statusFilter)
	local all = Alias.getCanonicals(NS)
	if not statusFilter then return all end
	local out = {}
	for _, c in ipairs(all) do
		local st = (baseData[c] and baseData[c].status) or "officially-assigned"
		if st == statusFilter then out[#out + 1] = c end
	end
	return out
end

--- Mọi alias trỏ về một mã (tra ngược).
function M.getAliases(code)
	local alpha2 = Alias.resolve(NS, code)
	return alpha2 and Alias.getAliases(NS, alpha2) or {}
end

--- Báo cáo toàn vẹn dữ liệu (xung đột, alias mơ hồ, alias treo).
function M.validate()
	return Alias.validate(NS)
end

function M.getMeta()
	return M._meta
end

-- 4. Engine tra cứu tên (API giữ nguyên chữ ký cũ)
function M.getName(code, targetLang, fallbacks)
	if not code then return nil end
	local raw = Alias.normalizers.default(tostring(code))

	-- Phân giải Alpha-3 / Numeric / tên / alias về Alpha-2
	local alpha2 = Alias.resolve(NS, code)
	local country = alpha2 and baseData[alpha2]
	if not country then
		local uupper = (mw and mw.ustring and mw.ustring.upper) or string.upper
		return uupper(raw) -- Không có trong CSDL
	end

	local function checkTran(langCode)
		if langCode and tranData[alpha2] and tranData[alpha2][langCode] then
			return tranData[alpha2][langCode]
		end
		return nil
	end

	-- A. Tìm đích danh ngôn ngữ yêu cầu
	local result = checkTran(targetLang)
	if result then return result end

	-- B. Nếu không có, quét qua chuỗi Fallback (ví dụ: zh-hant -> zh)
	if fallbacks and targetLang and fallbacks[targetLang] then
		for _, fbLang in ipairs(fallbacks[targetLang]) do
			if fbLang == "en" then break end -- Tới 'en' thì thoát vòng lặp để xử lý ở bước C
			result = checkTran(fbLang)
			if result then return result end
		end
	end

	-- C. Cuối cùng, DRY Fallback (về tên tiếng Anh mặc định)
	return country.name
end

return M
