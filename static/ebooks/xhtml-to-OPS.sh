#!/bin/sh

USAGE='Usage: xhtml-to-OPS.sh <input>'

SOURCE=${1?$USAGE}

xsltproc --nodtdattr --nonet "${0%.sh}.xsl" "$SOURCE"

exit
