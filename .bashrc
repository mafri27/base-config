#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTFILESIZE=250000

export EDITOR="vim"

PS1='\[\033[1;73m\][\t]\[\033[1;36m\][\[\033[1;34m\]\u\[\033[1;33m\]@\[\033[1;32m\]\H:\[\033[1;35m\]\w\[\033[1;36m\]]\[\033[1;31m\]\\$\[\033[0m\] '

alias ls='ls --color=auto'

alias ll="ls -lah"
alias vi="vim"
