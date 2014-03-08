#!/bin/bash

# setup the system
# the location where the install files live
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# setup a symlink to the vimrc file
VIMRC="/.vimrc"
ln -s $DIR$VIMRC $HOME/.vimrc

# can't symlink gitconfig, must copy
GITRC="/.gitconfig"
cp $DIR$GITRC $HOME/.gitconfig

# setup the bash profile
BASHALIAS="/.bash_aliases"
ln -s $DIR$BASHALIAS $HOME/.bash_aliases

# setup the ssh config file
if [ ! -d "$HOME/.ssh/" ]; then
    mkdir $HOME/.ssh
fi
ssh-keygen -t rsa

SSHCONFIG="/config"
ln -s $DIR$SSHCONFIG $HOME/.ssh/config

# make a local bin folder and link project to it
echo '# automatic configuration values' >> $HOME/.bashrc
mkdir $HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> $HOME/.bashrc
PROJECT="/project.sh"
ln -s $DIR$PROJECT ~/bin/generate-project

# you complete me aliases
mkdir $HOME/.ycm
echo "alias gen_ycm='cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=\"ON\" && cp compile_commands.json $HOME/.ycm'" >> $HOME/.bashrc
echo '# end automatic configuration values' >> $HOME/.bashrc
