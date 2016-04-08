#!/bin/bash

for doc in $@
do
	R=$(xmllint --xinclude --loaddtd $doc |
		xmllint --noout --valid --nonet --nsclean - 2>&1)
	if (( $? != 0 )); then
		echo "$doc:${R#-:}"
	fi

done

# vim:sw=8:ts=8:ai:nowrap
