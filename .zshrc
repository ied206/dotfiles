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

# noclobber
set +o noclobber

# rust - cargo
if [[ -s "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

# vim: ts=2 sw=2 et