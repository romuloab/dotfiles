#!/bin/bash
DIR=$1
EXPDIR=/source/expensify.com
if [ "$DIR" = "/job/evn" ]; then
    find /job/evn/{devtools,scripts,wctl,web,src,www,templates}/ \( -path /job/evn/web/media -o -path /job/evn/web/media-private \) -prune -o -name '*' -type f | grep -v '~$'
elif [ "$DIR" = "/job/sabia" ]; then
    find /job/sabia/ \( -path /job/sabia/upload -or -path /job/sabia/.git -or -path /job/sabia/bower_components \) -prune -o -name '*' -type f | grep -v '~$' | grep -v 'swp$'
elif [ "$DIR" = "/web" ] || [ "$DIR" = "$EXPDIR" ]; then
    find $EXPDIR -type f | grep -vE 'externalLib/|buildtools/|.git/|vendor/|node_modules/|.sass-cache/|swp$|build/|~$'
    #find $EXPDIR \( \
    #    -path $EXPDIR/externalLib -or \
    #    -path $EXPDIR/buildtools -or \
    #    -path $EXPDIR/.git -or \
    #    -path $EXPDIR/vendor -or \
    #    -path */node_modules/* \
    #    -path */.sass-cache/* \
    #    \) -prune -o -name '*' -type f \
    #    | grep -v '~$' \
    #    | grep -v 'swp$'
else
    git ls-files
    git ls-files --exclude-standard --others
fi
