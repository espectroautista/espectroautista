# Makefile for ExpectroAutista.Info
#

# WARNING
# Todo before the first make:
# 	$ ./config.sh

.SILENT:

SHELL=/bin/ksh

################################################################
# Parameters
################################################################

DOMAIN=http://EspectroAutista.Info

################################################################
# Command macros
################################################################

xp=xsltproc --nonet
M4=m4 -Istyles -Ietc etc/css.m4
#XIncludeValid=etc/xinclude-valid.sh
HTMLValid=etc/tidyup.sh
XMLWellFormed=xmllint --noent --nonet --noout --loaddtd
XMLValid=$(XMLWellFormed) --valid
SchemaValid=xmllint --noout --schema
RelaxNGValid=xmllint --noout --relaxng
httxt2dbm=/usr/bin/httxt2dbm 

minifyCSS=etc/minifyCSS

################################################################
# Filename macros
################################################################

# define macros
include etc/common.mak
include etc/es-pages.mak

# sources
JS=$(foreach P,$(TESTS),scripts/$(P).js)\
  scripts/C.js\
  scripts/library.js\
  scripts/query.js\
  scripts/related.js\
  scripts/test.js\

XSL=$(STYLESHEETS)\
  ebooks/ncx.xsl\
  ebooks/only-content.xsl\
  ebooks/spine.xsl\
  ebooks/xhtml1-to-xhtml11.xsl\
  ebooks/xhtml-to-OPS.xsl\
  xsl/lib/adsense.xsl\
  xsl/lib/analytics.xsl\
  xsl/lib/biblio.xsl\
  xsl/lib/choice.xsl\
  xsl/lib/html.xsl\
  xsl/lib/likert.xsl\
  xsl/lib/node.xsl\
  xsl/lib/ie6nomore.xsl\
  xsl/lib/ie7nomore.xsl\
  xsl/lib/object.xsl\
  xsl/lib/tables.xsl\
  xsl/lib/test.xsl\
  xsl/lib/xlib.xsl\
  xsl/lib/cloud.xsl\
  xsl/outline.xsl\
  xsl/make.xsl\
  xsl/pages.xsl\
  xsl/publish.xsl\
  xsl/tags.xsl\
  xsl/sorttags.xsl\
  xsl/common.xsl\
  xsl/flat2tree.xsl\

M4_LIB=\
  etc/clearfix.css\
  etc/COLORS.m4\
  etc/reset.css\
  styles/theme.m4\

M4_SCREEN=\
  styles/screen-canvas.m4\
  styles/screen-container.m4\
  styles/screen-header.m4\
  styles/screen-body.m4\
  styles/screen-menu.m4\
  styles/screen-footer.m4\

M4_CONTENT=styles/content.m4

M4_PRINT=\
	styles/print-page.m4

CSSLIB=etc/reset.css etc/clearfix.css

main_styles=screen print content\
	    pub glosario blog choice likert mapa palabras epub
M4_STYLES=$(foreach P,$(main_styles),styles/$(P).m4)\
	  $(M4_LIB) $(M4_SCREEN) $(M4_CONTENT) $(M4_PRINT) styles/test.m4
CSS_STYLES=$(foreach P,$(main_styles),styles/$(P).css)

UTIL=\
  etc/bib2xml.c\
  etc/jsmin.c\
  etc/standalone.c\
  etc/A-Z.py\
  etc/dbshow.py\
  etc/map2dbm.py\
  etc/map2xml.py\
  etc/postp.py\
  etc/sitemap.py\
  etc/url2utf.py\
  etc/biblast.sh\
  etc/tidyup.sh\
  etc/tree2flat.sh\
  etc/unaccent.sh\
  ebooks/epub.sh\
  ebooks/html.sh\
  ebooks/github.sh\
  ebooks/pack.sh\
  ebooks/xhtml1-to-xhtml11.sh\
  ebooks/xhtml-to-OPS.sh\
  ebooks/filter.sed\
  etc/minifyCSS\
  etc/minifyHTML\
  etc/css.m4\
  Makefile\

