#!/bin/sh
#
# Construye ebook HTML
#

########################################################################
#
########################################################################

[[ -d ebooks ]] || {
	echo "$0: internal error!"
	exit 1
}

TARGET=ebooks/HTML

[[ -d $TARGET ]]         || mkdir $TARGET
[[ -d $TARGET/styles ]]  || mkdir $TARGET/styles 
[[ -d $TARGET/scripts ]] || mkdir $TARGET/scripts 
[[ -e $TARGET/images ]]  || ln -s $PWD/images $TARGET/images 

########################################################################
# Symbolic links
########################################################################

rm -f $TARGET/styles/*.css

for f in styles/*.css
do
	x="${f#styles/}"
	[[ $x == 'content.css' ]] && continue
	ln -s "$PWD/$f" "$TARGET/styles/$x"
done

sed	-e 's|/images/external|../images/external.png|' \
	< styles/content.css > $TARGET/styles/content.css

rm -f $TARGET/scripts/*.js

for f in scripts/*.js
do
	x="${f#scripts/}"
	ln -s "$PWD/$f" "$TARGET/scripts/$x"
done

for f in favicon.ico feed.atom feed.rss
do
	[[ -e $TARGET/"$f" ]] || ln -s "$PWD/$f" "$TARGET/$f"
done

########################################################################
# Sed files
########################################################################

SED=$PWD/ebooks/images.sed
cd $TARGET/images
ls * | sed 's#^\(.\+\)\..*$#s|src="/images/\1"|src="images\/&"|g#'\
| sort > $SED
cd - >/dev/null

SED=$PWD/ebooks/tree2flat.sed
sed < etc/flat2tree-URL.map \
	-e 's/^\/\([^\t]\+\)\t\(.*\)$/s|href="\2\\\(#[^"]\\\+\\\)\\\?"|href="\1\\1"|g/'\
| sort > $SED 

########################################################################
# HTML files
########################################################################

MSG="Atención: página off-line creada en $(LANG=es_ES date --rfc-3339=seconds)"

for f in *.html
do
	[[ "$f" == 'error.html' ]] && continue

	sed < "$f" \
		-e "s|</body>|<p style='text-align: center'><b>$MSG</b></p></body>|" \
		-f ebooks/images.sed\
		-f ebooks/tree2flat.sed \
		-f ebooks/filter.sed \
	> "$TARGET/$f"
done

########################################################################

exit
