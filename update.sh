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
pushd "${BASEDIR}" > /dev/null
git pull --rebase --stat origin master
if [[ $? -eq 0 ]]; then
    echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully updated ${tfg_yellow}dotfiles${tfg_reset}"
else
    echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to update ${tfg_yellow}dotfiles${tfg_reset}"
fi
popd > /dev/null

# =========================================================
# Update vim plugins
# =========================================================
vim +PlugUpdate +PlugClean +PlugUpgrade +qall

if [[ $? -eq 0 ]]; then
    echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully updated ${tfg_yellow}vimrc${tfg_reset}"
else
    echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to update ${tfg_yellow}vimrc${tfg_reset}"
fi

# =========================================================
# Pull zprezto
# =========================================================
pushd "${ZPRESTODIR}" > /dev/null
git pull
zprezto_result=$?
git submodule update --init --recursive
zprezto_result=$(( zprezto_result && $? ))
if [[ ${zprezto_result} -eq 0 ]]; then
    echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully updated ${tfg_yellow}zprezto${tfg_reset}"
else
    echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to update ${tfg_yellow}zprezto${tfg_reset}"
fi
popd > /dev/null
