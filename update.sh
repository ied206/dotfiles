#!/bin/bash

# ANSI color codes
tfg_reset="\e[39m"
tfg_yellow="\e[33m"
tfg_boldred="\e[91m"
tfg_boldgreen="\e[92m"
tfg_boldyellow="\e[93m"

# 
git pull --rebase --stat origin master
if [[ $? -eq 0 ]]; then
    echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully updated ${tfg_yellow}dotfiles${tfg_reset}"
    return 0
else
    echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to update ${tfg_yellow}dotfiles${tfg_reset}"
    return 1
fi
