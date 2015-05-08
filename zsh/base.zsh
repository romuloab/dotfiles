export EDITOR=vim
export GOPATH=/source/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
export DVTM_TERM=dvtm

# Let's remove any pre-existing aliases. These
# aliases are quite common in git plugins
unalias gb gs gh gp 2>/dev/null
alias gs='git status'
alias gh='git diff HEAD'
alias gp='git push origin $GIT_BRANCH:$GIT_BRANCH'

function gb {
    local branch=$1
    if git branch | grep $branch >/dev/null; then
        git checkout $branch
    else
        git fetch origin
        git checkout -b $branch origin/master
    fi
}

alias vim='vim -p'
alias vi='vim'
alias v='vim'

function vack {
    vim -p `ack -l $*`
}
