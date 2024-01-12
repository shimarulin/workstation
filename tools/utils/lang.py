preferred_country_lang_dict = {
    "AF": "fa", "AL": "sq", "DZ": "ar", "AS": "en", "AD": "ca", "AO": "pt", "AI": "en",
    "AG": "en", "AR": "es", "AM": "hy", "AW": "nl", "AU": "en", "AT": "de", "AZ": "az",
    "BS": "en", "BH": "ar", "BD": "bn", "BB": "en", "BY": "be", "BE": "nl", "BZ": "en",
    "BJ": "fr", "BM": "en", "BT": "dz", "BO": "es", "BQ": "nl", "BA": "bs", "BW": "en",
    "BR": "pt", "IO": "en", "BN": "ms", "BG": "bg", "BF": "fr", "BI": "fr", "KH": "km",
    "CM": "en", "CA": "en", "CV": "pt", "KY": "en", "CF": "fr", "TD": "fr", "CL": "es",
    "CN": "zh", "CX": "en", "CC": "ms", "CO": "es", "KM": "ar", "CG": "fr", "CD": "fr",
    "CK": "en", "CR": "es", "HR": "hr", "CU": "es", "CW": "nl", "CY": "el", "CZ": "cs",
    "CI": "fr", "DK": "da", "DJ": "fr", "DM": "en", "DO": "es", "EC": "es", "EG": "ar",
    "SV": "es", "GQ": "es", "ER": "aa", "EE": "et", "ET": "am", "FK": "en", "FO": "fo",
    "FJ": "en", "FI": "fi", "FR": "fr", "GF": "fr", "PF": "fr", "TF": "fr", "GA": "fr",
    "GM": "en", "GE": "ka", "DE": "de", "GH": "en", "GI": "en", "GR": "el", "GL": "kl",
    "GD": "en", "GP": "fr", "GU": "en", "GT": "es", "GG": "en", "GN": "fr", "GW": "pt",
    "GY": "en", "HT": "ht", "VA": "la", "HN": "es", "HK": "zh", "HU": "hu", "IS": "is",
    "IN": "en", "ID": "id", "IR": "fa", "IQ": "ar", "IE": "en", "IM": "en", "IL": "he",
    "IT": "it", "JM": "en", "JP": "ja", "JE": "en", "JO": "ar", "KZ": "kk", "KE": "en",
    "KI": "en", "KP": "ko", "KR": "ko", "KW": "ar", "KG": "ky", "LA": "lo", "LV": "lv",
    "LB": "ar", "LS": "en", "LR": "en", "LY": "ar", "LI": "de", "LT": "lt", "LU": "lb",
    "MO": "zh", "MK": "mk", "MG": "fr", "MW": "ny", "MY": "ms", "MV": "dv", "ML": "fr",
    "MT": "mt", "MH": "mh", "MQ": "fr", "MR": "ar", "MU": "en", "YT": "fr", "MX": "es",
    "FM": "en", "MD": "ro", "MC": "fr", "MN": "mn", "ME": "sr", "MS": "en", "MA": "ar",
    "MZ": "pt", "MM": "my", "NA": "en", "NR": "na", "NP": "ne", "NL": "nl", "NC": "fr",
    "NZ": "en", "NI": "es", "NE": "fr", "NG": "en", "NU": "en", "NF": "en", "MP": "tl",
    "NO": "no", "OM": "ar", "PK": "ur", "PW": "en", "PS": "ar", "PA": "es", "PG": "en",
    "PY": "es", "PE": "es", "PH": "tl", "PN": "en", "PL": "pl", "PT": "pt", "PR": "en",
    "QA": "ar", "RO": "ro", "RU": "ru", "RW": "rw", "RE": "fr", "BL": "fr", "SH": "en",
    "KN": "en", "LC": "en", "MF": "fr", "PM": "fr", "VC": "en", "WS": "sm", "SM": "it",
    "ST": "pt", "SA": "ar", "SN": "fr", "RS": "sr", "SC": "en", "SL": "en", "SG": "en",
    "SX": "nl", "SK": "sk", "SI": "sl", "SB": "en", "SO": "so", "ZA": "zu", "GS": "en",
    "SS": "en", "ES": "es", "LK": "si", "SD": "ar", "SR": "nl", "SJ": "no", "SZ": "en",
    "SE": "sv", "CH": "de", "SY": "ar", "TW": "zh", "TJ": "tg", "TZ": "sw", "TH": "th",
    "TL": "pt", "TG": "fr", "TK": "en", "TO": "to", "TT": "en", "TN": "ar", "TR": "tr",
    "TM": "tk", "TC": "en", "TV": "en", "UG": "en", "UA": "uk", "AE": "ar", "GB": "en",
    "US": "en", "UM": "en", "UY": "es", "UZ": "uz", "VU": "bi", "VE": "es", "VN": "vi",
    "VG": "en", "VI": "en", "WF": "fr", "EH": "ar", "YE": "ar", "ZM": "en", "ZW": "en",
    "AX": "sv"
}


def get_preferred_country_lang(country_code):
    if country_code in preferred_country_lang_dict:
        return preferred_country_lang_dict[country_code]
    else:
        return "en"
