#!/bin/bash

ACCESS=0

if [[ $1 == [0123] ]]
then
	ACCESS=$1
	shift
fi

for file in "$@"
do
	tidy --char-encoding UTF8 -errors -quiet -access $ACCESS "$file" 2>&1 |
	grep -v 'Warning: nested q elements' |
		sed "s/^/$file: /"
done
		#grep -v 'escaping malformed URI reference' |

# vim:sw=8:ts=8:ai:nowrap
