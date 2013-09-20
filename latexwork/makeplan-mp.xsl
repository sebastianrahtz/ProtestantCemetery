<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                >
<xsl:output method="xml"/>
<xsl:strip-space elements="*"/>

<xsl:import href="svg-mp.xsl"/>

<xsl:template match="/">
 beginfig(1);
path s;
  <xsl:apply-templates select="/cemetery/stone"/>
endfig;
end
</xsl:template>

<xsl:template match="stone">
  <xsl:variable name="test">
   <xsl:text>S</xsl:text><xsl:value-of select="@number"/>
  </xsl:variable>
%Stone <xsl:value-of select="$test"/>
s:=<xsl:variable name="polygon">
    <xsl:for-each select="document('f-st-ez.svg')">
         <xsl:apply-templates select="id($test)"/>
    </xsl:for-each>
 </xsl:variable>
<xsl:if test="not($polygon = '')">
 <xsl:value-of select="$polygon"/>
fill s withcolor
<xsl:choose>
<xsl:when test="person[1]/nat">
 <xsl:variable name="nat">
  <xsl:value-of select="person[1]/nat/@idref"/>
 </xsl:variable>
 <xsl:value-of select="document('colors.xml')/colorcodes/color[@id=$nat]"/>
</xsl:when>
<xsl:otherwise>
white
</xsl:otherwise>
 </xsl:choose>
; draw s withcolor black;
</xsl:if>
</xsl:template>

</xsl:stylesheet>
