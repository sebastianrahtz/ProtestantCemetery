<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg" 
    xmlns:exsl="http://exslt.org/common"
    exclude-result-prefixes="exsl" 
    extension-element-prefixes="exsl"
                version="1.0">

<xsl:import href="svg-pdf.xsl"/>
<xsl:import href="makeplan.xsl"/>

<xsl:key name="ZONES" match="zone" use="@target"/>

<xsl:template match="/">
<xsl:call-template name="zoneplan">
   <xsl:with-param name="zone" select="'A'"/>
</xsl:call-template>
<xsl:call-template name="zoneplan">
   <xsl:with-param name="zone" select="'V'"/>
</xsl:call-template>
<xsl:call-template name="zoneplan">
   <xsl:with-param name="zone" select="'P'"/>
</xsl:call-template>
<xsl:call-template name="zoneplan">
   <xsl:with-param name="zone" select="'S'"/>
</xsl:call-template>
<xsl:call-template name="zoneplan">
   <xsl:with-param name="zone" select="'T'"/>
</xsl:call-template>
</xsl:template>

<xsl:template name="zoneplan">
<xsl:param name="zone"/>
      <exsl:document         
        method="text" href="{concat(concat('zone_',$zone),'.texxml')}">
\documentclass{article}
\usepackage{cemplan}
\begin{document}
\CemBB|<xsl:value-of select="document('plan.svg')/svg:svg/@viewBox"/>|
\vbox to \textheight{\vfill\begin{pdfpicture}
 <xsl:variable name="z">z_<xsl:value-of select="$zone"/></xsl:variable>
 <xsl:message>
   process zone <xsl:value-of select="$z"/>
 </xsl:message>
 <xsl:for-each select="key('ZONES',$z)"> 
   <xsl:apply-templates select="ancestor::TEI.2"/>
 </xsl:for-each>
\end{pdfpicture}}
\end{document}
</exsl:document>

</xsl:template>

</xsl:stylesheet>
