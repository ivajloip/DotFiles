# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=8192
SAVEHIST=2048
bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/media/data/home/ivaylo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# ----Custom options----

# Order history by time of execution (merges if multiple versions existed)
setopt inc_append_history

# Prompt
export PROMPT=$'\n '
export RPROMPT="%F{blue}%B%~%b%f (%F{green}%B%n%b%f@%F{green}%B%m%b%f)"

# Completion
zstyle ':completion:*' menu select
# Auto correction:
setopt correct
setopt autopushd

if ( command -v vimx > /dev/null 2>&1 ); then
  alias vim="vimx"
fi

# Path customizations
PATH="$PATH:$HOME//.rvm/bin:/media/data/workspace/programs/bin" # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Other variables customizations
export EDITOR=vim
export PAGER=less

# useful vim key bindings
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M vicmd '?' history-incremental-search-forward
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M viins '^R' history-incremental-search-backward

# chromium cache configuration
export CHROMIUM_USER_FLAGS="--disk-cache-dir=/tmp --disk-cache-size=50000000"

# fix key behaviour
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward
