# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
   . /etc/bashrc
fi

# Set vi mode
set -o vi

# Tmux aliases
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tls='tmux ls'
alias tk='tmux kill-session -t'

alias ls='ls --color=always'
alias ll='ls -l'
alias lla='ls -la'
alias swaps='find . -name "*.sw[^f]"'
alias g='git'
alias gr='cd $(git rev-parse --show-toplevel)'

# Quick find for case insensitive file name matching.
function qfind {
   find . -iname "*$1*" -not -name "*.sw?" -not -wholename "*/.git/*"  -not -name '*.class'   -type f
}

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
export LS_COLORS='di=01;35:ln=01;36:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.svg=00;35:*.svgz=00;35:*.mng=00;35:*.pcx=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.m2v=00;35:*.mkv=00;35:*.ogm=00;35:*.mp4=00;35:*.m4v=00;35:*.mp4v=00;35:*.vob=00;35:*.qt=00;35:*.nuv=00;35:*.wmv=00;35:*.asf=00;35:*.rm=00;35:*.rmvb=00;35:*.flc=00;35:*.avi=00;35:*.fli=00;35:*.flv=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:';

export TERM="xterm-256color"
