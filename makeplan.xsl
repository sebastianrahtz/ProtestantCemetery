<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:svg="http://www.w3.org/2000/svg" 
                        version="1.0"                >

<xsl:import href="svg-pdf.xsl"/>

<xsl:key name="SVG" match="svg:g" use="@id"/>


<xsl:output method="text"/> 

<xsl:template match="/">
\documentclass{article}
\usepackage{cemplan}
\begin{document}
\CemBB|<xsl:value-of select="document('plan.svg')/svg:svg/@viewBox"/>|
<xsl:text>
\vbox to \textheight{\vfill\begin{pdfpicture}
</xsl:text>
 <xsl:call-template name="outline"/>
 <xsl:apply-templates select="//TEI.2"/>
\end{pdfpicture}}
\end{document}
</xsl:template>

<xsl:template name="outline">
  <xsl:variable name="polygon">
    <xsl:for-each select="document('plan.svg')">
         <xsl:apply-templates select="key('SVG','S0')"/>
    </xsl:for-each>
 </xsl:variable>
 \Stone{0}{}%
   <xsl:value-of select="$polygon"/>
 <xsl:text>{ 0 G h S Q}%</xsl:text>
</xsl:template>

<xsl:template match="TEI.2">
<xsl:variable name="stone_number">
   <xsl:value-of select="@id"/>
</xsl:variable>
 <xsl:variable name="polygon">
    <xsl:for-each select="document('plan.svg')">
         <xsl:apply-templates select="key('SVG',$stone_number)"/>
    </xsl:for-each>
  </xsl:variable>

<xsl:if test="not($polygon ='')">
<xsl:text>
\Stone</xsl:text>
{<xsl:value-of select="substring-after($stone_number,'S')"/>}%
{<xsl:value-of select=".//person[1]/nationality/@code"/>
<xsl:text>}%
</xsl:text>
   <xsl:value-of select="$polygon"/>

 <xsl:text>{</xsl:text>
<!--  color by zona
<xsl:variable name="z" select="@zona"/>
 <xsl:value-of select="document('colors.xml')/colorcodes/color[@id=$z]"/>
-->
<!-- color by decade -->
<xsl:choose>
<xsl:when test="person[1]/died/date/yr">
  <xsl:variable name="code">
   <xsl:value-of select="concat('decade_',substring(person[1]/died/date/yr,1,3))"/>
  </xsl:variable>
  <xsl:value-of select="document('colors.xml')/colorcodes/color[@id=$code]"/>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> 1 1 1  </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:text> rg 0 G b Q}%</xsl:text>
</xsl:if>
</xsl:template>

</xsl:stylesheet>

<!--
<xsl:for-all select="svg/@x">
 <xsl:sort selecet="." data-type="number"/>
from here:
 <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
to here:
 <xsl:if test="position()=last()"><xsl:value-of select="."/></xsl:if>
</xsl:for-all>

-->
