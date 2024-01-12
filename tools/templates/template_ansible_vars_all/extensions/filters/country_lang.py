from jinja2.ext import Extension

from tools.utils.lang import get_preferred_country_lang


class CountryLangExtension(Extension):
    def __init__(self, environment):
        super().__init__(environment)
        environment.filters["country_lang"] = get_preferred_country_lang
