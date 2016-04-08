#!/usr/bin/python

import re, sys
import os, stat, time
from glob import glob

write = sys.stdout.write

header = """<?xml version='1.0' encoding='UTF-8'?>
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
			    http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"
	xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
"""

footer = """</urlset>
"""

def date(filename):
	return time.strftime(
				'%Y-%m-%dT%H:%M:%S+00:00', 
				time.gmtime(os.stat(filename)[stat.ST_MTIME]))

def warn(msg):
	sys.stderr.write(msg + '\n')

def index(fn):
	return (fn != 'etiquetas.html' and
			fn != 'error.html' and
			fn != 'mapa.html' and
			not fn.startswith('google') and
			re.search('_[A-Z]\.html', fn) is None)

flat2tree = {}
pair = re.compile('^/(.+?)\t(.+?)$')

def initMap():
	global flat2tree 

	file = open('etc/flat2tree-URL.map', 'r')

	for line in file:
		(flat, tree) = pair.match(line).groups()
		flat2tree[flat] = tree

	file.close()

assert len(sys.argv) == 2, 'Domain name expected'
Domain	= sys.argv[1]

initMap()

write(header)

blogYM = re.compile('^F(\d\d\d\d)-(\d\d)\.html$')
blogY  = re.compile('^F(\d\d\d\d)\.html$')

for filename in glob('*.html'):
	if index(filename):
		write('\t<url>\n')

		mo = blogYM.match(filename)
		if mo is not None:
			write('\t\t<loc>' + Domain + '/blog/' + mo.group(1) + '/' + mo.group(2) + '</loc>\n')
		else:
			mo = blogY.match(filename)
			if mo is not None:
				write('\t\t<loc>' + Domain + '/blog/' + mo.group() + '</loc>\n')
			else:
				tree = flat2tree.get(filename)

				if tree is None:
					warn('Unexpected filename: ' + filename)
					tree = ''

				write('\t\t<loc>' + Domain + tree + '</loc>\n')

		write('\t\t<lastmod>' + date(filename) + '</lastmod>\n')
		#write('\t\t<priority>0.6</priority>\n')
		write('\t</url>\n')

write(footer)

# vim:ts=4:sw=4:ai
