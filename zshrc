# Set vi mode.
set -o vi
# Bind 'kj' to switch from insert to normal mode.
bindkey -M viins 'kj' vi-cmd-mode

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

export CLICOLOR=1
export LS_COLORS='di=01;35:ln=01;36:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.svg=00;35:*.svgz=00;35:*.mng=00;35:*.pcx=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.m2v=00;35:*.mkv=00;35:*.ogm=00;35:*.mp4=00;35:*.m4v=00;35:*.mp4v=00;35:*.vob=00;35:*.qt=00;35:*.nuv=00;35:*.wmv=00;35:*.asf=00;35:*.rm=00;35:*.rmvb=00;35:*.flc=00;35:*.avi=00;35:*.fli=00;35:*.flv=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:';

PROMPT_LINE_ONE=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;30m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %b%{\e[0;34m%}%B[%b%{\e[1;37m%}%~%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;33m%}'%D{"%a %b %d, %I:%M"}%b$'%{\e[0;34m%}%B]%b%{\e[0m%}'
PROMPT_LINE_TWO=$'%{\e[0;34m%}%B└─%B[%{\e[1;35m%}$%{\e[0;34m%}%B]>%{\e[0m%}%b '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

# Include vi mode in prompt.
function zle-line-init zle-keymap-select {
   NORMAL_MODE_COLOR=$'\e[0;31m'
   INSERT_MODE_COLOR=$'\e[0;32m'
   END_COLOR=$'\e[0m'

   PROMPT="${PROMPT_LINE_ONE} [${${KEYMAP/vicmd/${NORMAL_MODE_COLOR}NORMAL${END_COLOR}}/(main|viins)/${INSERT_MODE_COLOR}INSERT${END_COLOR}}]
${PROMPT_LINE_TWO}"
   zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

export TERM="xterm-256color"