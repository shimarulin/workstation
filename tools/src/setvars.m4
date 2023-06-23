#!/usr/bin/env bash

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11  #)Created by argbash-init v2.10.0
# Rearrange the order of options below according to what you would like to see in the help message.
# ARG_HELP([<The general help message of my script>])
# DEFINE_SCRIPT_DIR_GNU
# ARGBASH_GO

# [ <-- needed because of Argbash

TEMPLATE_DIR=$(readlink -f "$script_dir/../templates/template_ansible_vars")
TARGET_DIR=$(readlink -f "$script_dir/../..")

copier copy "$TEMPLATE_DIR" "$TARGET_DIR"

# ] <-- needed because of Argbash
