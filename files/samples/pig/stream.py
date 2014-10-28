#!/usr/bin/python
import sys

for line in sys.stdin:
    tuple = line.strip("\n").split("\t")
    year = int(tuple[0] or 0)
    print "\t".join(tuple) + "\t" + str(year % 4 == 0 and year % 100 != 0)
