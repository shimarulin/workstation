import questionary

from tools.utils.lang import get_preferred_country_lang
from tools.utils.validators import NonEmptyStringValidator


def ask_language_code(country_code="US") -> str:
    language_code = (
        questionary
        .text(
            "Language code (ISO 3166-1 alpha-2 two letters):",
            validate=NonEmptyStringValidator,
            default=get_preferred_country_lang(country_code))
        .ask()
    )

    return language_code
