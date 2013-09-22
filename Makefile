all:	web

web: cemall.xml
	saxon -o:index.html cemall.xml teihtml-cem.xsl

schema:
	teitorelaxng cem.odd teicem.rng

cemall.xml: cem.xml
	xmllint --xinclude cem.xml > cemall.xml

dist:
	zip -r pc *.html *.css *.js DataTables-1.9.4

clean:
	rm -f *.idx *.log *.fo *.fmt *.aux *.pdf *.out *.html *.dvi *.texxml
	rm -f cemall.xml