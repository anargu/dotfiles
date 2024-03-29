# dotfiles

## npm global packages

Check .npm_packages.txt file

To install global npm packages run the code

    cat .npm_packages.txt | xargs npm install -g

## system packages I use


- [fd](https://github.com/sharkdp/fd#installation) 
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- [LazyGit](https://github.com/jesseduffield/lazygit)
- [z](https://github.com/rupa/z) (or [z for fish](https://github.com/jethrokuan/z))
- [exa](https://the.exa.website)
- [starship shell](https://starship.rs/guide/#%F0%9F%9A%80-installation)
- [pyenv](https://github.com/pyenv/pyenv#automatic-installer)
- [nvm](https://github.com/nvm-sh/nvm#install--update-script)

If you are in Arch Linux, then you may run this command line to install almost all deps above:

    sudo pacman -S fd ripgrep lazygit exa fish

## Install on new PC

    curl -Lks http://bit.do/anargu-dotfiles-sh | /bin/bash


Remember setting config alias to manage git command on dotfiles repository

Check Atlassian's documentation [here](https://www.atlassian.com/git/tutorials/dotfiles)

### If you are using Arch linux

    sudo pacman -S ttf-firacode-nerd
    sudo pacman -S ttf-ibmplex-mono-nerd
    sudo pacman -S clang cmake
    sudo pacman -S telegram-desktop

    # if you are using archcraft then install i3wm flavour
    sudo pacman -Syyu && sudo pacman -S archcraft-i3wm

    # Update packages
    sudo pacman -Syyu
    
    sudo pacman -S tmux

    # tmux dependency (if necessary)
    sudo pacman -S ncurses

    sudo pacman -S neovim

    yay -S wezterm

## Open changes with Lazygit 

    lazygit --git-dir=$HOME/.cfg/ --work-tree=$HOME

## References

https://bitbucket.org/durdn/cfg/src/master/.bin/install.sh
https://www.atlassian.com/git/tutorials/dotfiles
https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/

