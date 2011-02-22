<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="2.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates
        select="*|@*|processing-instruction()|comment()|text()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|processing-instruction()|comment()">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="@uly">
    <xsl:attribute name="uly">
      <xsl:value-of select="(1102.158275 - number(.))+86"/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="@lry">
    <xsl:attribute name="lry">
      <xsl:value-of select="(1102.158275 - number(.))+86"/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="@points">
    <xsl:attribute name="points">
      <xsl:analyze-string  regex="([0-9\.]+),([0-9\.]+)[ ]?" select="normalize-space(.)">
	<xsl:matching-substring>
	<xsl:value-of select="regex-group(1)"/>
	<xsl:text>,</xsl:text>
	<xsl:value-of select="(1102.158275 - number(regex-group(2)))+86"/>
	<xsl:text> </xsl:text>
	</xsl:matching-substring>
	<xsl:non-matching-substring>
	  <xsl:message>
	      <xsl:text>Invalid format of points [</xsl:text>
	      <xsl:value-of select="."/>
	      <xsl:text>] </xsl:text>
	  </xsl:message>
	</xsl:non-matching-substring>
      </xsl:analyze-string>
    </xsl:attribute>
  </xsl:template>

</xsl:stylesheet>
