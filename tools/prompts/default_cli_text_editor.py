import questionary


def ask_default_cli_text_editor() -> str:
    return (
        questionary.select(
            "Default CLI Text Editor:",
            choices=[
                "micro",
                "neovim",
                "helix",
                "nano",
            ]).ask()
    )
