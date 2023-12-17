# Authors:
#   Hajin Jang
#

# Force 256 colors
# - This directive must come before zprezto init!
#   (Some ssh clients do not advertise 256 color support)
export TERM=xterm-256color

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# HOME/END Key
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# Disable noclobber (prevents '>' overwriting existing files)
set +o noclobber

# rust - cargo
if [[ -s "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

# pip packages in PATH
if [[ -s "${HOME}/.local/bin" ]]; then
  export PATH=${PATH}:${HOME}/.local/bin
fi

# Alias for .NET 6+
alias dotnet-test-verbose="dotnet test -l \"console;verbosity=detailed\""

# Shell working directory report
# https://github.com/Eugeny/tabby/wiki/Shell-working-directory-reporting
precmd () { echo -n "\x1b]1337;CurrentDir=$(pwd)\x07" }

# vim: ts=2 sw=2 et
