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

GIT_USER_NAME=$(git config user.name)
GIT_USER_EMAIL=$(git config user.email)
IP_COUNTRY_CODE=$(curl https://ipapi.co/country/)

env GIT_USER_NAME="$GIT_USER_NAME" GIT_USER_EMAIL="$GIT_USER_EMAIL" COUNTRY_CODE="$IP_COUNTRY_CODE" copier copy --UNSAFE "$TEMPLATE_DIR" "$TARGET_DIR"

# ] <-- needed because of Argbash
