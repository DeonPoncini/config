#!/bin/bash

declare -a packages=(
    apache2
    bison
    build-essential
    bzip2
    chromium-browser
    clang
    cmake
    flex
    gcc
    git
    libapache2-mod-php5
    meld
    mercurial
    mysql-server
    php5-mysql
    phpmyadmin
    subversion
    vim
    )

for i in ${packages[@]}
do
    sudo apt-get --yes --force-yes install $i
done
