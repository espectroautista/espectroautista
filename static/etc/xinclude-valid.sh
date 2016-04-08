#!/bin/bash

for file in "$@"
do
	STR=$(xmllint --xinclude --nonet --loaddtd --nsclean "$file" |
		xmllint --valid --nonet --noout --loaddtd --nsclean)

	if [[ -n "$S" ]]
	then
		echo -n "$f: $STR"
	fi
done

# vim:sw=8:ts=8:ai:fileencoding=UTF-8
