<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:svg="http://www.w3.org/2000/svg" 
                version="1.0"
                >
<xsl:output method="text"/>
<xsl:strip-space elements="*"/>

<xsl:template match="svg:g[@id]">
  <xsl:text>{</xsl:text><xsl:value-of select="svg:rect/@x"/>}%
  {<xsl:value-of select="svg:rect/@y"/>}%
  {<xsl:value-of select="svg:rect/@width"/>}%
  {<xsl:value-of select="svg:rect/@height"/>}%
  {<xsl:apply-templates select=".//svg:polygon"/>}%
</xsl:template>

<xsl:template name="undopoly">
<xsl:param name="list"/>
<xsl:if test="not($list = '')">
<xsl:value-of select="substring-before($list,',')"/>
<xsl:text> </xsl:text>
 <xsl:value-of select="substring-after(substring-before($list,' '),',')"/>
<xsl:text> l
</xsl:text>
<xsl:call-template name="undopoly">
<xsl:with-param name="list" select="substring-after($list,' ')"/>
</xsl:call-template>
</xsl:if>
</xsl:template>

<xsl:template match="svg:polygon">
<xsl:variable name="alllist" select="concat(normalize-space(@points),' ')"/>
<xsl:variable name="rest">
 <xsl:value-of select="substring-after($alllist,' ')"/>
</xsl:variable>
<xsl:variable name="first">
 <xsl:value-of select="substring-before($alllist,' ')"/>
</xsl:variable>
<xsl:text>\pdfpolygon{%
</xsl:text>
<xsl:value-of select="substring-before($first,',')"/>
<xsl:text> </xsl:text>
<xsl:value-of  select="substring-after($first,',')"/>
<xsl:text> m
</xsl:text>
<xsl:call-template name="undopoly">
 <xsl:with-param name="list" select="$rest"/>
</xsl:call-template>
<xsl:text>}%
</xsl:text>
</xsl:template>


</xsl:stylesheet>
