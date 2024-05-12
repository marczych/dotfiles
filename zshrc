# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set vi mode.
set -o vi
# Bind 'kj' to switch from insert to normal mode.
bindkey -M viins 'kj' vi-cmd-mode

# Set 'v' to open the command in an editor.
bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey '^R' history-incremental-search-backward

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY         # Do not overwrite.
setopt EXTENDED_HISTORY       # Save time and duration of execution.
setopt HIST_IGNORE_DUPS       # Ignore immediate duplicates.
setopt HIST_IGNORE_SPACE      # Do not save lines that start with a space.
setopt HIST_NO_STORE          # Do not save commands with '!' (only the resulting auto-completed command).
setopt HIST_VERIFY            # Auto-completion with '!' verifies on next line.

# Enable bash completion.
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

REPORTTIME=5

export CLICOLOR=1

# Aliases
alias g='git'
alias gr='cd "$(git rev-parse --show-toplevel)"'
alias ll='ls -l'
alias lla='ls -la'
alias ls='ls --color=auto'
alias ,l=',file-pager'
alias ,tls='tmux ls'
alias ,tsb='tmux show-buffer'
alias ,unix_timestamp='date +%s'

# To make git reset --hard @{u} slightly easier (git reset --hard $u).
export u='@{u}'
# To make things like `git diff origin/master...` slightly easier.
export om='origin/master'

PATH="$HOME/dotfiles/bin:$HOME/dotfiles/bin/machine-specific:$PATH"

if command -v nvim > /dev/null 2>&1; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

function ,hist {
    print -z $(
        ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | \
        fzf +s --tac | \
        sed -r 's/ *[0-9]*\*? *//' | \
        sed -r 's/\\/\\\\/g'
    )
}

function ,cd-temp {
   local name; name="${1:-default}"
   local date; date=$(date "+%Y-%m-%d.%H-%M-%S")
   local template; template="${date}_${name}_XXX"

   if [ "$(uname)" = "Darwin" ]; then
       cd "$(mktemp -d -t "$template")"
   else
       cd "$(mktemp --tmpdir --directory "$template")"
   fi
}

function gmb() {
   git show "$(git merge-base "$@")"
}

if [[ -f ~/dotfiles/zshrc.machine-specific ]]; then
   source ~/dotfiles/zshrc.machine-specific
fi

source ~/dotfiles/powerlevel10k/powerlevel10k.zsh-theme
source ~/dotfiles/p10k.zsh
