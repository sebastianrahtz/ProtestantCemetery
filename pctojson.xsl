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
      <geo xmlns="http://www.tei-c.org/ns/1.0">
        <!--http://ckan.it.ox.ac.uk/storage/f/2013-10-12T16%3A33%3A29.506Z/countries-geojson.csv-->
        <xsl:for-each select="tokenize(unparsed-text('countries-geojson.csv','utf-8'),  '&#10;')">
          <xsl:analyze-string select="." regex="([^,]+),([^,]+),([^,]+),(.*)">
            <xsl:matching-substring>
              <country xml:id="{regex-group(2)}">
                <!--
"Polygon","coordinates":[[31.5,-29.3],[31.3,-29.4],[30.9,-29.9],[30.6,-30.4],[30.1,-31.1],[28.9,-32.2],[28.2,-32.8],[27.5,-33.2],[26.4,-33.6],[25.9,-33.7],[25.8,-33.9],[25.2,-33.8],[24.7,-34],[23.6,-33.8],[23,-33.9],[22.6,-33.9],[21.5,-34.3],[20.7,-34.4],[20.1,-34.8],[19.6,-34.8],[19.2,-34.5],[18.9,-34.4],[18.4,-34],[18.4,-34.1],[18.2,-33.9],[18.3,-33.3],[17.9,-32.6],[18.2,-32.4],[18.2,-31.7],[17.6,-30.7],[17.1,-29.9],[17.1,-29.9],[16.3,-28.6],[16.8,-28.1],[17.2,-28.4],[17.4,-28.8],[17.8,-28.9],[18.5,-29],[19,-29],[19.9,-28.5],[19.9,-24.8],[20.2,-24.9],[20.8,-25.9],[20.7,-26.5],[20.9,-26.8],[21.6,-26.7],[22.1,-26.3],[22.6,-26],[22.8,-25.5],[23.3,-25.3]]
-->
                <xsl:analyze-string select="replace(regex-group(4),$outq,$inq)" regex="\[([0-9\-\.]+),([0-9\-\.]+)\]">
                  <xsl:matching-substring>
                    <pos x="{regex-group(1)}" y="{regex-group(2)}"/>
                  </xsl:matching-substring>
                </xsl:analyze-string>
              </country>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
              <xsl:message>bad <xsl:value-of select="."/>&gt;</xsl:message>
            </xsl:non-matching-substring>
          </xsl:analyze-string>
        </xsl:for-each>
      </geo>
    </xsl:variable>

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
          <xsl:sequence select="tei:json('forename',tei:String(persName/forename),true())"/>
          <xsl:sequence select="tei:json('surname',tei:String(persName/surname),true())"/>
          <xsl:sequence select="tei:json('occupation',tei:String(occupation),true())"/>
          <xsl:choose>
            <xsl:when test="not($geo/id($n))">
              <xsl:sequence select="tei:json('lat',0.0,false())"/>
              <xsl:sequence select="tei:json('long',0.0,false())"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:for-each select="$geo/id($n)">
		<xsl:variable name="maxx" select="max(.//pos/@x)"/>
		<xsl:variable name="minx" select="min(.//pos/@x)"/>
		<xsl:variable name="maxy" select="max(.//pos/@y)"/>
		<xsl:variable name="miny" select="min(.//pos/@y)"/>
		<xsl:sequence select="tei:json('lat',(number($maxy) + number($miny)) div 2,false())"/>
		<xsl:sequence select="tei:json('long',(number($maxx) + number($minx)) div 2,false())"/>
              </xsl:for-each>
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
	<xsl:sequence select="tei:fieldn(facsimile/surface/zone[1]/@ulx,'ulx')"/>
	<xsl:sequence select="tei:fieldn(facsimile/surface/zone[1]/@uly,'uly')"/>
	<xsl:sequence select="tei:fieldn(facsimile/surface/zone[1]/@lrx,'lrx')"/>
	<xsl:sequence select="tei:fieldn(facsimile/surface/zone[1]/@lry,'lry')"/>
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
		<xsl:for-each select="$geo/id($n)">
		  <xsl:variable name="maxx" select="max(.//pos/@x)"/>
		  <xsl:variable name="minx" select="min(.//pos/@x)"/>
		  <xsl:variable name="maxy" select="max(.//pos/@y)"/>
		  <xsl:variable name="miny" select="min(.//pos/@y)"/>
		  <xsl:value-of select="(number($maxx) + number($minx)) div 2"/>
		  <xsl:text>,</xsl:text>
		  <xsl:value-of select="(number($maxy) + number($miny)) div 2"/>
		</xsl:for-each>
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
