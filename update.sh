#!/bin/bash
BASEDIR="${HOME}/.joveler"
#ZPRESTODIR="${HOME}/.zprezto"

# =========================================================
# ANSI color codes
# =========================================================
tfg_reset="\e[39m"
tfg_yellow="\e[33m"
tfg_boldred="\e[91m"
tfg_boldgreen="\e[92m"
tfg_boldyellow="\e[93m"

# =========================================================
# Pull and rebase files
# =========================================================
pushd "${BASEDIR}"
git pull --rebase --stat origin master
pull_result=$?
if [[ ${pull_result} -eq 0 ]]; then
    echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully pulled ${tfg_yellow}dotfiles${tfg_reset}"
else
    echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to update ${tfg_yellow}dotfiles${tfg_reset}"
fi
popd

if [[ ${pull_result} -ne 0 ]]; then
    exit
fi

# =========================================================
# Update vim plugins
# =========================================================
vim +PlugUpdate +qall
vim +PlugClean +qall
vim +PlugUpgrade +qall

# =========================================================
# Pull zprezto
# =========================================================
pushd "${ZPRESTODIR}"
git pull
pull_result=$?
git submodule update --init --recursive
sub_result=$?
if [[ ${pull_result} -eq 0 && ${sub_result} -eq 0 ]]; then
    echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully updated ${tfg_yellow}zprezto${tfg_reset}"
else
    echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to update ${tfg_yellow}zprezto${tfg_reset}"
fi
popd
