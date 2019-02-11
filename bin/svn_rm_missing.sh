#!/bin/bash

svn st | grep ! | cut -d! -f2 | sed 's/^ *//' | sed 's/^/"/g' | sed 's/$/"/g' | xargs svn rm
