#!/bin/bash
BASEDIR="${HOME}/.joveler"

# =========================================================
# Check parameter 'bash'
# =========================================================
shell_bash=0
if [[ ${1} = "bash" ]]; then
    shell_bash=1
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
function symlink_config {
    conf_filename="${1##*/}"
    dest_filename="${2##*/}"

    ln -s -f "${BASEDIR}/${1}" "${HOME}/${2}"
    if [[ $? -eq 0 ]]; then
        echo -e "${tfg_boldgreen}[SUCCESS]${tfg_reset} Successfully installed ${tfg_yellow}${dest_filename}${tfg_reset}"
        count=$(( count + 1 ))
        return 0
    else
        echo -e "${tfg_boldred}[WARNING]${tfg_reset} Unable to create symlink of ${tfg_yellow}${dest_filename}${tfg_reset}"
        return 1
    fi
}

function copy_config {
    conf_filename="${1##*/}"
    dest_filename="${2##*/}"

    cp -f "${BASEDIR}/${1}" "${HOME}/${2}"
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
        ln -s -f "${BASEDIR}/${1}" "${HOME}/.zprezto/modules/prompt/functions/prompt_${2}_setup"
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
curl -fLo ~/.vim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# =========================================================
# Link files
# =========================================================
# Install tmux config
symlink_config "tmux/tmux.conf" ".tmux.conf"

# Install screen config
symlink_config "screen/screen.rc" ".screenrc"

# Install vim config
symlink_config "vim/vimrc.vim" ".vimrc"
if [[ $? -eq 0 ]]; then
    vim +PlugInstall +qall
fi

# Install zsh/prezto config
copy_config "zsh/local_zshrc.zsh" ".zshrc"
copy_config "zsh/local_zlogin.zsh" ".zlogin"
copy_config "zsh/local_zpreztorc.zsh" ".zpreztorc"
copy_config "zsh/local_zprofile.zsh" ".zprofile"
copy_config "zsh/local_zshenv.zsh" ".zshenv"
install_prezto_prompt "zsh/prezto-prompt/joveler.zsh" "joveler"

# Install bash config
if [[ ${shell_bash} -eq 1 ]]; then
    symlink_config "bash/bash.bashrc" ".bashrc"
fi

# Report result
echo -e "Succesfully installed [${tfg_boldyellow}${count}${tfg_reset}] configs & files."

# vim: ts=4 sw=4 et
