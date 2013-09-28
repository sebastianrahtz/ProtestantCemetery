all:	web

web: cemall.xml
	teitohtml --profile=pc --profiledir=`pwd`/profiles cemall.xml index.html

schema:
	teitorelaxng cem.odd teicem.rng

cemall.xml: cem.xml
	xmllint --xinclude cem.xml > cemall.xml

dist:
	zip -r pc *.html *.css *.js DataTables-1.9.4 webpictures

clean:
	rm -f *.idx *.log *.fo *.fmt *.aux *.pdf *.out *.html *.dvi *.texxml
	rm -f cemall.xml pc.zip
