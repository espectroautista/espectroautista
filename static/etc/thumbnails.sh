
for f in *.pdf; do convert -thumbnail 128x180 "$f[0]" thumbnails/"${f%.pdf}".jpg; done

