#/bin/sh

test -f $HOME/.vimrc     && mv $HOME/.vimrc $HOME/.vimrc.bkp         && echo Saved backup of ~/.vimrc to ~/.vimrc.bkp
test -d $HOME/.vim       && mv $HOME/.vim $HOME/.vim.bkp             && echo Saved backup of ~/.vim to ~/.vim.bkp
test -f $HOME/.gitconfig && mv $HOME/.gitconfig $HOME/.gitconfig.bkp && echo Saved backup of ~/.gitconfig to ~/.gitconfig.bkp
test -f $HOME/.screenrc  && mv $HOME/.screenrc $HOME/.screenrc.bkp   && echo Saved backup of ~/.screenrc to ~/.screenrc.bkp

ln -s $PWD/_screenrc $HOME/.screenrc
ln -s $PWD/_vimrc $HOME/.vimrc
ln -s $PWD/vimfiles $HOME/.vim
ln -s $PWD/_gitconfig $HOME/.gitconfig
