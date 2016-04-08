#!/bin/sh
#
# Construye HTML estàtico
#

BASE=$PWD

########################################################################
#
########################################################################

[[ -d ebooks ]] || {
	echo "$0: internal error!"
	exit 1
}

TARGET=~/espectroautista.github.io

[[ -d $TARGET ]]         || mkdir $TARGET
[[ -d $TARGET/styles ]]  || mkdir $TARGET/styles 
[[ -d $TARGET/scripts ]] || mkdir $TARGET/scripts 
[[ -e $TARGET/images ]]  || mkdir $TARGET/images
[[ -e $TARGET/ficheros ]] || mkdir $TARGET/ficheros
[[ -e $TARGET/ficheros/publicaciones ]] || mkdir $TARGET/ficheros/publicaciones
[[ -e $TARGET/ficheros/bibliografía ]] || mkdir $TARGET/ficheros/bibliografía
[[ -e $TARGET/ficheros/cartas ]] || mkdir $TARGET/ficheros/cartas

cp -u $PWD/images/*.* $TARGET/images 
cp -u $PWD/ficheros/*.* $TARGET/ficheros
cp -u $PWD/ficheros/publicaciones/*.* $TARGET/ficheros/publicaciones
cp -u $PWD/ficheros/bibliografía/*.* $TARGET/ficheros/bibliografía
cp -u $PWD/ficheros/cartas/*.* $TARGET/ficheros/cartas
cp -u $PWD/styles/*.css $TARGET/styles
cp -u $PWD/scripts/*.js $TARGET/scripts

sed	-e 's|/images/external|../images/external.png|' \
	< styles/content.css > $TARGET/styles/content.css

cp -u favicon.ico feed.atom feed.rss $TARGET

########################################################################
# Sed files
########################################################################

SED_OUTPUT=$PWD/ebooks/images.sed
cd $TARGET/images
ls * | sed 's#^\(.\+\)\..*$#s|src="/images/\1"|src="images\/&"|g#'\
| sort > $SED_OUTPUT
cd $BASE

SED_OUTPUT=$PWD/ebooks/tree2flat.sed
sed < etc/flat2tree-URL.map \
	-e 's/^\/\([^\t]\+\)\t\(.*\)$/s|href="\2\\\(#[^"]\\\+\\\)\\\?"|href="\1\\1"|g/'\
| sort > $SED_OUTPUT 

########################################################################
# HTML files
########################################################################

for f in *.html
do
	[[ "$f" == 'error.html' ]] && continue

	sed < "$f" \
		-f ebooks/images.sed\
		-f ebooks/tree2flat.sed \
		-f ebooks/filter.sed \
	> "$TARGET/$f"
done

cp README-site.md $TARGET/README.md

cd $TARGET/scripts
for file in "$@"
do
	$BASE/etc/jsmin < "$file" | sed '/^$/d' > TMP$$
	mv TMP$$ "$file"
done

cd $TARGET
mv error404.html 404.html

########################################################################

exit
