<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns="http://www.w3.org/1999/xhtml" 
		xmlns:xi="http://www.w3.org/2001/XInclude" 
		xmlns:tei="http://www.tei-c.org/ns/1.0" 
		xmlns:svg="http://www.w3.org/2000/svg" 
		xmlns:xlink="http://www.w3.org/1999/xlink"
		exclude-result-prefixes="xi tei svg xlink" 
		xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
		version="2.0">
  <xsl:import href="/Users/rahtz/TEI/Stylesheets/epub3/tei-to-epub3.xsl"/>
  <xsl:import href="../html/pc-common.xsl"/>
  <xsl:param name="cellAlign">center</xsl:param>
  <xsl:param name="institution"/>
  <xsl:param name="splitLevel">-1</xsl:param>
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
  <xsl:param name="publisher">Oxford University</xsl:param>
  <xsl:param name="subject">Protestant Cemetery</xsl:param>
  <xsl:param name="cssFile"><xsl:value-of select="resolve-uri('../../../cem.css',base-uri(document('')))"/></xsl:param>
  <xsl:param name="cssSecondaryFile"><xsl:value-of select="resolve-uri('../../../jquery-ui-1.10.3.custom.css',base-uri(document('')))"/></xsl:param>
  <xsl:param name="javascriptFiles">
    /Users/rahtz/TEI/ProtestantCemetery/cem.js,
    /Users/rahtz/TEI/ProtestantCemetery/jquery.mousewheel.js,
    /Users/rahtz/TEI/ProtestantCemetery/jquery-1.10.2.min.js,	
    /Users/rahtz/TEI/ProtestantCemetery/jquery.panzoom.min.js,
    /Users/rahtz/TEI/ProtestantCemetery/jquery-ui-1.10.3.custom.js,
    /Users/rahtz/TEI/ProtestantCemetery/jquery.svg.min.js,
    /Users/rahtz/TEI/ProtestantCemetery/jquery.dataTables.min.js
  </xsl:param>

  <xsl:param name="extraGraphicsFiles">banner.jpg</xsl:param>

  <xsl:function name="tei:generateSimpleTitle">
    <xsl:param name="context"/>
    <xsl:for-each select="$context">
      <xsl:apply-templates select="ancestor-or-self::teiCorpus/teiHeader/fileDesc/titleStmt/title" mode="simple"/>
    </xsl:for-each>
  </xsl:function>

  <xsl:template name="epubManifestHook">
  <xsl:for-each select="/teiCorpus/TEI[not(@type='doc')]">
    <xsl:variable name="ID" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
      <item xmlns="http://www.idpf.org/2007/opf" media-type="application/xhtml+xml" href="{$ID}.html" id="{$ID}"/>
    </xsl:for-each>

  </xsl:template>

  <xsl:template name="epubSpineHook">
  <xsl:for-each select="/teiCorpus/TEI[not(@type='doc')]">
    <xsl:variable name="ID" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
      <itemref xmlns="http://www.idpf.org/2007/opf" idref="{$ID}" linear="no"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="epub-start-properties">
    <xsl:attribute name="properties">svg scripted</xsl:attribute>
  </xsl:template>

  <xsl:template name="mainTOC"/>
 
  <xsl:template match="graphic[starts-with(@url,'film:')]"
		mode="preflight" priority="99">
  </xsl:template>


</xsl:stylesheet>
