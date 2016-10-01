#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os

DIFF = "/usr/local/bin/vimdiff"

# Subversion provides the paths we need as the last two parameters.
LEFT = sys.argv[-2]
RIGHT = sys.argv[-1]

# Call the diff command (change the following line to make sense for your diff program).
cmd = [DIFF, LEFT, RIGHT]
os.execv(cmd[0], cmd)
