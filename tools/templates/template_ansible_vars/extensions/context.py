from copier_templates_extensions import ContextHook

country_dict = {'AR': {'country_code': 'AR', 'country_name': 'Argentina'},
                'AU': {'country_code': 'AU', 'country_name': 'Australia'},
                'AT': {'country_code': 'AT', 'country_name': 'Austria'},
                'AZ': {'country_code': 'AZ', 'country_name': 'Azerbaijan'},
                'BD': {'country_code': 'BD', 'country_name': 'Bangladesh'},
                'BY': {'country_code': 'BY', 'country_name': 'Belarus'},
                'BE': {'country_code': 'BE', 'country_name': 'Belgium'},
                'BA': {'country_code': 'BA', 'country_name': 'Bosnia and Herzegovina'},
                'BR': {'country_code': 'BR', 'country_name': 'Brazil'},
                'BG': {'country_code': 'BG', 'country_name': 'Bulgaria'},
                'KH': {'country_code': 'KH', 'country_name': 'Cambodia'},
                'CA': {'country_code': 'CA', 'country_name': 'Canada'},
                'CL': {'country_code': 'CL', 'country_name': 'Chile'},
                'CN': {'country_code': 'CN', 'country_name': 'China'},
                'CO': {'country_code': 'CO', 'country_name': 'Colombia'},
                'HR': {'country_code': 'HR', 'country_name': 'Croatia'},
                'CZ': {'country_code': 'CZ', 'country_name': 'Czechia'},
                'DK': {'country_code': 'DK', 'country_name': 'Denmark'},
                'EC': {'country_code': 'EC', 'country_name': 'Ecuador'},
                'EE': {'country_code': 'EE', 'country_name': 'Estonia'},
                'FI': {'country_code': 'FI', 'country_name': 'Finland'},
                'FR': {'country_code': 'FR', 'country_name': 'France'},
                'GE': {'country_code': 'GE', 'country_name': 'Georgia'},
                'DE': {'country_code': 'DE', 'country_name': 'Germany'},
                'GR': {'country_code': 'GR', 'country_name': 'Greece'},
                'HK': {'country_code': 'HK', 'country_name': 'Hong Kong'},
                'HU': {'country_code': 'HU', 'country_name': 'Hungary'},
                'IS': {'country_code': 'IS', 'country_name': 'Iceland'},
                'IN': {'country_code': 'IN', 'country_name': 'India'},
                'ID': {'country_code': 'ID', 'country_name': 'Indonesia'},
                'IR': {'country_code': 'IR', 'country_name': 'Iran'},
                'IE': {'country_code': 'IE', 'country_name': 'Ireland'},
                'IL': {'country_code': 'IL', 'country_name': 'Israel'},
                'IT': {'country_code': 'IT', 'country_name': 'Italy'},
                'JP': {'country_code': 'JP', 'country_name': 'Japan'},
                'KZ': {'country_code': 'KZ', 'country_name': 'Kazakhstan'},
                'KE': {'country_code': 'KE', 'country_name': 'Kenya'},
                'LV': {'country_code': 'LV', 'country_name': 'Latvia'},
                'LT': {'country_code': 'LT', 'country_name': 'Lithuania'},
                'LU': {'country_code': 'LU', 'country_name': 'Luxembourg'},
                'MU': {'country_code': 'MU', 'country_name': 'Mauritius'},
                'MX': {'country_code': 'MX', 'country_name': 'Mexico'},
                'MD': {'country_code': 'MD', 'country_name': 'Moldova'},
                'MC': {'country_code': 'MC', 'country_name': 'Monaco'},
                'NL': {'country_code': 'NL', 'country_name': 'Netherlands'},
                'NC': {'country_code': 'NC', 'country_name': 'New Caledonia'},
                'NZ': {'country_code': 'NZ', 'country_name': 'New Zealand'},
                'MK': {'country_code': 'MK', 'country_name': 'North Macedonia'},
                'NO': {'country_code': 'NO', 'country_name': 'Norway'},
                'PY': {'country_code': 'PY', 'country_name': 'Paraguay'},
                'PL': {'country_code': 'PL', 'country_name': 'Poland'},
                'PT': {'country_code': 'PT', 'country_name': 'Portugal'},
                'RO': {'country_code': 'RO', 'country_name': 'Romania'},
                'RU': {'country_code': 'RU', 'country_name': 'Russia'},
                'RE': {'country_code': 'RE', 'country_name': 'Réunion'},
                'RS': {'country_code': 'RS', 'country_name': 'Serbia'},
                'SG': {'country_code': 'SG', 'country_name': 'Singapore'},
                'SK': {'country_code': 'SK', 'country_name': 'Slovakia'},
                'SI': {'country_code': 'SI', 'country_name': 'Slovenia'},
                'ZA': {'country_code': 'ZA', 'country_name': 'South Africa'},
                'KR': {'country_code': 'KR', 'country_name': 'South Korea'},
                'ES': {'country_code': 'ES', 'country_name': 'Spain'},
                'SE': {'country_code': 'SE', 'country_name': 'Sweden'},
                'CH': {'country_code': 'CH', 'country_name': 'Switzerland'},
                'TW': {'country_code': 'TW', 'country_name': 'Taiwan'},
                'TH': {'country_code': 'TH', 'country_name': 'Thailand'},
                'TR': {'country_code': 'TR', 'country_name': 'Turkey'},
                'UA': {'country_code': 'UA', 'country_name': 'Ukraine'},
                'GB': {'country_code': 'GB', 'country_name': 'United Kingdom'},
                'US': {'country_code': 'US', 'country_name': 'United States'},
                'UZ': {'country_code': 'UZ', 'country_name': 'Uzbekistan'},
                'VN': {'country_code': 'VN', 'country_name': 'Vietnam'}}


def to_code_name(country):
    return country[1]['country_code'], country[1]['country_name']


country_names = dict(map(to_code_name, country_dict.items()))


class ContextUpdater(ContextHook):
    update = False

    def hook(self, context):
        context["mirror_country_name"] = country_names[context["mirror_country_code"]]
