alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias nvim='/opt/nvim.appimage'

starship init fish | source

if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

