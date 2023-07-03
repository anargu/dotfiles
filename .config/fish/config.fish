alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
#ONLY FOR ARCH CONFIG. NVIM WAS INSTALLED WITH PACMAN AND NOT WITH APPIMAGE
#alias nvim='/opt/neovim/nvim.appimage'

starship init fish | source

if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/anargu/.ghcup/bin # ghcup-env

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/anargu/tools.dev/google-cloud-sdk/path.fish.inc' ]; . '/home/anargu/tools.dev/google-cloud-sdk/path.fish.inc'; end

if status is-interactive
  set -gx PATH /usr/local/go/bin/ $PATH

  set -gx GOPATH $HOME/go

  set -gx PATH $GOPATH/bin $PATH

  set -gx CLOUDSDK_PYTHON $HOME/.pyenv/shims/python

  # pyenv
  set -gx PYENV_ROOT $HOME/.pyenv

  set -gx PATH $PYENV_ROOT/bin $PATH

  set -gx PATH $HOME/flutter/flutter_3.10.5/bin $PATH
end

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

status --is-interactive; and pyenv virtualenv-init - | source


# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init --path | source
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/anargu/.ghcup/bin # ghcup-env

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#if test -f /home/whysoserious/miniconda3/bin/conda
#    eval /home/whysoserious/miniconda3/bin/conda "shell.fish" "hook" $argv | source
#end
# <<< conda initialize <<<


# I want to use $@ for all arguments but they don't contain space for me

if type -q flutter
  function flutter-watch
    tmux send-keys "flutter run $1 $2 $3 $4 --pid-file=/tmp/tf1.pid" Enter \;\
    split-window -v \;\
    send-keys 'npx -y nodemon -e dart -x "cat /tmp/tf1.pid | xargs kill -s USR1"' Enter \;\
    resize-pane -y 5 -t 1 \;\
    select-pane -t 0 \;
  end
end
