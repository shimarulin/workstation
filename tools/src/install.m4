#!/usr/bin/env bash

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11  #)Created by argbash-init v2.10.0
# Rearrange the order of options below according to what you would like to see in the help message.
# ARG_OPTIONAL_BOOLEAN([development], [d], [Install development requirements])
# ARG_POSITIONAL_SINGLE([destination], [Project path, '~/.config/workstation' by default or './workstation' for --development option], [""])
# ARG_HELP([Get the workstation Ansible configuration, install the configuration dependencies and configuration setup])
# ARG_VERSION([_ARGBASH_VERSION])
# ARGBASH_GO

# [ <-- needed because of Argbash

if [ -z "$_arg_destination" ]
then
  if [ "$_arg_development" = on ]
  then
    TARGET_PATH=./workstation
  else
    TARGET_PATH=~/.config/workstation
  fi
else
  TARGET_PATH="$_arg_destination"
fi

TARGET_DIR=$(dirname "$TARGET_PATH")

upgrade_system () {
  sudo pacman -Syu
}

install_system_requirements () {
  sudo pacman -S git python --needed --noconfirm
}

install_pip () {
  python -m ensurepip --user
  python -m pip install --user --upgrade pip
}

install_common_python_modules () {
  python -m pip install --user --upgrade ansible psutil copier
}

install_development_python_modules () {
  python -m pip install --user --upgrade jinja2_getenv_extension
}

export_path () {
  export PATH=$HOME/.local/bin:${PATH}
}

ensure_target_dir () {
  mkdir -p "$TARGET_DIR"
}

clone_configuration () {
  git clone https://github.com/shimarulin/workstation.git "$TARGET_PATH"
}

install_ansible_galaxy_roles () {
  ansible-galaxy install -r "$TARGET_PATH/requirements.yml"
}

setup_ansible_vars () {
  source "$TARGET_PATH/tools/bin/setvars"
}

# Installation flow
upgrade_system
install_system_requirements
install_pip
install_common_python_modules

if [ "$_arg_development" = on ]
then
  install_development_python_modules
fi

export_path
ensure_target_dir
clone_configuration
install_ansible_galaxy_roles
setup_ansible_vars

# ] <-- needed because of Argbash
