#!/usr/bin/env python
import re
import sys
last_word = None; total = 0
for line in sys.stdin:
    word, count = line.split('\t', 2)
    if last_word!=word:
        if total:
            print "%s\t%d"%(last_word, total)
        last_word = word
        total = 0
    total += int(count)

if total:
    print "%s\t%d"%(last_word, total)

