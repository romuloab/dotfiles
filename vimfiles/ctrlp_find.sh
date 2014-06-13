#!/bin/bash
DIR=$1
EXPDIR=/home/expensify/sources/expensify/staging/www/git/expensify.com
if [ "$1" = "/job/evn" ]; then
    find /job/evn/{devtools,scripts,wctl,web,src,www,templates}/ \( -path /job/evn/web/media -o -path /job/evn/web/media-private \) -prune -o -name '*' -type f | grep -v '~$'
elif [ "$1" = "/job/sabia" ]; then
    find /job/sabia/ \( -path /job/sabia/upload -or -path /job/sabia/.git -or -path /job/sabia/bower_components \) -prune -o -name '*' -type f | grep -v '~$' | grep -v 'swp$'
elif [ "$1" = "/web" ] || [ "$1" = "$EXPDIR" ]; then
    find $EXPDIR \( \
        -path $EXPDIR/externalLib -or \
        -path $EXPDIR/buildtools -or \
        -path $EXPDIR/.git -or \
        -path $EXPDIR/node_modules \
        \) -prune -o -name '*' -type f | grep -v '~$' | grep -v 'swp$'
else
    git ls-files
    git ls-files --exclude-standard --others
#    find $DIR -type f
fi
