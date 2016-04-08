#!/bin/sh
#
# Construye ebook EPUB
#

########################################################################
#
########################################################################

[[ -d ebooks ]] || {
	echo "$0: internal error!"
	exit 1
}

TARGET=ebooks/EPUB

[[ -d $TARGET ]]            || mkdir $TARGET
[[ -d $TARGET/OPS ]]        || mkdir $TARGET/OPS
[[ -d $TARGET/OPS/styles ]] || mkdir $TARGET/OPS/styles
[[ -e $TARGET/OPS/images ]] || ln -s $PWD/images $TARGET/OPS/images 

########################################################################
# CSS
########################################################################

rm -f $TARGET/OPS/styles/*.css

rm -f styles/epub.css
make styles/epub.css

sed	-e 's|/images/external|../images/external.png|' \
	-e '/^span.External{display:none;}$/d' \
	< styles/epub.css > $TARGET/OPS/styles/content.css

sed	-e '/^li.QuestionOption{text-indent:-1.7em;}$/d' \
	-e '/^ol.Choices{list-style-type:none;}$/d' \
	< styles/choice.css > $TARGET/OPS/styles/choice.css

for f in blog glosario likert mapa palabras pub
do
	ln -s "$PWD/styles/$f.css" "$TARGET/OPS/styles/$f.css"
done

########################################################################
# HTML files
########################################################################

rm -f $TARGET/OPS/*.xhtml $TARGET/OPS/*.html

for f in ebooks/HTML/*.html
do
	x=${f##*/}
	xsltproc --nodtdattr --nonet ebooks/only-content.xsl "$f" > "$TARGET/OPS/$x"
done

########################################################################
# OPF
########################################################################

OPF=$TARGET/packaging.opf

cat <<OPF > $OPF
<?xml version="1.0"?>
<package xmlns="http://www.idpf.org/2007/opf" unique-identifier="EspectroAutista.Info" version="2.0">
	<metadata xmlns:dc="http://purl.org/dc/elements/1.1/"
			xmlns:dcterms="http://purl.org/dc/terms/"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xmlns:opf="http://www.idpf.org/2007/opf">
		<dc:title>EspectroAutista.Info</dc:title>
		<dc:language xsi:type="dcterms:RFC3066">es</dc:language>
		<dc:identifier id="EspectroAutista.Info" opf:scheme="URI">http://EspectroAutista.Info</dc:identifier>
		<dc:subject>Trastornos del espectro autista</dc:subject>
		<dc:description>EspectroAutista.Info tiene por misión ayudar a la difusión y conocimiento de los trastornos del espectro autista, con especial hincapié en sus formas más funcionales, las menos severas pero también las más desconocidas y necesitadas de divulgación.</dc:description>
		<dc:creator>Kleine Professoren</dc:creator>
		<dc:date xsi:type="dcterms:W3CDTF">$(date -I)</dc:date>
	</metadata>
	<manifest>
		<item id="navigation.ncx" href="navigation.ncx" media-type="application/x-dtbncx+xml"/>
OPF

for f in $TARGET/OPS/images/*.gif
do
	echo "		<item id='${f##*/}' href='${f#ebooks/EPUB/}' media-type='image/gif'/>"
done >> $OPF
for f in $TARGET/OPS/images/*.png
do
	echo "		<item id='${f##*/}' href='${f#ebooks/EPUB/}' media-type='image/png'/>"
done >> $OPF
for f in $TARGET/OPS/images/*.jpg
do
	echo "		<item id='${f##*/}' href='${f#ebooks/EPUB/}' media-type='image/jpeg'/>"
done >> $OPF

for f in $TARGET/OPS/*.html
do
	echo "		<item id='${f##*/}' href='${f#ebooks/EPUB/}' media-type='application/xhtml+xml'/>"
done >> $OPF


cat <<OPF >> $OPF
	</manifest>
		<spine toc="navigation.ncx">
OPF

xsltproc ebooks/spine.xsl es/meta/outline.opml >> $OPF

for f in $TARGET/OPS/F2???.html
do
	echo "		<itemref idref='${f##*/}' linear='yes'/>"
	for f in ${f%.html}-??.html
	do
		echo "		<itemref idref='${f##*/}' linear='no'/>"
	done >> $OPF
done >> $OPF

cat <<OPF >> $OPF
	</spine>
	<guide>
		<reference type="text" title="Inicio" href="OPS/index.html"/>
		<reference type="index" title="Índice" href="OPS/etiquetas.html"/>
		<reference type="toc" title="Tabla de contenidos" href="OPS/mapa.html"/>
		<reference type="glossary" title="Glosario" href="OPS/glosario.html"/>
	</guide>
</package>
OPF

xmllint --noout --relaxng dtd/opf.xsd ebooks/EPUB/packaging.opf 

########################################################################
# NCX
########################################################################

NCX=$TARGET/navigation.ncx

xsltproc --xinclude ebooks/ncx.xsl es/meta/outline.opml > $NCX

xmllint --noout --dtdvalid dtd/ncx-2005-1.dtd ebooks/EPUB/navigation.ncx 

########################################################################

exit
