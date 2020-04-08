# Joveler's dotfiles

The repo contains my personal dotfiles.

## Install

### Prerequisite

Install required programs and frameworks: 

```console
sudo apt update
sudo apt install git vim zsh tmux screen
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
chsh -s /bin/zsh
```

Clone this repo and run `install.sh`:

```console
git clone https://github.com/ied206/dotfiles.git ~/.joveler
~/.joveler/install.sh
```

## Support

- vim
- zsh
    - zprezto
    - custom prompt
- tmux
- screen

## License

Licensed under the MIT license.