ES=es/*.html es/data/*.xml

DATA=robots.txt etc/outline.opml etc/biblio.bib etc/legacy.txt\
     styles/atom.css styles/object.css\
     ../conf/host.conf ../conf/routes.conf ../conf/directories.conf

SOURCES=$(JS) $(XSL) $(M4_STYLES) $(UTIL) $(ES) $(DATA)

# targets
TARGETS=etc/flat2tree.map ../conf/flat2tree.db\
	etc/tree2flat.map ../conf/tree2flat.db\
	etc/biblast.xml etc/routes.xml $(PAGES_es)
BINARY=etc/standalone etc/bib2xml etc/jsmin

################################################################
# Rules
################################################################

all: $(CSS_STYLES) $(TARGETS) sitemap.xml.gz feed.rss
	#etc/minifyHTML
	#@echo Goal!

etc/bib2xml: etc/bib2xml.c
	cc -o $@ $<
	@strip $@

etc/jsmin: etc/jsmin.c
	cc -o $@ $<
	@strip $@

etc/standalone: etc/standalone.c
	cc -o $@ $<
	@strip $@

etc/biblio.xml: etc/bib2xml etc/biblio.bib
	LANG=C etc/bib2xml < etc/biblio.bib > $@
	$(xp) xsl/nopaper.xsl etc/biblio.xml > etc/nopaper.txt

# rules for each target
include etc/es-rules.mak

binary: etc/standalone etc/bib2xml
	@echo Binary built!

feed.rss: feed.atom
	$(xp) xsl/atom2rss.xsl feed.atom > feed.rss

################################################################
# CSS
################################################################

styles/screen.css:	$(M4_LIB) $(M4_SCREEN)
styles/content.css:	$(M4_LIB) $(M4_CONTENT)
styles/print.css:	$(M4_LIB) $(M4_PRINT)
styles/screen.css:	styles/screen.m4;	$(M4) $< | $(minifyCSS) > $@
styles/print.css:	styles/print.m4;	$(M4) $< | $(minifyCSS) > $@
styles/content.css:	styles/content.m4;	$(M4) $< | $(minifyCSS) > $@

styles/choice.css:	styles/test.m4
styles/likert.css:	styles/test.m4
styles/choice.css:	styles/choice.m4;	$(M4) $< | $(minifyCSS) > $@
styles/likert.css:	styles/likert.m4;	$(M4) $< | $(minifyCSS) > $@

styles/pub.css:		styles/pub.m4;		$(M4) $< | $(minifyCSS) > $@
styles/palabras.css:	styles/palabras.m4;	$(M4) $< | $(minifyCSS) > $@
styles/mapa.css:	styles/mapa.m4;		$(M4) $< | $(minifyCSS) > $@
styles/glosario.css:	styles/glosario.m4;	$(M4) $< | $(minifyCSS) > $@
styles/blog.css:	styles/blog.m4;		$(M4) $< | $(minifyCSS) > $@

styles/epub.css:	styles/content.m4
styles/epub.css:	styles/epub.m4;		$(M4) $< | $(minifyCSS) > $@

CSS_STYLES: $(M4_LIB)  $(CSSLIB)

################################################################
# Outline derivatives
################################################################

META=es/meta/outline.opml\
     etc/common.mak\
     etc/es-rules.mak\
     etc/es-pages.mak\
     es/meta/tags.xml\

lang_es=--stringparam sLang es

config: etc/biblio.xml
	etc/A-Z.py es etiquetas
	etc/A-Z.py es bibautores
	etc/A-Z.py es palabras
	#
	[ -L ficheros ] || ln -s ../ficheros .
	[ -e ficheros/bibliografía ] || (cd ficheros; ln -s bibliografia bibliografía)
	#
	[ -d es/meta ] || mkdir es/meta
	$(xp) $(lang_es) xsl/outline.xsl etc/outline.opml > es/meta/outline.opml
	$(xp) $(lang_es) xsl/tags.xsl es/meta/outline.opml \
		| $(xp) xsl/sorttags.xsl - > es/meta/tags.xml
	#
	$(xp) xsl/common.xsl es/meta/outline.opml > etc/common.mak
	$(xp) $(lang_es) xsl/make.xsl es/meta/outline.opml > etc/es-rules.mak
	$(xp) $(lang_es) xsl/pages.xsl es/meta/outline.opml > etc/es-pages.mak

etc/flat2tree-URL.map: etc/outline.opml
	$(xp) $(lang_es) xsl/flat2tree.xsl $< | grep -v '_[A-Z]\.' | sort > $@
etc/flat2tree-URL.map: xsl/flat2tree.xsl

sitemap.xml: $(PAGES_es) etc/flat2tree-URL.map
	etc/sitemap.py $(DOMAIN) > $@
sitemap.xml.gz: sitemap.xml
	gzip $< -c > $@

etc/flat2tree.map: etc/flat2tree-URL.map
	cat etc/legacy.txt $< | etc/url2utf.py | sort > $@

etc/tree2flat.map: etc/flat2tree-URL.map
	etc/tree2flat.sh < $< > $@

etc/routes.xml: etc/flat2tree-URL.map
	etc/map2xml.py < $< > $@

../conf/flat2tree.db: etc/flat2tree.map
	$(httxt2dbm) -o $@ -i $< -f DB
	chmod 644 $@

../conf/tree2flat.db: etc/tree2flat.map
	$(httxt2dbm) -o $@ -i $< -f DB
	chmod 644 $@

etc/biblast.xml: etc/biblast.sh
	etc/biblast.sh > $@

################################################################
# Utilities
################################################################

cache-size:
	echo -en 'Text files (in bytes):\t'
	cat scripts/*.js styles/*.css | wc -c
	du -h images

# valid input
vinput:
	-$(XMLValid) etc/outline.opml
	-$(XMLWellFormed) es/data/*.xml 
	-$(XMLValid) es/*.html

# valid output
voutput: all
	[[ -e 'about:legacy-compat' ]] || ln -s dtd/XHTML5.dtd 'about:legacy-compat'
	-$(XMLWellFormed) feed.atom
	-$(XMLValid) etc/biblio.xml es/meta/outline.opml 
	-$(SchemaValid) dtd/sitemap.xsd sitemap.xml
	-$(XMLValid) *.html
	#-$(HTMLValid) *.html

valid: vinput voutput

# notify search engines
SITEMAP=$(DOMAIN)/sitemap.xml.gz
ping=wget -O /dev/null -o /dev/null 
ping:
	-$(ping) http://www.google.com/webmasters/tools/ping?sitemap=$(SITEMAP)
	-$(ping) http://submissions.ask.com/ping?sitemap=$(SITEMAP)
	-$(ping) http://webmaster.live.com/ping.aspx?siteMap=$(SITEMAP)
	-$(ping) http://www.bing.com/webmaster/ping.aspx?siteMap=$(SITEMAP)
	-$(ping) http://search.yahooapis.com/SiteExplorerService/V1/ping?sitemap=$(SITEMAP)

# publish
RSYNC=rsync -e 'ssh -p 2022' --verbose --relative --update
HOST=joan@host

install-files:
	chmod 644 ficheros/*.pdf \
		ficheros/bibliografia/*.pdf ficheros/publicaciones/*.pdf ficheros/cartas/*.pdf
	$(RSYNC)\
		ficheros/publicaciones/* ficheros/bibliografia/*\
		ficheros/*.pdf ficheros/cartas/*\
		ficheros/*.svg ficheros/*.odg\
	    $(HOST):espectroautista.info/static

install:
	$(RSYNC) --links\
		*.html feed.* favicon.ico\
		images/* scripts/*.js styles/*.css\
		sitemap.xml* robots.txt\
		ficheros/bibliografía\
	    $(HOST):espectroautista.info/static

install-config:
	cd ../conf; make install

#install-wsgi:
	#cd ../wsgi; make install

# zip & EPUB versions
#?books: all
#?	ebooks/html.sh
#?	ebooks/epub.sh
#?	ebooks/pack.sh

github: all
	ebooks/github.sh

backup:
	git push origin master
	git push backup master
#
build: clean all

clean:
	@rm -f $(TARGETS) $(CSS_STYLES) feed.* F2*.html

clobber: clean
	rm -f $(BINARY) etc/biblio.xml $(META) es/*_[A-Z].html sitemap.*
	rm -f etc/flat2tree-URL.map etc/nopaper.txt
	rm -f ebooks/leeme.txt
	for f in $(META); do > "$$f"; done
	echo Warning: Needed a \'make config\'

# vim:syntax=make:ts=8:sw=8:ai:fileencoding=utf8:nowrap
