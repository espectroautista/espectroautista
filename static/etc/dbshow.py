#!/usr/bin/python

# dbshow.py a.db | sort

import anydbm as dbm
import sys

input=sys.argv[1]

db = dbm.open(input, 'r')

for (k, v) in db.iteritems():
	print k + '\t' + v

db.close()
