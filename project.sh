#!/bin/bash

# script for creating a new project at a given directory
# to use type project.sh <path> <name>
# $1=path
# $2=name

PD=$1$2            # project full directory
PNAME=$2           # project name
YEAR=$(date +'%Y') # current year

echo 'Setting up project: ' $PD
mkdir -p $PD

echo 'Creating file structure'
# make the project structure
mkdir $PD/_build             # cmake build directory
mkdir $PD/src                # src directory
mkdir $PD/include            # include directory

echo 'Writing build files'
# make a skeleton CMakeLists.txt file
echo 'cmake_minimum_required(VERSION 2.8)'       > $PD/CMakeLists.txt
echo 'project('$PNAME')'                        >> $PD/CMakeLists.txt
echo ''                                         >> $PD/CMakeLists.txt
echo '################################'         >> $PD/CMakeLists.txt
echo '# Compiler setup'                         >> $PD/CMakeLists.txt
echo '################################'         >> $PD/CMakeLists.txt
echo ''                                         >> $PD/CMakeLists.txt
echo 'add_definitions(-Wall)'                   >> $PD/CMakeLists.txt
echo ''                                         >> $PD/CMakeLists.txt
echo 'set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")' \
                                                >> $PD/CMakeLists.txt
echo ''                                         >> $PD/CMakeLists.txt
echo '################################'         >> $PD/CMakeLists.txt
echo '# Locate source'                          >> $PD/CMakeLists.txt
echo '################################'         >> $PD/CMakeLists.txt
echo 'file(GLOB_RECURSE INCLUDES include/*.h)'  >> $PD/CMakeLists.txt
echo 'file(GLOB_RECURSE SRC src/*.cpp)'         >> $PD/CMakeLists.txt
echo ''                                         >> $PD/CMakeLists.txt
echo 'include_directories(include)'             >> $PD/CMakeLists.txt
echo ''                                         >> $PD/CMakeLists.txt
echo '################################'         >> $PD/CMakeLists.txt
echo '# Build targets'                          >> $PD/CMakeLists.txt
echo '################################'         >> $PD/CMakeLists.txt
echo ''                                         >> $PD/CMakeLists.txt
echo 'add_executable('$PNAME                    >> $PD/CMakeLists.txt
echo '    ${SRC}'                               >> $PD/CMakeLists.txt
echo '    ${INCLUDES})'                         >> $PD/CMakeLists.txt
# make a skelton main.cpp file
echo 'Writing main.cpp'
echo '#include <iostream>'                       > $PD/src/main.cpp
echo ''                                         >> $PD/src/main.cpp
echo 'int main(int argc, char* argv[])'         >> $PD/src/main.cpp
echo '{'                                        >> $PD/src/main.cpp
echo '    std::cout << "Hello, World!\n";'      >> $PD/src/main.cpp
echo '    return 0;'                            >> $PD/src/main.cpp
echo '}'                                        >> $PD/src/main.cpp
echo ''                                         >> $PD/src/main.cpp
# make a license file, MIT license
echo 'The MIT License (MIT)'                                                          >  $PD/LICENSE
echo ''                                                                               >> $PD/LICENSE
echo 'Copyright (c) '$YEAR' Deon Poncini'                                             >> $PD/LICENSE
echo ''                                                                               >> $PD/LICENSE
echo 'Permission is hereby granted, free of charge, to any person obtaining a copy'   >> $PD/LICENSE
echo 'of this software and associated documentation files (the "Software"), to deal'  >> $PD/LICENSE
echo 'in the Software without restriction, including without limitation the rights'   >> $PD/LICENSE
echo 'to use, copy, modify, merge, publish, distribute, sublicense, and/or sell'      >> $PD/LICENSE
echo 'copies of the Software, and to permit persons to whom the Software is'          >> $PD/LICENSE
echo 'furnished to do so, subject to the following conditions:'                       >> $PD/LICENSE
echo ''                                                                               >> $PD/LICENSE
echo 'The above copyright notice and this permission notice shall be included in all' >> $PD/LICENSE
echo 'copies or substantial portions of the Software.'                                >> $PD/LICENSE
echo ''                                                                               >> $PD/LICENSE
echo 'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR'     >> $PD/LICENSE
echo 'IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,'       >> $PD/LICENSE
echo 'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE'    >> $PD/LICENSE
echo 'AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER'         >> $PD/LICENSE
echo 'LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,'  >> $PD/LICENSE
echo 'OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE'  >> $PD/LICENSE
echo 'SOFTWARE.'                                                                      >> $PD/LICENSE
# make a skeleton README.md
echo '---'                                                           >  $PD/README.md
echo 'Title: '$PNAME                                                 >> $PD/README.md
echo 'Description:'                                                  >> $PD/README.md
echo 'Author: Deon Poncini'                                          >> $PD/README.md
echo ''                                                              >> $PD/README.md
echo '---'                                                           >> $PD/README.md
echo ''$PNAME                                                        >> $PD/README.md
echo '==============='                                               >> $PD/README.md
echo ''                                                              >> $PD/README.md
echo 'Developed by Deon Poncini <dex1337@gmail.com>'                 >> $PD/README.md
echo ''                                                              >> $PD/README.md
echo 'Downloads'                                                     >> $PD/README.md
echo '---------'                                                     >> $PD/README.md
echo ''                                                              >> $PD/README.md
echo 'Description'                                                   >> $PD/README.md
echo '-----------'                                                   >> $PD/README.md
echo ''                                                              >> $PD/README.md
echo 'Building'                                                      >> $PD/README.md
echo '--------'                                                      >> $PD/README.md
echo ''                                                              >> $PD/README.md
echo 'Usage'                                                         >> $PD/README.md
echo '-----'                                                         >> $PD/README.md
echo ''                                                              >> $PD/README.md
echo 'License'                                                       >> $PD/README.md
echo '-------'                                                       >> $PD/README.md
echo 'Copyright (c) '$YEAR' Deon Poncini. '                          >> $PD/README.md
echo 'See the LICENSE file for license rights and limitations (MIT)' >> $PD/README.md

# Generate the compile_commands.json file for auto complete
echo 'Generating compile_commands.json file'
pushd $PD/_build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS="ON"
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
ssh deonp@git.sectorsoftware.net "git init --bare git.sectorsoftware.net/$PNAME.git"
git remote add origin deonp@git.sectorsoftware.net:git.sectorsoftware.net/$PNAME.git
git remote set-url --add --push origin deonp@git.sectorsoftware.net:git.sectorsoftware.net/$PNAME.git
git push origin master
git branch --set-upstream-to=origin/master master
ssh deonp@git.sectorsoftware.net "cd git.sectorsoftware.net/$PNAME.git; git update-server-info"
popd
