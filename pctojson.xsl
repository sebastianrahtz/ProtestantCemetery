<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  version="2.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="/usr/share/xml/tei/stylesheet/common/jsonlib.xsl"/>
  <xsl:output method="text" indent="yes"/>
  <xsl:variable name="top" select="/"/>
  <xsl:variable name="inq">"</xsl:variable>
  <xsl:variable name="outq">\\"</xsl:variable>
  <xsl:template match="/">
    <xsl:variable name="geo">      
      <xsl:for-each
	    select="doc('cow.xml')//row[position()&gt;1]">
	  <geo xmlns="http://www.tei-c.org/ns/1.0" xml:id="{@xml:id}"   lat="{cell[43]}"  long="{cell[44]}"/>
	</xsl:for-each>
    </xsl:variable>
    <xsl:result-document href="pics.json" method="text">
      <xsl:variable name="all" as="xs:string+">
	<xsl:for-each select="//graphic[ancestor::TEI//person][starts-with(@url,'webpictures')]">
	    <xsl:variable name="p"  as="xs:string+">
	      <xsl:sequence select="tei:json('file',substring-after(@url,'webpictures/'),true())"/>
	      <xsl:sequence select="tei:json('label',tei:jsonString(concat(ancestor::TEI//person[1]/persName/forename,'&#160;',ancestor::TEI//person[1]/persName/surname)),true())"/>
	      <xsl:sequence select="tei:json('value',tei:jsonString(concat(ancestor::TEI//person[1]/persName/forename,'&#160;',ancestor::TEI//person[1]/persName/surname)),true())"/>
	  </xsl:variable>
	  <xsl:value-of select="tei:jsonObject(($p))"/>
	</xsl:for-each>
      </xsl:variable>

      <xsl:value-of select="tei:jsonArray('',$all,false())"/>

    </xsl:result-document>

    <xsl:result-document href="personsummary.json" method="text">
      <xsl:variable name="all" as="xs:string+">
	<xsl:for-each-group select="//person[not(nationality/@key='ZZ')]" group-by="nationality/@key">
	    <xsl:variable name="p"  as="xs:string+">
              <xsl:variable name="n" select="nationality/@key"/>
	      <xsl:sequence select="tei:json('lat',$geo/id($n)/@lat,false())"/>
	      <xsl:sequence select="tei:json('lon',$geo/id($n)/@long,false())"/>
	      <xsl:sequence select="tei:json('value',count(current-group()),false())"/>
	  </xsl:variable>
	  <xsl:value-of select="tei:jsonObject(($p))"/>
	</xsl:for-each-group>
      </xsl:variable>

      <xsl:value-of select="tei:jsonObject((
			    tei:json('max',400,false()),
			    tei:jsonArray('data',$all,false())
			    ))"/>

    </xsl:result-document>
    <xsl:message>persons as JSON</xsl:message>
    <xsl:result-document href="person.json" method="text">
      <xsl:variable name="all" as="xs:string+">
	<xsl:for-each select="//person">
	  <xsl:variable name="p"  as="xs:string+">
          <xsl:variable name="s" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
          <xsl:variable name="n" select="nationality/@key"/>
          <xsl:variable name="id">
            <xsl:number level="any"/>
          </xsl:variable>
          <xsl:sequence select="tei:json('person',$id,false())"/>
          <xsl:sequence select="tei:json('age',if (age) then age else '0',false())"/>
          <xsl:sequence select="tei:json('sex',sex,false())"/>
          <xsl:sequence select="tei:json('birth',birth/@when,true())"/>
          <xsl:sequence select="tei:json('death',death/@when,true())"/>
          <xsl:sequence select="tei:json('nationality',$n,true())"/>
          <xsl:sequence select="tei:json('forename',tei:jsonString(persName/forename),true())"/>
          <xsl:sequence select="tei:json('surname',tei:jsonString(persName/surname),true())"/>
          <xsl:sequence select="tei:json('occupation',tei:jsonString(occupation),true())"/>
          <xsl:choose>
            <xsl:when test="not($geo/id($n))">
              <xsl:sequence select="tei:json('lat',0.0,false())"/>
              <xsl:sequence select="tei:json('long',0.0,false())"/>
            </xsl:when>
            <xsl:otherwise>
	      <xsl:sequence select="tei:json('lat',$geo/id($n)/@lat,false())"/>
	      <xsl:sequence select="tei:json('long',$geo/id($n)/@long,false())"/>
	      <xsl:message><xsl:value-of select="($geo/id($n)/@xml:id ,$geo/id($n)/@lat,$geo/id($n)/@long)"/></xsl:message>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:sequence select="tei:json('stone',$s,true())"/>
	  </xsl:variable>
	  <xsl:value-of select="tei:jsonObject(($p))"/>
	</xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="tei:jsonObject(tei:jsonArray('data',$all,false()))"/>

    </xsl:result-document>

    <xsl:result-document href="pc.json" method="text">
    <xsl:message>everything as JSON</xsl:message>
    <xsl:text>{ "stones" : [ </xsl:text>
      <xsl:for-each select="//TEI[not(@type='doc')]">
	<xsl:text>{</xsl:text>
        <xsl:sequence select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno,'ID')"/>
        <xsl:sequence select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='zone'],'zone')"/>
        <xsl:sequence select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='tomb'],'tomb')"/>
        <xsl:sequence select="tei:field(.//objectDesc/@form,'form')"/>
        <xsl:sequence select="tei:field(.//material,'material')"/>
	<xsl:if test="facsimile/surface/zone">
	  <xsl:sequence select="tei:fieldn(facsimile/surface/zone[1]/@ulx,'ulx')"/>
	  <xsl:sequence select="tei:fieldn(facsimile/surface/zone[1]/@uly,'uly')"/>
	  <xsl:sequence select="tei:fieldn(facsimile/surface/zone[1]/@lrx,'lrx')"/>
	  <xsl:sequence select="tei:fieldn(facsimile/surface/zone[1]/@lry,'lry')"/>
	</xsl:if>
	<xsl:sequence select="tei:field(.//condition,'condition')"/>
	<xsl:text>"persons" : [</xsl:text>
	<xsl:for-each select=".//person">
	  <xsl:text> { </xsl:text>
	  <xsl:variable name="s" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
	  <xsl:variable name="n" select="nationality/@key"/>
	  <xsl:variable name="id"><xsl:number level="any"/></xsl:variable>
	  <xsl:sequence select="tei:fieldn($id,'id')"/>
	  <xsl:sequence select="tei:field(age,'age')"/>
	  <xsl:sequence select="tei:fieldn(sex,'sex')"/>
	  <xsl:sequence select="tei:field(birth/@when,'birth')"/>
	  <xsl:variable name="birthplace">
            <xsl:choose>
              <xsl:when test="not($geo/id($n))">
		<xsl:text>0.0,0.0</xsl:text>
              </xsl:when>
              <xsl:otherwise>
		<xsl:value-of select="$geo/id($n)/@lat"/>
		<xsl:text>,</xsl:text>
		<xsl:value-of select="$geo/id($n)/@long"/>
              </xsl:otherwise>
            </xsl:choose>
	  </xsl:variable>
	  <xsl:sequence select="tei:fieldn(tokenize($birthplace,',')[1],'birthplacelat')"/>
	  <xsl:sequence select="tei:fieldn(tokenize($birthplace,',')[2],'birthplacelong')"/>
	  <xsl:sequence select="tei:field(death/@when,'death')"/>
	  <xsl:sequence select="tei:field($n,'nationality')"/>
	  <xsl:sequence select="tei:field(persName/forename,'forename')"/>
	  <xsl:sequence select="tei:finalfield(persName/surname,'surname')"/>
	  <xsl:text> } </xsl:text>
	  <xsl:if test="position()&lt;last()">
	    <xsl:text>,</xsl:text>
	  </xsl:if>
	</xsl:for-each>
	<xsl:text> ], </xsl:text>
	<xsl:text>"inscriptions" : [ </xsl:text>
	<xsl:for-each select=".//div[@type='inscription']">
	  <xsl:text> { </xsl:text>
	  <xsl:for-each select="tokenize(@decls,' ')">
	    <xsl:if test="starts-with(.,'#c')">
	      <xsl:text>"condition" : "</xsl:text>
	      <xsl:value-of select="substring(.,4)"/>
	      <xsl:text>",</xsl:text>
	    </xsl:if>
	    <xsl:if test="starts-with(.,'#m')">
	      <xsl:text>"method" : "</xsl:text>
	      <xsl:value-of select="substring(.,4)"/>
	      <xsl:text>",</xsl:text>
	    </xsl:if>
	  </xsl:for-each>
	  <xsl:text>"lines": [ </xsl:text>
	  <xsl:for-each select="ab">
	    <!--<xsl:text>{"l" :"</xsl:text>-->
	    <xsl:text>"</xsl:text>
	    <xsl:value-of select="replace(normalize-space(.),$inq,$outq)"/>
	    <xsl:text>"</xsl:text>
	    <xsl:if test="position()&lt;last()">
	      <xsl:text>,</xsl:text>
	    </xsl:if>
	  </xsl:for-each>
	  <xsl:text>]</xsl:text>
	  <xsl:text>}</xsl:text>
	  <xsl:if test="position()&lt;last()">
	    <xsl:text>,</xsl:text>
	  </xsl:if>
	</xsl:for-each>
	<xsl:text>]</xsl:text>
	<xsl:text>}</xsl:text>
	<xsl:if test="position()&lt;last()">
	  <xsl:text>,</xsl:text>
	</xsl:if>
	<xsl:text>&#10;</xsl:text>
      </xsl:for-each>
      <xsl:text>]}</xsl:text>
    </xsl:result-document>
  </xsl:template>

  <xsl:function name="tei:field">
    <xsl:param name="data"/>
    <xsl:param name="label"/>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="$label"/>
    <xsl:text>": "</xsl:text>
    <xsl:value-of select="replace(normalize-space($data),$inq,$outq)"/>
    <xsl:text>",</xsl:text>
  </xsl:function>


  <xsl:function name="tei:fieldn">
    <xsl:param name="data"/>
    <xsl:param name="label"/>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="$label"/>
    <xsl:text>": </xsl:text>
    <xsl:value-of select="replace(normalize-space($data),$inq,$outq)"/>
    <xsl:text>,</xsl:text>
  </xsl:function>

  <xsl:function name="tei:finalfield">
    <xsl:param name="data"/>
    <xsl:param name="label"/>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="$label"/>
    <xsl:text>": "</xsl:text>
    <xsl:value-of select="replace(normalize-space($data),$inq,$outq)"/>
    <xsl:text>"</xsl:text>
  </xsl:function>
</xsl:stylesheet>
