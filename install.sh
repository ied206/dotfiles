#!/bin/bash
BASE=$HOME/.joveler

# Configure tmux
ln -s "${BASE}/.tmux.conf" "${HOME}/.tmux.conf"

# Configure screen
ln -s "${BASE}/.screenrc" "${HOME}/.screenrc"

# Configure vim
ln -s "${BASE}/.vimrc" "${HOME}/.vimrc"

# Install joveler theme on zprezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto" ]]; then
  ln -s "${BASE}/zprezto-prompt/joveler.zsh" "${ZDOTDIR:-$HOME}/.zprezto/modules/prompt/functions/prompt_joveler_setup"
endif

# Configure zshrc
ln -s "${BASE}/.zshrc" "${HOME}/.zshrc"

# Configure prezto
ln -s "${BASE}/.zpreztorc" "${HOME}/.zpreztorc" 

