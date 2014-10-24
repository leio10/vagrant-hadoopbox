#!/usr/bin/env python
import re
import sys

for line in sys.stdin:
    words = line.split(' ')
    for word in words:
        word = word.strip()
        if word:
            print "%s\t1" % word