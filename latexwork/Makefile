plan: cemall.xml
	xsltproc -o plan.texxml makeplan.xsl cem.xml
	pdflatex plan.texxml

zoneplans:
	xsltproc makeplan-byzone.xsl cem.xml
	X=`perl findbb.pl < zone_A.texxml `;\
	sed "s/CemBB{.*}/CemBB$$X/" < zone_A.texxml > x.tex;\
	/bin/mv x.tex zone_A.texxml
	X=`perl findbb.pl < zone_V.texxml `;\
	sed "s/CemBB{.*}/CemBB$$X/" < zone_V.texxml > x.tex;\
	/bin/mv x.tex zone_V.texxml
	X=`perl findbb.pl < zone_P.texxml `;\
	sed "s/CemBB{.*}/CemBB$$X/" < zone_P.texxml > x.tex;\
	/bin/mv x.tex zone_P.texxml
	X=`perl findbb.pl < zone_S.texxml `;\
	sed "s/CemBB{.*}/CemBB$$X/" < zone_S.texxml > x.tex;\
	/bin/mv x.tex zone_S.texxml
	X=`perl findbb.pl < zone_T.texxml `;\
	sed "s/CemBB{.*}/CemBB$$X/" < zone_T.texxml > x.tex;\
	/bin/mv x.tex zone_T.texxml
	pdflatex zone_A.texxml
	pdflatex zone_P.texxml
	pdflatex zone_T.texxml
	pdflatex zone_S.texxml
	pdflatex zone_V.texxml
