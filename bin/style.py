#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import codecs
import shutil
import subprocess

def style(root):
    for files in os.listdir(root):
        path = os.path.join(root, files)
        ext = os.path.splitext(path)[1]
        if ext == ".cs" or ext == ".c" or ext == ".cc" or ext == ".cpp" or ext == ".h" or ext == ".hpp" or ext == ".java":
            if path.endswith(".pb.h") or path.endswith(".pb.cc"):
                continue
            try:
                ori_file = codecs.open(path, encoding="utf-8", errors="strict")
                for line in ori_file:
                    pass
                ori_file.close()
            except UnicodeDecodeError:
                ori_file.close()
                utf8_path = path + ".utf8"
                utf8_file = open(utf8_path, "w")
                subprocess.call(["iconv", "-f", "gbk", "-t", "utf-8", "-c", path], stdout=utf8_file)
                utf8_file.close()
                os.remove(path)
                shutil.move(utf8_path, path)
            subprocess.call(["astyle", "--formatted", "--style=google", "--ascii", "--suffix=none", "--indent=spaces=4", "--lineend=linux", "--add-brackets", path])
        if os.path.isdir(path):
            style(path)

style(sys.argv[1])
