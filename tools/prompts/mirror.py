import questionary

from tools.utils.mirror import get_mirror_list, get_mirror_country_by_code


def ask_mirror_country_list(default_country="US") -> list[str]:
    mirror_list = get_mirror_list()
    default_mirror_country = get_mirror_country_by_code(default_country)

    return questionary.checkbox(
        "Preferred mirror country (only available on the https://archlinux.org/mirrors/):",
        choices=mirror_list,
        default=default_mirror_country,
        initial_choice=default_mirror_country,
    ).ask()
