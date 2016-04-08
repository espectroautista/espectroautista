#!/bin/sh
#
# Empaqueta EspectroAutista.Info.zip y otras variantes
#

########################################################################
#
########################################################################

[[ -d ebooks ]] || {
	echo "$0: internal error!"
	exit 1
}

########################################################################
# Nota "leeme"
########################################################################

cat <<EOF >ebooks/leeme.txt
Este fichero contiene la version off-line de la sede web

	http://EspectroAutista.Info

El fichero se creo en fecha $(LANG=es_ES date --rfc-3339=seconds).

Para iniciar su visita en la pagina principal de la sede web abra en su
navegador el fichero index.html.

(acentos y otros caracteres fuera del rango ASCII eliminados deliberadamente)
EOF

########################################################################
# Pack EPUB
########################################################################

EPUB=ficheros/EspectroAutista.Info.epub

rm -f $EPUB

cd ebooks/EPUB

zip -qrDX9 ../../$EPUB mimetype META-INF *.opf *.ncx OPS

cd - >/dev/null


########################################################################
# Pack HTML
########################################################################

ZIP=ficheros/EspectroAutista.Info.zip
TGZ=ficheros/EspectroAutista.Info.tar.gz
BZ2=ficheros/EspectroAutista.Info.tar.bz2

rm -f $ZIP $TGZ $BZ2

cd ebooks

mv HTML EspectroAutista.Info

zip -qrXD9 ../$ZIP leeme.txt EspectroAutista.Info
tar -h -c -z -f ../$TGZ leeme.txt EspectroAutista.Info
tar -h -c -j -f ../$BZ2 leeme.txt EspectroAutista.Info

mv EspectroAutista.Info HTML 

cd - >/dev/null

########################################################################


exit
