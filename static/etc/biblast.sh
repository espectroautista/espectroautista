#!/bin/sh

NARTICLES=30

ls -lt ficheros/bibliografia/* |
	head -$NARTICLES |
	awk '{print $9}' |
	sed -e 's/^.*\///' -e 's/\.pdf$//' |
	awk '	BEGIN {print "<?xml version=\"1.0\"?>\n<ids>" }
		{print "<id>" $0 "</id>"}
		END {print "</ids>" } '

# vim:sw=8:ts=8:ai:nowrap
