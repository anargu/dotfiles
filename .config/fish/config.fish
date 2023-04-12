alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias nvim='/opt/neovim/nvim_0.9.0.appimage'

starship init fish | source

if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

status --is-interactive; and pyenv virtualenv-init - | source

#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/anargu/.ghcup/bin # ghcup-env

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/anargu/tools.dev/google-cloud-sdk/path.fish.inc' ]; . '/home/anargu/tools.dev/google-cloud-sdk/path.fish.inc'; end

if status is-interactive
  set -gx PATH /usr/local/go/bin/ $PATH

  set -gx GOPATH $HOME/go

  set -gx PATH $GOPATH/bin $PATH

  set -gx CLOUDSDK_PYTHON $HOME/.pyenv/shims/python
end


# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init --path | source
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/anargu/.ghcup/bin # ghcup-env
