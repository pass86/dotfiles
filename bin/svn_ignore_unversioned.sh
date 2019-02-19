#!/bin/bash

svn st | awk '/^?/{print $2}' > svnignore.txt && svn propget svn:ignore >> svnignore.txt && svn propset svn:ignore -F svnignore.txt . && rm svnignore.txt
