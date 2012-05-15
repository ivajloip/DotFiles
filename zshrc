# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=8192
SAVEHIST=2048
bindkey -e
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

alias develop_ruby_project="cd /media/data/workspace/Ruby/Project/Tourism && rvm 1.9.3"
alias enter_chroot="gksudo ls && sudo chroot /media/data/servers"

# RVM:
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
