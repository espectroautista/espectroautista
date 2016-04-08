#!/bin/sh

export LANG=en_US.UTF-8

FILE1=/tmp/flat2tree.$$.1
FILE2=/tmp/flat2tree.$$.2

awk -F '\t' '{ printf("%s\t%s\n", $2, $1) }' | etc/url2utf.py > $FILE1

etc/unaccent.sh < $FILE1 > $FILE2

cat $FILE1 $FILE2 | sort -u

rm $FILE1 $FILE2

exit

# vim:sw=8:ts=8:ai:fileencoding=utf8
