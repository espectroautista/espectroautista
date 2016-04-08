#!/usr/bin/python

# mapdbm.py a.db < data.map

import dbhash as dbm
import sys

output = 'a.db'
if (len(sys.argv) == 2):
	output=sys.argv[1]

db = dbm.open(output, 'c')

for line in sys.stdin:
	(k, v) = line.rstrip().split('\t')
	db[k] = v

db.close()

# For Makefile (not used now)
#../conf/flat2tree.db: etc/flat2tree.map; etc/map2dbm.py $@ < $<
#../conf/tree2flat.db: etc/tree2flat.map; etc/map2dbm.py $@ < $<
