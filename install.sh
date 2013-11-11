#!/bin/bash

# setup the system
# the location where the install files live
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# setup a symlink to the vimrc file
VIMRC="/.vimrc"
ln -s $DIR$VIMRC ~/.vimrc

# setup the bash profile
BASHALIAS="/.bash_aliases"
ln -s $DIR$BASHALIAS $HOME/.bash_aliases

# setup the ssh config file
if [ ! -d "$HOME/.ssh/" ]; then
    mkdir $HOME/.ssh
    ssh-keygen -t rsa
fi

SSHCONFIG="/config"
ln -s $DIR$SSHCONFIG $HOME/.ssh/config

# make a local bin folder and link project to it
mkdir ~/bin
echo 'export PATH=$PATH:~/bin' >> ~/.bashrc
PROJECT="/project.sh"
ln -s $DIR$PROJECT ~/bin/generate-project
