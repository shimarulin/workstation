#!/usr/bin/env bash
set -e

# Arch Linux Install Script (alis) installs unattended, automated
# and customized Arch Linux system.
# Copyright (C) 2018 picodotdev
#
# https://github.com/picodotdev/alis
# Modified by Vyacheslav Shimarulin

# Remove alis files if it installed

rm -f alis.conf
rm -f alis.sh
rm -f alis-asciinema.sh
rm -f alis-reboot.sh

# Download install scripts and installation config

curl -O https://raw.githubusercontent.com/shimarulin/workstation/master/alis.conf
curl -O https://raw.githubusercontent.com/shimarulin/workstation/master/alis.sh
curl -O https://raw.githubusercontent.com/picodotdev/alis/master/alis-asciinema.sh
curl -O https://raw.githubusercontent.com/picodotdev/alis/master/alis-reboot.sh

chmod +x alis.sh
chmod +x alis-asciinema.sh
chmod +x alis-reboot.sh
