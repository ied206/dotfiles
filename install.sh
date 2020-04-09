#!/bin/bash
BASEDIR="${HOME}/.joveler"

declare -i count=0
tfg_reset="\e[39m"
tfg_yellow="\e[33m"
tfg_boldred="\e[91m"
tfg_boldgreen="\e[92m"
tfg_boldyellow="\e[93m"

function install_config {
    conf_filename="${1##*/}"

    if [[ -f "${HOME}/${conf_filename}" ]]; then
        echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to overwrite existing ${tfg_yellow}${conf_filename}${tfg_reset}"
        return 1
    fi

    ln -s "${BASEDIR}/$1" "${HOME}/${conf_filename}"
    if [[ $? -eq 0 ]]; then
        echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully installed ${tfg_yellow}${conf_filename}${tfg_reset}"
        count=$(( count + 1 ))
        return 0
    else
        echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to create symlink of ${tfg_yellow}${conf_filename}${tfg_reset}"
        return 1
    fi
}

# Install tmux config
install_config ".tmux.conf"

# Install screen config
install_config ".screenrc"

# Install vim config
install_config "vim/.vimrc"
if [[ $? -eq 0 ]]; then
    vim +PluginInstall +qall
fi

# Install zsh config
install_config ".zshrc"

# Install zsh-prezto config
install_config ".zlogin"
install_config ".zpreztorc"
install_config ".zprofile"
install_config ".zshenv"

# Install custom zprezto theme
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto" ]]; then
    if [[ -f "${ZDOTDIR:-$HOME}/.zprezto/modules/prompt/functions/prompt_joveler_setup" ]]; then
        echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to overwrite existing ${tfg_yellow}prompt_joveler_setup${tfg_reset}"
    else
        ln -s "${BASEDIR}/zprezto-prompt/joveler.zsh" "${ZDOTDIR:-$HOME}/.zprezto/modules/prompt/functions/prompt_joveler_setup"
        if [[ $? -eq 0 ]]; then
            echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully installed ${tfg_yellow}custom prezto theme${tfg_reset}"
        else
            echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to create symlink of ${tfg_yellow}joveler.zsh${tfg_reset}"
        fi
    fi
else
    echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to detect prezto. ${tfg_yellow}prezto theme${tfg_reset} was not installed."
fi

# Report result
echo -e "Succesfully installed [${tfg_boldyellow}${count}${tfg_reset}] configs & files."

# vim: ts=4 sw=4 et
