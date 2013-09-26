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

  <xsl:template match="zone">
    <xsl:copy>
      <xsl:apply-templates
        select="*|@*|processing-instruction()|comment()|text()"/>
      <xsl:variable name="me" select="."/>
      <xsl:variable name="id" select="substring(@xml:id,6)"/>
      <xsl:for-each select="doc('cemetery.xml')//cell[.=$id]">
	<xsl:variable name="pic" select="parent::row/cell[1]//ref"/>
	<xsl:message>found <xsl:value-of
	select="($id,$pic)" separator=" "/></xsl:message>
	<xsl:if test="not($me/graphic[@url=concat('pictures/',$pic)])">
	  <graphic url="pictures/{$pic}"/>
	</xsl:if>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
