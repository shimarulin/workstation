#!/usr/bin/env bash

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11  #)Created by argbash-init v2.10.0
# Rearrange the order of options below according to what you would like to see in the help message.
# ARG_OPTIONAL_BOOLEAN([development], [d], [Install development requirements])
# ARG_POSITIONAL_SINGLE([destination], [Project path, '~/.config/workstation' by default or './workstation' for --development option], [""])
# ARG_HELP([Get the workstation Ansible configuration, install the configuration dependencies and configuration setup])
# DEFINE_SCRIPT_DIR_GNU
# ARGBASH_GO

# [ <-- needed because of Argbash

SCRIPT_DIR_NAME="${script_dir%"${script_dir##*[!/]}"}" # extglob-free multi-trailing-/ trim
SCRIPT_DIR_NAME="${SCRIPT_DIR_NAME##*/}"               # remove everything before the last /
SCRIPT_DIR_NAME=${SCRIPT_DIR_NAME:-/}                  # correct for dirname=/ case

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

if [ "$SCRIPT_DIR_NAME" = bin ]
then
  TARGET_PATH=$(readlink -f "$script_dir/../../")
fi

TARGET_DIR=$(dirname "$TARGET_PATH")

upgrade_system () {
  sudo pacman -Syu
}

install_system_requirements () {
  sudo pacman -S git python python-pipx --needed
}

install_development_system_requirements () {
  sudo pacman -S shfmt python-poetry --needed
}

install_common_python_modules () {
  pipx install --include-deps ansible
  pipx inject ansible psutil

  # Install Copier template render (https://github.com/copier-org/copier)
  pipx install copier
  pipx inject copier jinja2_getenv_extension
}

install_development_python_modules () {
  pipx install poethepoet
  pipx install yamlfix
  pipx inject --include-apps ansible ansible-lint
  # DOWN: pipx runpip ansible uninstall ansible-lint

  pipx install mdformat
  pipx inject mdformat mdformat-shfmt
  # DOWN: pipx runpip mdformat uninstall mdformat-shfmt
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

enable_git_hooks () {
  cd "$TARGET_PATH" || return
  git config core.hooksPath ".hooks"
  cd - || return
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
install_common_python_modules

if [ "$_arg_development" = on ]
then
  install_development_system_requirements
  install_development_python_modules
fi

export_path

if [ "$SCRIPT_DIR_NAME" != bin ]
then
  ensure_target_dir
  clone_configuration
fi

if [ "$_arg_development" = on ]
then
  enable_git_hooks
fi

install_ansible_galaxy_roles
setup_ansible_vars

# ] <-- needed because of Argbash
