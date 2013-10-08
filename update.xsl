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

<xsl:template match="text">
                <xsl:variable name="id" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
<facsimile>
  <surface ulx="0" uly="88.158275" lrx="3200" lry="1188.158275">
    <xsl:copy-of select="doc('cem.xml')//zone[@xml:id=concat('Plot_',$id)]"/>
  </surface>
</facsimile>
<xsl:copy>
  <xsl:apply-templates
        select="*|@*|processing-instruction()|comment()|text()"/>
    </xsl:copy>
</xsl:template>
</xsl:stylesheet>
