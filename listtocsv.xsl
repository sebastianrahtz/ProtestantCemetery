<?xml version='1.0'?>
<xsl:stylesheet 
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" >


<xsl:output method="text"/>

<xsl:template match="/">
  <xsl:text>"Stone","Surname","Year","Tomb"&#10;</xsl:text>
<xsl:for-each select=".//person" >
  <xsl:variable name="tomb"
		select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='tomb']"/>
  <xsl:variable name="id"
		select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
  <xsl:variable name="name"
		select="persName/surname"/>
  <xsl:variable name="year"
		select="substring(death/@when,1,4)"/>
  <xsl:text>"</xsl:text>
  <xsl:value-of select="$id"/>
  <xsl:text>","</xsl:text>
  <xsl:value-of select="$name"/>
  <xsl:text>",</xsl:text>
  <xsl:value-of select="$year"/>
  <xsl:text>,</xsl:text>
  <xsl:value-of select="$tomb"/>
  <xsl:text>&#10;</xsl:text>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
