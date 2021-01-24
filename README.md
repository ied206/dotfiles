# Joveler's dotfiles

The repo contains my personal dotfiles.

## Prerequisite

Install required programs and frameworks: 

```console
sudo apt update
sudo apt install git vim zsh tmux screen ctags 
chsh -s $(which zsh)
```

## Install

Clone this repo and run `install.sh`:

```console
git clone https://github.com/ied206/dotfiles.git ~/.joveler
~/.joveler/install.sh
```

You can overwrite current settings with `force` argument:

```console
~/.joveler/install.sh force
```

## Update

You may update the dotfiles with `update.sh`:

```console
~/.joveler/update.sh
```

## Support

- tmux
- screen
- vim
- zsh
    - zprezto
    - custom prompt<br>
    ![zsh custom prompt screenshot](./image/zsh-custom-prompt.png)

## License

Licensed under the MIT license.

