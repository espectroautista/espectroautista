# Makefile - Configuración Apache de espectroautista.info

.SILENT:

RSYNC=rsync -e 'ssh -p 2022' --verbose --relative --update
HOST=joan@host

#
install:
	${RSYNC} *.conf *.db ${HOST}:espectroautista.info/conf
	${RSYNC} post-publish.sh ${HOST}:espectroautista.info
	echo 'IMPORTANT: execute post-publish.sh in target host'

#
reload:
	sudo systemctl reload httpd.service

# vim:syntax=make:ts=8:sw=8:ai:fileencoding=utf8
