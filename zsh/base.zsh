export EDITOR=vim
export GOPATH=$HOME/Projects/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin:$HOME/.cargo/bin
export CDPATH=$HOME/Dropbox/Projects/
export DVTM_TERM=dvtm
export LC_ALL=C
#export TERM=dvtm-256color
export HOMEBREW_GITHUB_API_TOKEN=4284972390ef19e88691426a7677e8ba07652718
export PYTHONIOENCODING=utf-8

setopt auto_cd

# Oh-my-zsh config
# Put the configuration here because I keep forgetting to backup the original file
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
plugins=(git jira pip python sudo)
export ZSH=$HOME/.oh-my-zsh

# Let's remove any pre-existing aliases. These
# aliases are quite common in git plugins
unalias gb gs gh gp 2>/dev/null
alias gs='git status --short'
alias gh='git diff HEAD'

function lsd {
    ls $@ -d */
}

alias land='(cd ~/interana/backend/www/ && yarn test && arc land)'

function feature {
    (cd ~/interana/backend/www/ && git fetch origin && arc feature $1 origin/master)
}

function vm {
    local vmrun="/Applications/VMware Fusion.app/Contents/Library/vmrun"
    local args='-T fusion start'
    local vmname=$1
    local vmpath="$HOME/Documents/Virtual Machines.localized/${vmname}.vmwarevm/${vmname}.vmx"
    echo $vmrun $args "$vmpath" nogui
    $vmrun -T fusion start "$vmpath" "nogui"
}

function gbranch {
    local branch=$(git rev-parse --symbolic-full-name HEAD)
    echo -n ${branch#refs/heads/}
}

function gp {
    local branch=$(gbranch)
    command git push origin $branch:$branch
}

function gb {
    if [[ -z $1 ]]; then
        command git branch
        return
    fi
    local branch=$1
    if command git branch | command grep $branch >/dev/null; then
        command git checkout $branch
    else
        command git fetch origin
        command git checkout -b $branch origin/master
    fi
}

function gfix {
    vim -p $(git status --short | grep ^UU | cut -c 4-)
}

# alias vim='TERM=tmux-256color nvim -p'
alias vim='nvim -p'
alias vi='nvim'
alias v='nvim'

# I usually search for something in Ack, then just press up arrow, ^a, v, and enter
function vack {
    command nvim -p $(ack -l $*)
}

function vpt {
    command nvim -p $(pt -l --nocolor $*)
}

function vmsess {
    test -z $VM && echo "No VM env" && return 1
    test -z $SESS && echo "No SESS env" && return 1
    reset
    ssh -t $VM "(cd ~/interana/backend/www/src; tmux attach-session -t $SESS || tmux new-session -s $SESS \\; split-pane -h \\; split-pane \\; select-pane -t 0 \\; resize-pane -t 0 -x 120)"
}

alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g G='| grep'

alias dvtm='TERM=dvtm-256color dvtm'
alias tmux='tmux -u'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

DISABLE_UNTRACKED_FILES_DIRTY="true"
source $ZSH/oh-my-zsh.sh

# theme based on nanotech
PROMPT='%F{green}%2c%F{blue} [%f '
RPROMPT='$(git_prompt_info) %F{blue}] %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

if [ ! -z "$SSH_TTY" ]; then
    PROMPT="%F{cyan}$USER@$(hostname) %F{green}%2c%F{blue} [%f "
fi
