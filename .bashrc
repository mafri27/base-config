#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTFILESIZE=250000

export EDITOR="vim"

PS1='\[\033[1;73m\][\t]\[\033[1;96m\][\[\033[1;94m\]\u\[\033[1;93m\]@\[\033[1;92m\]\H:\[\033[1;95m\]\w\[\033[1;96m\]]\[\033[1;91m\]\\$\[\033[0m\] '

alias ls='ls --color=auto'

alias ll="ls -lah"
alias vi="vim"
