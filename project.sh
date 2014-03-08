#!/bin/bash

# script for creating a new project at a given directory
# to use type project.sh <path> <name>
PD=$1$2
echo 'Setting up project: ' $PD
mkdir -p $PD

echo 'Creating file structure'
# make the project structure
mkdir $PD/_build             # cmake build directory
mkdir $PD/src                # src directory
mkdir $PD/include            # include directory

echo 'Writing build files'
# make a skeleton CMakeLists.txt file
echo 'cmake_minimum_required(VERSION 2.6)     '  > $PD/CMakeLists.txt
echo 'project('$2')                           ' >> $PD/CMakeLists.txt
echo '                                        ' >> $PD/CMakeLists.txt
echo '################################        ' >> $PD/CMakeLists.txt
echo '# Compiler setup                        ' >> $PD/CMakeLists.txt
echo '################################        ' >> $PD/CMakeLists.txt
echo '                                        ' >> $PD/CMakeLists.txt
echo 'add_definitions(-Wall)                  ' >> $PD/CMakeLists.txt
echo '                                        ' >> $PD/CMakeLists.txt
echo 'SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11") ' \
                                                >> $PD/CMakeLists.txt
echo '                                        ' >> $PD/CMakeLists.txt
echo '################################        ' >> $PD/CMakeLists.txt
echo '# Locate source                         ' >> $PD/CMakeLists.txt
echo '################################        ' >> $PD/CMakeLists.txt
echo 'file(GLOB_RECURSE INCLUDES include/*.h) ' >> $PD/CMakeLists.txt
echo 'file(GLOB_RECURSE SRC src/*.cpp)        ' >> $PD/CMakeLists.txt
echo '                                        ' >> $PD/CMakeLists.txt
echo 'include_directories(include)            ' >> $PD/CMakeLists.txt
echo '                                        ' >> $PD/CMakeLists.txt
echo '################################        ' >> $PD/CMakeLists.txt
echo '# Build targets                         ' >> $PD/CMakeLists.txt
echo '################################        ' >> $PD/CMakeLists.txt
echo '                                        ' >> $PD/CMakeLists.txt
echo 'add_executable('$2                        >> $PD/CMakeLists.txt
echo '    ${SRC}                              ' >> $PD/CMakeLists.txt
echo '    ${INCLUDES})                        ' >> $PD/CMakeLists.txt
# make a skelton main.cpp file
echo 'Writing main.cpp                        '
echo '#include <iostream>                     '  > $PD/src/main.cpp
echo '                                        ' >> $PD/src/main.cpp
echo 'int main(int argc, char* argv[])        ' >> $PD/src/main.cpp
echo '{                                       ' >> $PD/src/main.cpp
echo '    std::cout << "Hello, World!\n";     ' >> $PD/src/main.cpp
echo '    return 0;                           ' >> $PD/src/main.cpp
echo '}                                       ' >> $PD/src/main.cpp
echo '                                        ' >> $PD/src/main.cpp

# Generate the compile_commands.json file for auto complete
echo 'Generating compile_commands.json file'
pushd $PD/_build
CXX=cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS="ON"
make
cp compile_commands.json $HOME/.ycm/
popd

# Setup a git repository to track changes
echo 'Setting up git'
echo '_build/'          > $PD/.gitignore
echo '*~'              >> $PD/.gitignore
echo '*.swp'           >> $PD/.gitignore
pushd $PD
git init
git add -A
git commit -m "Initial commit"

# Setup a remote git repository to store changes
echo 'Setting up remote git repo'
ssh deonp@git.sectorsoftware.net "git init --bare git.sectorsoftware.net/$2.git"
git remote add origin deonp@git.sectorsoftware.net:git.sectorsoftware.net/$2.git
git push origin master
git branch --set-upstream master origin/master
ssh deonp@git.sectorsoftware.net "cd git.sectorsoftware.net/$2.git; git update-server-info"
popd
