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
# Functions
# =========================================================
function install_config {
    conf_filename="${1##*/}"
    dest_filename="${2##*/}"

    ln -s ${ln_force_arg} "${BASEDIR}/${1}" "${HOME}/${2}"
    if [[ $? -eq 0 ]]; then
        echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully installed ${tfg_yellow}${dest_filename}${tfg_reset}"
        count=$(( count + 1 ))
        return 0
    else
        echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to create symlink of ${tfg_yellow}${dest_filename}${tfg_reset}"
        return 1
    fi
}

function install_prezto_prompt {
    conf_filepath="${1##*/}"
    dest_filename="${2##*/}"

    if [[ -s "${HOME}/.zprezto" ]]; then
        ln -s ${ln_force_arg} "${BASEDIR}/${1}" "${HOME}/.zprezto/modules/prompt/functions/prompt_${2}_setup"
        if [[ $? -eq 0 ]]; then
            echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully installed ${tfg_yellow}custom prezto theme${tfg_reset}"
            count=$(( count + 1 ))
            return 0
        else
            echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to create symlink of ${tfg_yellow}${dest_filename}${tfg_reset}"
            return 1
        fi
    else
        echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to detect prezto. ${tfg_yellow}prezto theme${tfg_reset} was not installed."
        return 1
    fi
}

function check_clone_github_repo {
    repo="${1}"
    clone_url="https://github.com/${repo}.git"
    dest_dir="${2}"

    if [[ -d "${dest_dir}/.git" ]]; then
        echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Checked ${tfg_yellow}${repo}${tfg_reset}"
    else
        echo -e "${tfg_boldgreen}[   INFO]${tfg_reset} Cloning ${tfg_yellow}${repo}${tfg_reset}..."
        git clone --recursive ${clone_url} ${dest_dir}
    fi
}

# =========================================================
# Check and install required git repos
# =========================================================
# Install zsh-preszto & vim-plug
check_clone_github_repo "sorin-ionescu/prezto" "${HOME}/.zprezto"
check_clone_github_repo "VundleVim/Vundle.vim" "${HOME}/.vim/bundle/Vundle.vim"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# =========================================================
# Link files
# =========================================================
# Install tmux config
install_config "tmux/tmux.conf" ".tmux.conf"

# Install screen config
install_config "screen/screen.rc" ".screenrc"

# Install vim config
install_config "vim/vimrc.vim" ".vimrc"
if [[ $? -eq 0 ]]; then
    vim +PlugInstall +qall
    vim +PlugClean +qall
fi

# Install zsh/prezto config
install_config "zsh/zsh.rc" ".zshrc"
install_config "zsh/zlogin.rc" ".zlogin"
install_config "zsh/zprezto.rc" ".zpreztorc"
install_config "zsh/zprofile.rc" ".zprofile"
install_config "zsh/zshenv.rc" ".zshenv"
install_prezto_prompt "zsh/prezto-prompt/joveler.zsh" "joveler"

# Report result
echo -e "Succesfully installed [${tfg_boldyellow}${count}${tfg_reset}] configs & files."

# vim: ts=4 sw=4 et
