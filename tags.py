#! /usr/bin/env python
# -*- coding: utf-8 -*-

import os 
import sys
import codecs
import shutil
import subprocess

def tags(root): 
    precwd = os.getcwd()
    os.chdir(root)
    subprocess.call(["cscope", "-Rb"])
    subprocess.call(["ctags", "-R", "."])
    os.chdir(precwd)

tags(sys.argv[1])
