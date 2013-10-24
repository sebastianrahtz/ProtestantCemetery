<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="xi tei svg xlink" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
  <xsl:import href="/usr/share/xml/tei/stylesheet/html5/html5.xsl"/>
  <xsl:import href="pc-common.xsl"/>
  <xsl:param name="cellAlign">center</xsl:param>
  <xsl:param name="cssFile"><xsl:value-of select="$JS"/>cem.css</xsl:param>
  <xsl:param name="cssPrintFile"/>
  <xsl:param name="cssSecondaryFile"><xsl:value-of select="$JS"/>jquery-ui-1.10.3.custom.css</xsl:param>
  <xsl:param name="institution"/>
  <xsl:param name="department"/>
  <xsl:param name="parentURL">index.html</xsl:param>
  <xsl:param name="parentWords"/>
  <xsl:param name="topNavigationPanel"/>
  <xsl:param name="bottomNavigationPanel"/>
  <xsl:param name="alignNavigationPanel">right</xsl:param>
  <xsl:param name="linkPanel">true</xsl:param>
  <xsl:template name="copyrightStatement">British School at Rome</xsl:template>
  <xsl:variable name="TOP" select="/"/>
  <xsl:template name="logoPicture"/>


</xsl:stylesheet>
