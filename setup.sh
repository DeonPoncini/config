#!/bin/bash

declare -a packages=(
    apache2
    bison
    build-essential
    bzip2
    chromium-browser
    clang
    cmake
    doxygen
    flex
    gcc
    git
    gparted
    libapache2-mod-php5
    libglew-dev
    libglm-dev
    libbz2-dev
    meld
    mercurial
    mysql-server
    openjdk-7-jdk
    openssh-server
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
    xorg-dev
    )

sudo apt-get --yes --force-yes install ${packages[@]}
