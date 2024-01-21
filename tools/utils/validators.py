import re

from questionary import ValidationError
from questionary import Validator


class PhoneNumberValidator(Validator):
    def validate(self, document):
        ok = re.match(
            r"^([01])?[-.\s]?\(?(\d{3})\)?"
            r"[-.\s]?(\d{3})[-.\s]?(\d{4})\s?"
            r"((?:#|ext\.?\s?|x\.?\s?)(?:\d+)?)?$",
            document.text,
        )
        if not ok:
            raise ValidationError(
                message="Please enter a valid phone number",
                cursor_position=len(document.text),
            )  # Move cursor to end


class NonEmptyStringValidator(Validator):
    def validate(self, document):
        ok = len(document.text) > 0
        if not ok:
            raise ValidationError(
                message="Must contain at least one character",
                cursor_position=len(document.text),
            )  # Move cursor to end
