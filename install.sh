#!/bin/bash
BASEDIR="${HOME}/.joveler"

# =========================================================
# Check force install
# =========================================================
ln_force_arg=""
if [[ ${1} = "force" ]]; then
    ln_force_arg="-f"
fi

# =========================================================
# ANSI color codes
# =========================================================
tfg_reset="\e[39m"
tfg_yellow="\e[33m"
tfg_boldred="\e[91m"
tfg_boldgreen="\e[92m"
tfg_boldyellow="\e[93m"

# =========================================================
# Prepare counter variable
# =========================================================
declare -i count=0

# =========================================================
# Install functions
# =========================================================
function install_config {
    conf_filename="${1##*/}"

    ln -s ${ln_force_arg} "${BASEDIR}/$1" "${HOME}/${conf_filename}"
    if [[ $? -eq 0 ]]; then
        echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully installed ${tfg_yellow}${conf_filename}${tfg_reset}"
        count=$(( count + 1 ))
        return 0
    else
        echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to create symlink of ${tfg_yellow}${conf_filename}${tfg_reset}"
        return 1
    fi
}

function install_prezto_prompt {
    conf_filename="${1##*/}"

    if [[ -s "${HOME}/.zprezto" ]]; then
        ln -s ${ln_force_arg} "${BASEDIR}/${1}" "${HOME}/.zprezto/modules/prompt/functions/prompt_${2}_setup"
        if [[ $? -eq 0 ]]; then
            echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully installed ${tfg_yellow}custom prezto theme${tfg_reset}"
            count=$(( count + 1 ))
            return 0
        else
            echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to create symlink of ${tfg_yellow}${conf_filename}${tfg_reset}"
            return 1
        fi
    else
        echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to detect prezto. ${tfg_yellow}prezto theme${tfg_reset} was not installed."
        return 1
    fi
}

# =========================================================
# Link files
# =========================================================
# Install tmux config
install_config ".tmux.conf"

# Install screen config
install_config ".screenrc"

# Install vim config
install_config "vim/.vimrc"
if [[ $? -eq 0 ]]; then
    vim -E -s +PluginInstall +qall
    vim -E -s +PluginClean +qall
fi

# Install zsh/prezto config
install_config "zsh/.zshrc"
install_config "zsh/.zlogin"
install_config "zsh/.zpreztorc"
install_config "zsh/.zprofile"
install_config "zsh/.zshenv"
install_prezto_prompt "zsh/prezto-prompt/joveler.zsh" "joveler"

# Report result
echo -e "Succesfully installed [${tfg_boldyellow}${count}${tfg_reset}] configs & files."

# vim: ts=4 sw=4 et
