#!/bin/bash

declare -a packages=(
    apache2
    bison
    build-essential
    bzip2
    chromium-browser
    clang
    cmake
    curl
    doxygen
    flex
    gcc
    ghc
    gimp
    gimp-dds
    git
    gparted
    libapache2-mod-php5
    libassimp-dev
    libglew-dev
    libglm-dev
    libbz2-dev
    meld
    mercurial
    mesa-utils
    mysql-server
    nfs-common
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
    ruby-dev
    subversion
    vim-nox
    vlc
    xorg-dev
    )

sudo apt-get --yes --force-yes install ${packages[@]}
