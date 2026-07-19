#!/bin/bash

git submodule update --remote vim/plugins/coc.nvim

cd vim/plugins/coc.nvim
git submodule update --init --recursive
cd - > /dev/null
