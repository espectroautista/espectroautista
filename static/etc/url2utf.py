#!/usr/bin/python

import re, sys

def hex2chr(mo):
	return chr(int(mo.group(1), 16))

p = re.compile('%(..)')

for line in sys.stdin:
	sys.stdout.write(p.sub(hex2chr, line))

# vim:ts=4:sw=4:ai
