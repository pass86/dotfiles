#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import shutil
import subprocess

try:
    # Configure your favorite merge program here.
    MERGE = "/usr/local/bin/vimdiff"

    # Get the paths provided by Subversion.
    BASE = sys.argv[1]
    THEIRS = sys.argv[2]
    MINE = sys.argv[3]
    MERGED = sys.argv[4]

    # Replace ‘merged’ file with a copy of ‘mine’
    shutil.copy(MINE, MERGED)

    cmd = [MERGE, BASE, MERGED, THEIRS]
    subprocess.check_call(cmd)
except:
    sys.exit(1)
