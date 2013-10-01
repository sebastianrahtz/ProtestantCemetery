<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="2.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates
        select="*|@*|processing-instruction()|comment()|text()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|processing-instruction()|comment()">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="msIdentifier">
    <xsl:copy>
      <xsl:apply-templates
        select="*|@*|processing-instruction()|comment()|text()"/>
      <xsl:variable name="id" select="idno"/>
      <xsl:for-each select="doc('matches.xml')//m[cem=$id]">
	<altIdentifier>
	  <idno type="tomb"><xsl:value-of select="plot"/></idno>
	</altIdentifier>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
