#!/bin/sh

sudo apt-get -y install autoconf build-essential libncurses5-dev zlib1g-dev gettext htop man

sudo mkdir -p /code/src
sudo chown -R $USER:$GROUP /code
cd /code
test -f git-2.0.2.tar.gz || wget https://www.kernel.org/pub/software/scm/git/git-2.0.2.tar.gz
test -f fish-2.1.0.tar.gz || wget https://github.com/fish-shell/fish-shell/archive/2.1.0.tar.gz -O fish-2.1.0.tar.gz
test -f dvtm-0.12.tar.gz || wget http://www.brain-dump.org/projects/dvtm/dvtm-0.12.tar.gz
test -f ncurses-5.9.tar.gz || wget ftp://invisible-island.net/ncurses/ncurses-5.9.tar.gz
tar xzf git-2.0.2.tar.gz
tar xzf fish-2.1.0.tar.gz
tar xzf dvtm-0.12.tar.gz
tar xzf ncurses-5.9.tar.gz
which ack 1> /dev/null || (curl http://beyondgrep.com/ack-2.12-single-file | sudo tee -a /usr/local/bin/ack && sudo chmod 0755 /usr/local/bin/ack)
cd git-2.0.2
which git 1> /dev/null || (./configure && make && sudo make install) || (echo 'git fail' && exit)
cd /code
cd fish-shell-2.1.0
which fish 1> /dev/null || (autoconf && ./configure && make && sudo make install) || (echo 'fish fail' && exit)
echo `which fish` | sudo tee -a /etc/shells
sudo chsh -s `which fish` $USER
cd /code
git clone git@github.com:romuloab/dotfiles.git
cd /code/dotfiles
sh install.sh
cd /code/ncurses-5.9
./configure --enable-widec && make && sudo make install
cd /code/dvtm-0.12
cp /code/dotfiles/dvtm/config.mk /code/dvtm-0.12/config.mk
ln -s /code/dotfiles/dvtm/config.h /code/dvtm-0.12/config.h
make && sudo make install
