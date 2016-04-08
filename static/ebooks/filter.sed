s|href="/favicon.ico"|href="favicon.ico"|

s|href="/\(styles/[^"]\+\)"|href="\1.css"|g
s|src="/\(scripts/[^"]\+\)"|src="\1.js"|g

#s|href="/feed.atom"|href="http://EspectroAutista.Info/feed.atom"|
#s|href="/feed.rss"|href="http://EspectroAutista.Info/feed.rss"|
#s|href="\(/ficheros/[^"]\+\)"|href="http://EspectroAutista.Info\1"|g
s|href="/\(ficheros/[^"]\+\)"|href="\1"|g

s|href="/bibliograf%C3%ADa/autores/\([A-Z]\)"|href="bibautores_\1.html"|g
s|href="/bibliograf%C3%ADa/autores/\([A-Z]\)#\([^"]\+\)"|href="bibautores_\1.html#\2"|g
s|href="/bibliograf%C3%ADa/palabras-clave/\([A-Z]\)"|href="palabras_\1.html"|g
s|href="/bibliograf%C3%ADa/palabras-clave/\([A-Z]\)#\([^"]\+\)"|href="palabras_\1.html#\2"|g

s|href="/ayuda/etiquetas/\([A-Z]\)\(#[^"]\+\)\?"|href="etiquetas_\1.html\2"|g

s|href="/blog/\([0-9][0-9][0-9][0-9]\)"|href="F\1.html"|g
s|href="/blog/\([0-9][0-9][0-9][0-9]\)/\([0-9][0-9]\)\(#[^"]\+\)\?"|href="F\1-\2.html\3"|g

#s|rel="nofollow"||g

#s|rel="bookmark"||g
#s|<link rel="author"[^>]\+>||
#s|<link rel="Contents"[^>]\+>||
#s|<link rel="First"[^>]\+>||
#s|<link rel="Glossary"[^>]\+>||
#s|<link rel="Help"[^>]\+>||
#s|<link rel="Index"[^>]\+>||
#s|<link rel="Last"[^>]\+>||
#s|<link rel="Next"[^>]\+>||
#s|<link rel="Prev"[^>]\+>||
#s|<link rel="Search"[^>]\+>||
#s|<link rel="Section"[^>]\+>||g
#s|<link rel="Start"[^>]\+>||
#s|<link rel="Subsection"[^>]\+>||g
#s|<link rel="Up"[^>]\+>||
