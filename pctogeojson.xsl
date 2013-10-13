<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="2.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" indent="yes"/>
  <xsl:variable name="top" select="/"/>
  <xsl:variable name="inq">"</xsl:variable>
  <xsl:variable name="outq">""</xsl:variable>
  <xsl:template match="/">
    <xsl:variable name="geo">
    <geo xmlns="http://www.tei-c.org/ns/1.0">
      <xsl:for-each
	  select="tokenize(unparsed-text('countries-geojson.csv','utf-8'),  '&#xa;')">
      <xsl:analyze-string select="." regex="([^,]+),([^,]+),([^,]+),(.*)">
	<xsl:matching-substring>
	  <country xml:id="{regex-group(2)}">
	    <xsl:variable name="country"
		select="replace(replace(replace(replace(substring-after(regex-group(4),concat('type',$outq,':')),$outq,$inq),'\]\]',']'),'\[\[','['),concat('}',$inq),'')"/>
	      <xsl:value-of select="$country"/>
	      <xsl:analyze-string select="$country"
			regex="\[([0-9\-\.]+),([0-9\-\.]+)\]">
		<xsl:matching-substring>
		  <pos x="{regex-group(1)}" y="{regex-group(2)}"/>
	      </xsl:matching-substring>
	      </xsl:analyze-string>
	  </country>
	</xsl:matching-substring>
	<xsl:non-matching-substring>
	  <xsl:message>bad <xsl:value-of select="."/></xsl:message>
	</xsl:non-matching-substring>
      </xsl:analyze-string>
      </xsl:for-each>
    </geo>
    </xsl:variable>

    <xsl:text>{"type":"FeatureCollection","features":[</xsl:text>
      <xsl:for-each-group select=".//person" group-by="nationality/@key">
	  <xsl:text> { "type":"Feature","properties":{["people":[</xsl:text>
	  <xsl:variable name="n" select="current-grouping-key()"/>
	  <xsl:for-each select="current-group()">
	    <xsl:text> { </xsl:text>
	    <xsl:variable name="s" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
	    <xsl:sequence select="tei:field(age,'age')"/>
	    <xsl:sequence select="tei:field(sex,'sex')"/>
	    <xsl:sequence select="tei:field(birth/@when,'birth')"/>
	    <xsl:sequence select="tei:field(death/@when,'death')"/>
	    <xsl:sequence select="tei:field($n,'nationality')"/>
	    <xsl:sequence select="tei:field(persName/forename,'forename')"/>
	    <xsl:sequence
		select="tei:finalfield(persName/surname,'surname')"/>
	    <xsl:text> } </xsl:text>
	    <xsl:if test="position()&lt;last()">
	      <xsl:text>,</xsl:text>
	    </xsl:if>
	  </xsl:for-each>
	  <xsl:text> ]]},&#10; "geometry":{</xsl:text>
	  <xsl:value-of select="$geo/id($n)/text()"/>
	  <xsl:text>}</xsl:text>
      </xsl:for-each-group>
    <xsl:text>}&#10;]}</xsl:text>    
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
