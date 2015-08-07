#!/usr/bin/env zsh

TMPFILE=/tmp/_REMEMBER_FILES
W='[a-zA-Z0-9/._-]'

# pipe stdin through `tee` and record the output to $TMPFILE
#tee $TMPFILE > /dev/null

# strip command codes
# http://www.commandlinefu.com/commands/view/3584/remove-color-codes-special-characters-with-sed
sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" $TMPFILE \

    #| grep --only-matching --extended-regexp "(~/|/|(\.{1,2}/)+)?(\\.|$W+)"
