#!/bin/bash

set -ex

if [ ! -f $HOME/.ssh/known_hosts ]; then
    echo "Setup your SSH hosts, bitch!"
    exit 1
fi

GIT_VERSION="2.2.0"
FISH_VERSION="2.1.1"
DVTM_VERSION="0.13"
ACK_VERSION="2.14"
GIT="git-$GIT_VERSION"
FISH="fish-$FISH_VERSION"
DVTM="dvtm-$DVTM_VERSION"
GIT_TAR="$GIT.tar.gz"
FISH_TAR="$FISH.tar.gz"
DVTM_TAR="$DVTM.tar.gz"

ACK="ack-$ACK_VERSION-single-file"

sudo apt-get -y install autoconf build-essential libncurses5-dev zlib1g-dev gettext htop man wget

sudo mkdir -p /code/src
sudo chown -R $USER:$GROUP /code
cd /code
test -f $GIT_TAR || wget https://www.kernel.org/pub/software/scm/git/$GIT_TAR
test -f $FISH_TAR || wget https://github.com/fish-shell/fish-shell/archive/$FISH_VERSION.tar.gz -O $FISH_TAR
test -f $DVTM_TAR || wget http://www.brain-dump.org/projects/dvtm/$DVTM_TAR
test -f ncurses-5.9.tar.gz || wget ftp://invisible-island.net/ncurses/ncurses-5.9.tar.gz
tar xzf $GIT_TAR
tar xzf $FISH_TAR
tar xzf $DVTM_TAR
tar xzf ncurses-5.9.tar.gz
which ack 1> /dev/null || (curl http://beyondgrep.com/$ACK | sudo tee -a /usr/local/bin/ack && sudo chmod 0755 /usr/local/bin/ack)
cd $GIT
which git 1> /dev/null || (./configure && make && sudo make install) || (echo 'git fail' && exit)
cd /code/fish-shell-$FISH_VERSION
which fish 1> /dev/null || (autoconf && ./configure && make && sudo make install) || (echo 'fish fail' && exit)
echo `which fish` | sudo tee -a /etc/shells
sudo chsh -s `which fish` $USER
cd /code
if [ ! -f /code/dotfiles/.git/config ]; then
    git clone git@github.com:romuloab/dotfiles.git
fi
cd /code/dotfiles
sh install.sh
cd /code/ncurses-5.9
./configure --enable-widec && make && sudo make install
cd /code/$DVTM
#cp /code/dotfiles/dvtm/config.mk /code/$DVTM/config.mk
ln -s /code/dotfiles/dvtm/config.h /code/$DVTM/config.h
make && sudo make install
