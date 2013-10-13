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
  <xsl:variable name="outq">\\"</xsl:variable>
  <xsl:variable name="doubleq">""</xsl:variable>
  <xsl:template match="/">
    <xsl:variable name="regex">
      <xsl:text>([^,]+), ([^,]+), ([^,]+), (.*)</xsl:text>
    </xsl:variable>
    <xsl:variable name="geo">
    <geo xmlns="http://www.tei-c.org/ns/1.0">
      <xsl:for-each
	  select="tokenize(unparsed-text('countries-geojson.csv','utf-8'), '&#xa;')">
      <xsl:analyze-string select="replace(.,$doubleq,$inq)" regex="{$regex}">
	<xsl:matching-substring>
	  <country xml:id="{regex-group(2)}" n="{regex-group(1)}">
	    <xsl:value-of select="substring(regex-group(4),2,string-length(regex-group(4))-2)"/>
	    <xsl:analyze-string select="regex-group(4)"
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
      <xsl:for-each-group select=".//person[nationality/@key]"
			  group-by="nationality/@key">
	<xsl:sort select="nationality/@key"/>
	<xsl:variable name="n" select="current-grouping-key()"/>
	<xsl:if test="$geo/id($n) and count(current-group())&gt;0">
	    <xsl:if test="position()&gt;1">
	      <xsl:text>,&#10;</xsl:text>
	    </xsl:if>
	  <xsl:text> { "type":"Feature",</xsl:text>
	  <xsl:text>"geometry":</xsl:text>
	  <xsl:value-of select="normalize-space($geo/id($n)/text())"/>
	  <xsl:text>,</xsl:text>
	  <xsl:text>"properties":{"name":"</xsl:text>
	  <xsl:value-of select="$geo/id($n)/@n"/>
	  <xsl:text>","people":</xsl:text>
	  <xsl:text>"</xsl:text>
	  <xsl:value-of select="count(current-group())"/>
	  <xsl:text>: </xsl:text>
	    <xsl:for-each select="current-group()">
	      <xsl:sort select="persName/surname"/>
	      <xsl:sort select="persName/forename"/>
	      <xsl:sequence
		  select="tei:simplefield(persName/surname,'surname')"/>
	      <xsl:text>, </xsl:text>
	      <xsl:sequence select="tei:simplefield(persName/forename,'forename')"/>
	      <xsl:text> (</xsl:text>
	      <xsl:sequence
		  select="tei:simplefield(death/@when,'death')"/>
	      <xsl:text>)</xsl:text>
	      <xsl:if test="position()&lt;last()">
		<xsl:text>; </xsl:text>
	      </xsl:if>
	    </xsl:for-each>
	    <xsl:text>"</xsl:text>
	    <xsl:text>}}</xsl:text>
	  </xsl:if>
      </xsl:for-each-group>
      <xsl:text>]}&#10;</xsl:text>          
  </xsl:template>

  <xsl:function name="tei:field">
    <xsl:param name="data"/>
    <xsl:param name="label"/>
    <xsl:if test="string-length(normalize-space($data))&gt;0">
      <xsl:text>"</xsl:text>
      <xsl:value-of select="$label"/>
      <xsl:text>": "</xsl:text>
      <xsl:value-of select="replace(normalize-space($data),$inq,$outq)"/>
      <xsl:text>",</xsl:text>
    </xsl:if>
  </xsl:function>
  <xsl:function name="tei:simplefield">
    <xsl:param name="data"/>
    <xsl:param name="label"/>
    <xsl:if test="string-length(normalize-space($data))&gt;0">
      <xsl:value-of select="replace(normalize-space($data),$inq,$outq)"/>
    </xsl:if>
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
