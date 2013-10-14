<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="2.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"/>
      <xsl:variable name="top" select="/"/>
  <xsl:variable name="inq">"</xsl:variable>
  <xsl:variable name="outq">""</xsl:variable>

  <xsl:template match="/">
    <xsl:call-template name="makeCSV"/>
  </xsl:template>

  <xsl:template name="makeCSV">
    <xsl:variable name="geo">
    <geo xmlns="http://www.tei-c.org/ns/1.0">
<!--http://ckan.it.ox.ac.uk/storage/f/2013-10-12T16%3A33%3A29.506Z/countries-geojson.csv-->
      <xsl:for-each
	  select="tokenize(unparsed-text('countries-geojson.csv','utf-8'),  '&#xa;')">
      <xsl:analyze-string select="." regex="([^,]+),([^,]+),([^,]+),(.*)">
	<xsl:matching-substring>
	  <country xml:id="{regex-group(2)}">
<!--
"Polygon","coordinates":[[31.5,-29.3],[31.3,-29.4],[30.9,-29.9],[30.6,-30.4],[30.1,-31.1],[28.9,-32.2],[28.2,-32.8],[27.5,-33.2],[26.4,-33.6],[25.9,-33.7],[25.8,-33.9],[25.2,-33.8],[24.7,-34],[23.6,-33.8],[23,-33.9],[22.6,-33.9],[21.5,-34.3],[20.7,-34.4],[20.1,-34.8],[19.6,-34.8],[19.2,-34.5],[18.9,-34.4],[18.4,-34],[18.4,-34.1],[18.2,-33.9],[18.3,-33.3],[17.9,-32.6],[18.2,-32.4],[18.2,-31.7],[17.6,-30.7],[17.1,-29.9],[17.1,-29.9],[16.3,-28.6],[16.8,-28.1],[17.2,-28.4],[17.4,-28.8],[17.8,-28.9],[18.5,-29],[19,-29],[19.9,-28.5],[19.9,-24.8],[20.2,-24.9],[20.8,-25.9],[20.7,-26.5],[20.9,-26.8],[21.6,-26.7],[22.1,-26.3],[22.6,-26],[22.8,-25.5],[23.3,-25.3]]
-->
	    <xsl:analyze-string
		select="replace(regex-group(4),$outq,$inq)"
			regex="\[([0-9\-\.]+),([0-9\-\.]+)\]">
	      <xsl:matching-substring>
	      <pos x="{regex-group(1)}" y="{regex-group(2)}"/>
	      </xsl:matching-substring>
	    </xsl:analyze-string>
	  </country>
	</xsl:matching-substring>
	<xsl:non-matching-substring>
	  <xsl:message>bad <xsl:value-of select="."/>></xsl:message>
	</xsl:non-matching-substring>
      </xsl:analyze-string>
      </xsl:for-each>
    </geo>
    </xsl:variable>
    <xsl:message>persons</xsl:message>
    <xsl:result-document href="person.csv" method="text">
      <xsl:text>"person","age","sex","birth","death","nationality","forename","surname","occupation","longitude","latitude","stone"&#10;</xsl:text>
      <xsl:for-each select="//person">
        <xsl:variable name="s" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
        <xsl:variable name="n" select="nationality/@key"/>
	<xsl:variable name="id"><xsl:number level="any"/></xsl:variable>
	<xsl:sequence select="tei:field($id,false())"/>
	<xsl:sequence select="tei:field(age,false())"/>
	<xsl:sequence select="tei:field(sex,false())"/>
	<xsl:sequence select="tei:field(birth/@when,true())"/>
	<xsl:sequence select="tei:field(death/@when,true())"/>
	<xsl:sequence select="tei:field($n,true())"/>
	<xsl:sequence select="tei:field(persName/forename,true())"/>
	<xsl:sequence select="tei:field(persName/surname,true())"/>
	<xsl:sequence select="tei:field(occupation,true())"/>
	<xsl:choose>
	  <xsl:when test="not($geo/id($n))">
	    <xsl:text>"0.0","0.0",</xsl:text>
	    <xsl:message> cant find <xsl:value-of select="$n"/></xsl:message>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:for-each select="$geo/id($n)">
	      <xsl:variable name="maxx" select="max(.//pos/@x)"/>
	      <xsl:variable name="minx" select="min(.//pos/@x)"/>
	      <xsl:variable name="maxy" select="max(.//pos/@y)"/>
	      <xsl:variable name="miny" select="min(.//pos/@y)"/>
	      <xsl:text>"</xsl:text>
	      <xsl:value-of select="(number($maxx) + number($minx)) div 2"/>
	      <xsl:text>","</xsl:text>
	      <xsl:value-of select="(number($maxy) + number($miny)) div 2"/>
	      <xsl:text>","</xsl:text>
	    </xsl:for-each>
	  </xsl:otherwise>
	</xsl:choose>
	<xsl:value-of select="$s"/>
	<xsl:text>"&#10;</xsl:text>
      </xsl:for-each>
    </xsl:result-document>
    <xsl:message>stones</xsl:message>
    <xsl:result-document href="stones.csv" method="text">
      <xsl:text>"stone","zone","tomb","form","material","ulx","uly","lrx","lry","condition"&#10;</xsl:text>
      <xsl:for-each select="//TEI[not(@type='doc')]">
        <xsl:sequence select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno,true())"/>
        <xsl:sequence select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='zone'],true())"/>
        <xsl:sequence select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='tomb'],false())"/>
        <xsl:sequence select="tei:field(.//objectDesc/@form,true())"/>
        <xsl:sequence select="tei:field(.//material,true())"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@ulx,false())"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@uly,false())"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@lrx,false())"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@lry,false())"/>
	<xsl:text>"</xsl:text>
	<xsl:value-of select=".//condition"/>
	<xsl:text>"&#10;</xsl:text>
      </xsl:for-each>
    </xsl:result-document>
    <xsl:message>inscrips</xsl:message>
    <xsl:result-document href="inscrips.csv" method="text">
      <xsl:text>"inscrip","condition","method","stone"&#10;</xsl:text>
      <xsl:for-each select="//div[@type='inscription']">
	<xsl:number level="any"/>
	<xsl:text>,</xsl:text>
	<xsl:for-each select="tokenize(@decls,' ')">
	  <xsl:if test="starts-with(.,'#c')">
	    <xsl:value-of select="substring(.,4)"/>
	    <xsl:text>,</xsl:text>
	  </xsl:if>
	  <xsl:if test="starts-with(.,'#m')">
	    <xsl:text>"</xsl:text>
	    <xsl:value-of select="substring(.,4)"/>
	    <xsl:text>",</xsl:text>
	  </xsl:if>
	</xsl:for-each>
	<xsl:text>"</xsl:text>
	<xsl:value-of
	    select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>

	<xsl:text>"&#10;</xsl:text>
      </xsl:for-each>
    </xsl:result-document>
    <xsl:message>lines</xsl:message>
    <xsl:result-document href="lines.csv" method="text">
      <xsl:text>"inscrip","line","text"&#10;</xsl:text>
      <xsl:for-each select="//div[@type='inscription']/ab">
	<xsl:for-each select="parent::div">
	  <xsl:number level="any"/>
	</xsl:for-each>
	<xsl:text>,</xsl:text>
	<xsl:number/>
	<xsl:text>,"</xsl:text>
	<xsl:value-of select="replace(normalize-space(.),$inq,$outq)"/>
	<xsl:text>"&#10;</xsl:text>
      </xsl:for-each>
    </xsl:result-document>
  </xsl:template>

  <xsl:function name="tei:field">
    <xsl:param name="data"/>
    <xsl:param name="text"/>
    <xsl:if test="$text">"</xsl:if>
    <xsl:value-of select="replace(normalize-space($data),$inq,$outq)"/>
    <xsl:if test="$text">"</xsl:if>
    <xsl:text>,</xsl:text>
  </xsl:function>

   <xsl:function name="tei:splitCSV" as="xs:string+">
     <xsl:param name="str" as="xs:string"/>
     <xsl:analyze-string select="concat($str, ',')"
			 regex="((&quot;[^&quot;]*&quot;)+|[^,]*),">
       <xsl:matching-substring>
	 <xsl:sequence
	     select="replace(regex-group(1), &quot;^&quot;&quot;|&quot;&quot;$|(&quot;&quot;)&quot;&quot;&quot;, &quot;$1&quot;)"
	     />
       </xsl:matching-substring>
     </xsl:analyze-string>
   </xsl:function>

</xsl:stylesheet>
