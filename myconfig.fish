set -x EVN_ENV /job/evn
set -x LUAU_PROJECT_CONFIG /job/local/tuiuiu.conf.lua
set -x TERM screen-256color
alias gs="git status"
alias gdh="git diff HEAD"
alias pss="ps auxw | grep"

set fish_git_dirty_color red
set CDPATH . ~ /job/diario/templates /job/diario/src/ /job/luau/luau /job/diario

function parse_git_dirty 
    git diff --quiet HEAD ^&-
    if test $status = 1
        echo (set_color $fish_git_dirty_color)"Δ"(set_color normal)
    end
end

function parse_git_branch
    # git branch outputs lines, the current branch is prefixed with a *
    set -l branch (git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/') 
    echo $branch (parse_git_dirty)     
end

function git_current_branch
    if test -z (git branch -quiet 2>| awk '/fatal:/ {print "no git"}')
        printf ' (%s)' (parse_git_branch)
        set_color normal
    else
        printf ''
    end
end

function cur_time
    date +"%H:%M:%S"
end

function fish_prompt
    printf '%s%s%s%s> ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (git_current_branch)
end

function fish_right_prompt
    printf '%s@%s %s' (whoami) (hostname|cut -d . -f 1) (cur_time)
end
