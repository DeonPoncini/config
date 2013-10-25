#!/bin/bash

declare -a packages=(
    bison
    build-essential
    bzip2
    chromium-browser
    clang
    cmake
    flex
    gcc
    git
    meld
    mercurial
    subversion
    vim
    )

for i in ${packages[@]}
do
    sudo apt-get --yes --force-yes install $i
done
