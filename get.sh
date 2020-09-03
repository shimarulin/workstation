#!/usr/bin/env bash
set -e

# Download install script and installation config

rm -f install.conf
rm -f install.sh

curl -O https://raw.githubusercontent.com/shimarulin/workstation/master/install.conf
curl -O https://raw.githubusercontent.com/shimarulin/workstation/master/install.sh

chmod +x install.sh
