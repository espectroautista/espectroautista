#!/usr/bin/python

import re, sys

Letters = ( 'A','B','C','D','E','F','G','H','I','J','K','L','M',
			'N','O','P','Q','R','S','T','U','V','W','X','Y','Z' )

assert len(sys.argv) > 1, 'Language code expected'
assert len(sys.argv) > 2, 'Name expected'

Language	= sys.argv[1]
Name		= sys.argv[2]

prefix	= Language + '/' + Name + '_'
input	= open(Language + '/' + Name + '.html', 'r')

p = re.compile('</title')
q = re.compile('id="' + Name)

for letter in Letters:
	output = open(prefix + letter + '.html', 'w')
	input.seek(0)

	for line in input:
		(s, r) = p.subn(': ' + letter + '</title', line)

		if r == 0:
			s = q.sub('id="' + Name + '_' + letter, s)
		output.write(s)
	output.close()

input.close()

# vim:ts=4:sw=4:ai
