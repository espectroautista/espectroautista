#!/usr/bin/python

import re, sys

write = sys.stdout.write

header = """<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE routes SYSTEM "../dtd/routes.dtd">
<routes>
"""

footer = """</routes>
"""

p = re.compile("^/(.+?)\t(.+?)$")

write(header)

for line in sys.stdin:
	(flat, tree) = p.match(line).groups()
	write("\t<route flat='" + flat + "'>" + tree + "</route>\n")

write(footer)

# vim:ts=4:sw=4:ai
