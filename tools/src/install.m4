#!/usr/bin/env bash

# ----------------------------------
# Global error handler
# ----------------------------------
# exit when any command fails
set -e

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11 #)Created by argbash-init v2.10.0
# Rearrange the order of options below according to what you would like to see in the help message.
# ARG_OPTIONAL_BOOLEAN([development], [d], [Install development requirements])
# ARG_OPTIONAL_BOOLEAN([setup], [s], [Setup Ansible vars], [on])
# ARG_POSITIONAL_SINGLE([destination], [Project path, '~/.config/workstation' by default or './workstation' for --development option], [""])
# ARG_HELP([Get the workstation Ansible configuration, install the configuration dependencies and configuration setup])
# DEFINE_SCRIPT_DIR_GNU
# ARGBASH_GO

# [ <-- needed because of Argbash

# ----------------------------------
# Output style
# ----------------------------------
STYLE_OFF=$(tput sgr0)
STYLE_INFO=$(tput setaf 6)
STYLE_PATH=$(tput setaf 3)

# ----------------------------------
# User bin
# ----------------------------------
USER_BIN="${HOME}/.local/bin"

# ----------------------------------
# Resolve this script directory name
# ----------------------------------
SCRIPT_DIR_NAME="${script_dir%"${script_dir##*[!/]}"}" # extglob-free multi-trailing-/ trim
SCRIPT_DIR_NAME="${SCRIPT_DIR_NAME##*/}"               # remove everything before the last /
SCRIPT_DIR_NAME=${SCRIPT_DIR_NAME:-/}                  # correct for dirname=/ case

# ----------------------------------
# Resolve path to clone configuration
# ----------------------------------
if [ -z "$_arg_destination" ]; then
  if [ "$_arg_development" = on ]; then
    TARGET_PATH=./workstation
  else
    TARGET_PATH=~/.config/workstation
  fi
else
  TARGET_PATH="$_arg_destination"
fi

if [ "$SCRIPT_DIR_NAME" = bin ]; then
  TARGET_PATH=$(readlink -f "$script_dir/../../")
fi

# ----------------------------------
# Get a name of configuration parent dir
# ----------------------------------
TARGET_DIR=$(dirname "$TARGET_PATH")

upgrade_system() {
  echo "${STYLE_INFO}Upgrade system packages${STYLE_OFF}"
  sudo pacman -Syu
}

install_system_requirements() {
  echo "${STYLE_INFO}Install Ansible configuration requirements${STYLE_OFF}"
  # Ansible community.general.github_release module requirements:
  # - python-github3py
  # - python-pyjwt
  # See https://docs.ansible.com/ansible/latest/collections/community/general/github_release_module.html#requirements
  # Ansible community.general.dconf module requirements:
  # - python-psutil
  # Poetry [https://python-poetry.org/] need to run internal tools
  sudo pacman -S ansible git python-pipx python-poetry python-github3py python-pyjwt python-psutil --needed

  # Install Copier template render [https://github.com/copier-org/copier]
  pipx install copier
  pipx inject copier jinja2_getenv_extension
  pipx inject copier copier-templates-extensions
}

install_project_requirements() {
  echo "${STYLE_INFO}Install project dependencies${STYLE_OFF}"
  poetry install -C "$TARGET_PATH"
}

install_development_system_requirements() {
  echo "${STYLE_INFO}Install Ansible configuration development requirements${STYLE_OFF}"
  # - Argbash [https://argbash.readthedocs.io/en/stable/index.html]
  # - Ansible Lint [https://ansible.readthedocs.io/projects/lint/]
  # - shfmt [https://github.com/mvdan/sh]
  sudo pacman -S ansible-lint argbash shfmt --needed

  # Install Poe the Poet [https://poethepoet.natn.io/index.html] - a batteries included task runner that works well with poetry.
  pipx install poethepoet

  # Install pre-commit [https://pre-commit.com/] - a framework for managing and maintaining multi-language pre-commit hooks
  pipx install pre-commit

  # Install yamlfix [https://lyz-code.github.io/yamlfix/] - simple opinionated yaml formatter
  pipx install yamlfix

  # Install Mdformat [https://mdformat.readthedocs.io/en/stable/] - CommonMark compliant Markdown formatter
  pipx install mdformat

  # Install Mdformat plugin [https://github.com/hukkin/mdformat-shfmt] to format shell code blocks
  pipx inject mdformat mdformat-shfmt
}

export_path() {
  echo "${STYLE_INFO}Add ${STYLE_PATH}${USER_BIN}${STYLE_OFF} ${STYLE_INFO}to \$PATH temporary${STYLE_OFF}"
  export PATH="${USER_BIN}:${PATH}"
}

ensure_target_dir() {
  if [ "$TARGET_DIR" != '.' ]; then
    echo "${STYLE_INFO}Create '${TARGET_DIR}'${STYLE_OFF}"
    mkdir -p "$TARGET_DIR"
  fi
}

clone_configuration() {
  echo "${STYLE_INFO}Clone Ansible configuration to ${STYLE_PATH}${TARGET_PATH}${STYLE_OFF}"
  git clone https://github.com/shimarulin/workstation.git "$TARGET_PATH"
}

enable_git_hooks() {
  echo "${STYLE_INFO}Enable Git hooks${STYLE_OFF}"
  cd "$TARGET_PATH" || return
  pre-commit install
  cd - || return
}

install_ansible_galaxy_roles() {
  echo "${STYLE_INFO}Install required Ansible Galaxy roles${STYLE_OFF}"
  ansible-galaxy install -r "$TARGET_PATH/requirements.yml"
}

setup_ansible_vars() {
  echo "${STYLE_INFO}Setup Ansible variables${STYLE_OFF}"
  "$TARGET_PATH/tools/bin/setvars"
}

# Installation flow
upgrade_system
install_system_requirements

if [ "$_arg_development" = on ]; then
  install_development_system_requirements
fi

install_project_requirements

export_path

if [[ ! -d "$TARGET_PATH/.git" ]]; then
  ensure_target_dir
  clone_configuration
fi

if [ "$_arg_development" = on ]; then
  enable_git_hooks
fi

install_ansible_galaxy_roles
if [ "$_arg_setup" = on ]; then
  setup_ansible_vars
fi

# ] <-- needed because of Argbash
