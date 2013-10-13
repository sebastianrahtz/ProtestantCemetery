all:	web

web: cemall.xml
	teitohtml --profile=pc --profiledir=`pwd`/profiles cemall.xml index.html

csv: cemall.xml
	saxon cemall.xml pctocsv.xsl 

json: cemall.xml
	saxon -o:pc.json cemall.xml pctojson.xsl 

epub: cemall.xml
	teitoepub3 --coverimage=`pwd`/profiles/pc/epub3/cover.jpg --profiledir=`pwd`/profiles --profile=pc cemall.xml cem.epub

schema:
	teitorelaxng cem.odd teicem.rng

update:
	ant -lib /usr/share/saxon/saxon9he.jar -f job.xml

matches: cemall.xml
	saxon cemall.xml listtohtml.xsl > matches.html

cemall.xml: cem.xml
	xmllint --xinclude cem.xml | sed 's/"pictures\//"webpictures\//' > cemall.xml

dist:
	zip -r pc *.html *.css *.js DataTables-1.9.4 webpictures

clean:
	rm -f *.idx *.log *.fo *.fmt *.aux *.pdf *.out *.html *.dvi *.texxml
	rm -f cemall.xml pc.zip
