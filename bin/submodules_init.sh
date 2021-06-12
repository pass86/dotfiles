#!/bin/bash

source $(dirname $0)/list_of_submodules.sh
for mod in $LIST_OF_SUBMODULES; do
    echo $mod
    git submodule update --init $mod
done
