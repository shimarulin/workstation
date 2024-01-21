#!/usr/bin/env bash

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11  #)Created by argbash-init v2.10.0
# Rearrange the order of options below according to what you would like to see in the help message.
# ARG_OPTIONAL_SINGLE([group], [g], [Group of vars. One of 'all' or 'dev'], [all])
# ARG_HELP([Setup Ansible variables])
# DEFINE_SCRIPT_DIR_GNU
# ARGBASH_GO

# [ <-- needed because of Argbash

TARGET_DIR=$(readlink -f "$script_dir/../..")

if [ "$_arg_group" = 'all' ]; then
  TEMPLATE_DIR=$(readlink -f "$script_dir/../templates/template_ansible_vars_all")
  IP_COUNTRY_CODE=$(curl https://ipapi.co/country/)

  env COUNTRY_CODE="$IP_COUNTRY_CODE" copier copy --UNSAFE "$TEMPLATE_DIR" "$TARGET_DIR"
elif [ "$_arg_group" = 'dev' ]; then
  TEMPLATE_DIR=$(readlink -f "$script_dir/../templates/template_ansible_vars_dev")
  GIT_USER_NAME=$(git config user.name)
  GIT_USER_EMAIL=$(git config user.email)

  env GIT_USER_NAME="$GIT_USER_NAME" GIT_USER_EMAIL="$GIT_USER_EMAIL" copier copy --UNSAFE "$TEMPLATE_DIR" "$TARGET_DIR"
fi

# ] <-- needed because of Argbash
