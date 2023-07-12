#!/usr/bin/env bash

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11 #)Created by argbash-init v2.10.0
# DEFINE_SCRIPT_DIR
# Rearrange the order of options below according to what you would like to see in the help message.
# ARG_POSITIONAL_SINGLE([path], [Path to the Ansible roles directory, resolved to "./roles" if no argument is given], [""])
# ARG_HELP([Ansible role generator])
# ARGBASH_GO

# [ <-- needed because of Argbash

TEMPLATE_DIR=$(readlink -f "$script_dir/../templates/template_ansible_role")

GIT_USER_NAME=$(git config user.name)
GIT_USER_EMAIL=$(git config user.email)
ANSIBLE_ROLE_AUTHOR="$GIT_USER_NAME <$GIT_USER_EMAIL>"

if [ -z "$_arg_path" ]; then
  TARGET_DIR=$(readlink -f "$script_dir/../../roles")
else
  TARGET_DIR="$_arg_path"
fi

env ANSIBLE_ROLE_AUTHOR="$ANSIBLE_ROLE_AUTHOR" copier copy --UNSAFE "$TEMPLATE_DIR" "$TARGET_DIR"

# ] <-- needed because of Argbash
