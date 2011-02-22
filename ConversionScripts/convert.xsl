<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="tei exsl"
  extension-element-prefixes="exsl" version="1.0"
  xmlns:exsl="http://exslt.org/common" 
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output cdata-section-elements="tei:eg tei:egXML eg egXML" 
	      encoding="utf8"
	      indent="yes" 
	      method="xml" 
	      omit-xml-declaration="yes"/>

  <xsl:template match="tei:*">
    <xsl:copy>
      <xsl:apply-templates
        select="*|@*|processing-instruction()|comment()|text()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|processing-instruction()|comment()">
    <xsl:copy/>
  </xsl:template>


  <xsl:template match="tei:surrogates"/>

<xsl:template match="tei:teiHeader">
  <xsl:copy>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates
	select="tei:*|comment()|processing-instruction()|text()"/>
    <xsl:for-each select=".//tei:surrogates">
      <facsimile>
	<xsl:apply-templates
	    select="tei:*|comment()|processing-instruction()|text()"/>
      </facsimile>
    </xsl:for-each>
  </xsl:copy>
</xsl:template>

<xsl:template match="tei:TEI">
    <xsl:variable name="ident">
      <xsl:value-of select="@xml:id"/>
    </xsl:variable>
    <xsl:message>write <xsl:value-of select="$ident"/></xsl:message>
    <exsl:document         
     method="xml"
     encoding="utf-8"
     omit-doctype-declaration="yes"
     omit-xml-declaration="yes" 
     href="newStones/{$ident}.xml">
      <xsl:copy>
	<xsl:apply-templates select="@*"/>
	<xsl:apply-templates select="tei:*|comment()|processing-instruction()|text()"/>
      </xsl:copy>
    </exsl:document>
</xsl:template>

<xsl:template match="tei:nationality/@date">
  <xsl:attribute name="when">
    <xsl:value-of select="."/>
  </xsl:attribute>
</xsl:template>

<xsl:template match="tei:nationality/@reg">
  <xsl:attribute name="key">
    <xsl:value-of select="."/>
  </xsl:attribute>
</xsl:template>

</xsl:stylesheet>
