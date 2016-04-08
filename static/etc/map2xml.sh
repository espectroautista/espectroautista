#!/bin/bash

echo "<?xml version='1.0' encoding='UTF-8'?>"
echo '<!DOCTYPE routes SYSTEM "../dtd/routes.dtd">'
echo "<routes>"

sed 's/^.//' | awk '{
	printf("<route flat='"'%s'"'>%s</route>\n",
		$1, $2)
	}'

echo '</routes>'

exit

# vim:sw=8:ts=8:ai:nowrap
