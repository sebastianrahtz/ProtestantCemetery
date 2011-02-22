<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                >

<xsl:output method="text"/>

<xsl:template match="svg">
<xsl:text>beginfig(1);
</xsl:text>
  <xsl:apply-templates/>
<xsl:text> endfig;
 end
</xsl:text>
</xsl:template>

<xsl:template match="polygon">
<xsl:text>draw</xsl:text>
<xsl:call-template name="spqr"/>
<xsl:text>cycle;
</xsl:text>
</xsl:template>

<xsl:template name="spqr">
<xsl:param name="list" select="concat(normalize-space(@points),' ')"/>
<xsl:if test="not($list = '')">
<xsl:text>(</xsl:text>
<xsl:value-of select="substring-before($list,',')"/>
<xsl:text>,</xsl:text>
 <xsl:value-of select="substring-after(substring-before($list,' '),',')"/>
<xsl:text>)--</xsl:text>
<xsl:call-template name="spqr">
<xsl:with-param name="list" select="substring-after($list,' ')"/>
</xsl:call-template>
</xsl:if>
</xsl:template>


</xsl:stylesheet>

