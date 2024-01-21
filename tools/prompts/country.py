import urllib.request
import questionary
from yaspin import yaspin
from yaspin.spinners import Spinners

from tools.utils.validators import NonEmptyStringValidator


def ask_country_code() -> str:
    with (yaspin(Spinners.dots, text="Resolve country code by IP", color="yellow", attrs=["bold"]) as spinner):
        with urllib.request.urlopen("https://ipapi.co/country/") as response:
            spinner.hide()
            ip_country_code: str = response.read().decode() or ""

        ip_country_code = (
            questionary
            .text(
                "Country code (ISO 3166-1 alpha-2 two uppercase letters):",
                validate=NonEmptyStringValidator,
                default=ip_country_code
            )
            .ask()
        )

    return ip_country_code
