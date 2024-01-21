import subprocess
import questionary

from tools.utils.validators import NonEmptyStringValidator


def ask_git_user_name() -> str:
    git_user_name: str = (
        subprocess
        .run(["git", "config", "user.name"], capture_output=True)
        .stdout
        .strip()
        .decode()
        or ""
    )

    git_user_name = (
        questionary
        .text(
            "Git user name:",
            validate=NonEmptyStringValidator,
            default=git_user_name
        )
        .ask()
    )

    return git_user_name


def ask_git_user_email() -> str:
    git_user_email = (
        subprocess
        .run(["git", "config", "user.email"], capture_output=True)
        .stdout
        .strip()
        .decode()
        or ""
    )

    git_user_email = (
        questionary
        .text(
            "Git user email:",
            validate=NonEmptyStringValidator,
            default=git_user_email
        )
        .ask()
    )

    return git_user_email
