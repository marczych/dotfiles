# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
   . /etc/bashrc
fi

alias ll='ls -l'
alias lla='ls -la'
alias g='git'

# User specific aliases and functions
PATH=~/bin:/usr/local/bin:/usr/local/mysql/bin/:/usr/local/sbin/:/usr/sbin/:/sbin/:$PATH:$HOME/
export EDITOR=vim
export SVN_EDITOR=/usr/bin/vim

RED="\[\033[31m\]"
GRE="\[\033[32m\]"
YEL="\[\033[33m\]"
BLU="\[\033[34m\]"
PUR="\[\033[35m\]"
WHI="\[\033[37m\]"
NUL="\[\033[0m\]"

export PS1="${BLU}\u${WHI}@${PUR}\H ${GRE}\t ${PUR}\W${NUL} > "
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
