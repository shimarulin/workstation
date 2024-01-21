import os
import urllib.request
from pprint import pprint

import questionary
from questionary import Style
from questionary import Choice
from questionary import Separator
from questionary import prompt

import copier

from tools.prompts.country import ask_country_code
from tools.prompts.default_cli_text_editor import ask_default_cli_text_editor
from tools.prompts.git import ask_git_user_name, ask_git_user_email
from tools.prompts.language import ask_language_code
from tools.prompts.mirror import ask_mirror_country_list
from tools.utils.project import get_project_root
from tools.utils.validators import NonEmptyStringValidator

# System paths
project_root: str = get_project_root()
target_dir: str = os.path.join(project_root)

custom_style_dope = Style(
    [
        ("separator", "fg:#6C6C6C"),
        ("qmark", "fg:#FF9D00 bold"),
        ("question", ""),
        ("selected", "fg:#5F819D"),
        ("pointer", "fg:#FF9D00 bold"),
        ("answer", "fg:#5F819D bold"),
    ]
)


def ask_pystyle(**kwargs):
    # create the question object
    question = questionary.select(
        "What do you want to do?",
        qmark="😃",
        choices=[
            "Order a pizza",
            "Make a reservation",
            Separator(),
            "Ask for opening hours",
            Choice("Contact support", disabled="Unavailable at this time"),
            "Talk to the receptionist",
        ],
        style=custom_style_dope,
        **kwargs,
    )

    # prompt the user for an answer
    return question.ask()


def ask_dictstyle(**kwargs):
    questions = [
        {
            "type": "select",
            "name": "theme",
            "message": "What do you want to do?",
            "choices": [
                "Order a pizza",
                "Make a reservation",
                Separator(),
                "Ask for opening hours",
                {"name": "Contact support", "disabled": "Unavailable at this time"},
                "Talk to the receptionist",
            ],
        }
    ]

    return prompt(questions, style=custom_style_dope, **kwargs)


# def main() -> int:
#     exit_code: int = 0
#     print('Hello')
#     return exit_code

def test():
    from yaspin import yaspin
    from yaspin.spinners import Spinners
    from prompt_toolkit import print_formatted_text
    from prompt_toolkit.formatted_text import FormattedText
    from questionary.constants import DEFAULT_STYLE

    with yaspin(Spinners.dots, text="Resolve country code by IP", color="yellow", attrs=["bold"]) as spinner:
        with urllib.request.urlopen('https://ipapi.co/country/') as response:
            spinner.hide()
            ip_country_code = response.read().decode()

        if len(ip_country_code) > 0:
            text = FormattedText([
                ('class:qmark', '?'),
                ('', ' '),
                ('class:question', 'Country code:'),
                ('', ' '),
                ('class:answer', ip_country_code)
            ])

            print_formatted_text(text, style=DEFAULT_STYLE)
        else:
            ip_country_code = questionary.text("Country code:", validate=NonEmptyStringValidator).ask()

    print(ip_country_code)


def setup_vars_dev():
    template_dir: str = os.path.join(project_root, "tools/templates/template_ansible_vars_dev")

    git_user_name: str = ask_git_user_name()
    git_user_email: str = ask_git_user_email()

    template_data = {
        "git_user_name": git_user_name,
        "git_user_email": git_user_email,
    }
    pprint(template_data)

    copier.run_copy(template_dir, target_dir, template_data, unsafe=True)


def main():
    template_dir: str = os.path.join(project_root, "tools/templates/template_ansible_vars_all")

    country_code: str = ask_country_code()
    language_code: str = ask_language_code(country_code)
    keyboard_layout: str = ''
    mirror_country_list: list[str] = ask_mirror_country_list(country_code)
    default_cli_text_editor: str = ask_default_cli_text_editor()

    # print(mirror_country_list)
    #
    # pprint(ip_country_code)
    # pprint(git_user_name)
    # pprint(git_user_email)
    # pprint(template_dir)
    # pprint(target_dir)
    #
    # toppings = (
    #     questionary.checkbox(
    #         "Select toppings",
    #         choices=["foo", "bar", "bazz"],
    #         validate=lambda a: (
    #             True if len(a) > 0 else "You must select at least one topping"
    #         ),
    #         style=custom_style_dope,
    #     ).ask()
    #     or []
    # )
    #
    # print(f"Alright let's go mixing some {' and '.join(toppings)}")
    #
    # ask_pystyle()

    template_data = {
        "vars_scope": "host_vars",
        "country_code": country_code,
        "language_code": language_code,
        "default_cli_text_editor": default_cli_text_editor,
        "mirror_country_list": mirror_country_list,
    }
    pprint(template_data)

    # copier.run_copy(template_dir, target_dir, template_data, unsafe=True)

# if __name__ == "__main__":
#     print('Run as cli')
#     main()

# if __name__ == "__main__":
#     pprint(ask_pystyle())
