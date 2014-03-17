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
    libglew-dev
    libbz2-dev
    meld
    mercurial
    mysql-server
    openjdk-7-jdk
    php-mdb2-driver-mysql
    php5-mysql
    phpmyadmin
    python-dev
    qt5-default
    qtcreator
    qttools5-dev
    qttools5-dev-tools
    subversion
    vim
    vlc
    )

for i in ${packages[@]}
do
    sudo apt-get --yes --force-yes install $i
done
