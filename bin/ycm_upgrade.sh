#!/bin/bash

git submodule update --remote vim/plugins/YouCompleteMe
git submodule update --remote vim/plugins/ultisnips

cd vim/plugins/YouCompleteMe
git submodule update --init --recursive
cd - > /dev/null

cd vim/plugins/YouCompleteMe/third_party/ycmd
git submodule update --init --recursive
cd - > /dev/null
