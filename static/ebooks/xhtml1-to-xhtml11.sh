#!/bin/sh

USAGE='Usage: xhtml1-to-xhtml11.sh <input>'

SOURCE=${1?$USAGE}

xsltproc --nodtdattr --nonet "${0%.sh}.xsl" "$SOURCE"

exit
