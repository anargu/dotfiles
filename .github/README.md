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

## Install on new PC

    curl -Lks http://bit.do/anargu-dotfiles-sh | /bin/bash


Remember setting config alias to manage git command on dotfiles repository

Check Atlassian's documentation [here](https://www.atlassian.com/git/tutorials/dotfiles)
