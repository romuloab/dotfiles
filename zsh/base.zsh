export EDITOR=vim
export GOPATH=/source/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
export DVTM_TERM=dvtm
#export TERM=dvtm-256color

# Let's remove any pre-existing aliases. These
# aliases are quite common in git plugins
unalias gb gs gh gp 2>/dev/null
alias gs='git status --short'
alias gh='git diff HEAD'

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

alias vim='nvim -p'
alias vi='nvim'
alias v='nvim'

# I usually search for something in Ack, then just press up arrow, ^a, v, and enter
function vack {
    command nvim -p $(ack -l $*)
}

function vpt {
    command nvim -p $(pt -l $*)
}

alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g G='| grep'

alias dvtm='TERM=dvtm-256color dvtm'

alias fixphp='npm run grunt:fix -- --php'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
