<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                >
<xsl:output method="text"/>

<xsl:template match="polygon" mode="mp">
<xsl:text>s:=</xsl:text>
<xsl:call-template name="undopoly" mode="mp"/>
<xsl:text>cycle; 
</xsl:text>
</xsl:template>

<xsl:template match="polygon" mode="pstricks">
<xsl:text>s:=</xsl:text>
<xsl:call-template name="undopoly" mode="pstricks"/>
<xsl:text>cycle; 
</xsl:text>
</xsl:template>

<xsl:template name="undopoly">
<xsl:param name="list" select="concat(normalize-space(@points),' ')"/>
<xsl:if test="not($list = '')">
<xsl:text>(</xsl:text>
<xsl:value-of select="substring-before($list,',')"/>
<xsl:text>,</xsl:text>
 <xsl:value-of select="substring-after(substring-before($list,' '),',')"/>
<xsl:text>)--</xsl:text>
<xsl:call-template name="undopoly" mode="mp">
<xsl:with-param name="list" select="substring-after($list,' ')"/>
</xsl:call-template>
</xsl:if>
</xsl:template>

<xsl:template name="undopoly" mode="pstricks">
<xsl:param name="list" select="concat(normalize-space(@points),' ')"/>
<xsl:if test="not($list = '')">
<xsl:text>(</xsl:text>
<xsl:value-of select="substring-before($list,',')"/>
<xsl:text>,</xsl:text>
 <xsl:value-of select="substring-after(substring-before($list,' '),',')"/>
<xsl:text>)
</xsl:text>
<xsl:call-template name="undopoly" mode="pstricks">
<xsl:with-param name="list" select="substring-after($list,' ')"/>
</xsl:call-template>
</xsl:if>
</xsl:template>
</xsl:stylesheet>
