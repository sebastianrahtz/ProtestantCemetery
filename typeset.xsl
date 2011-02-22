<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [
 <!ENTITY copy  "&#169;">
 <!ENTITY nl "&#xA;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" >


<xsl:import href="cemtex.xsl"/>

<xsl:preserve-space elements="*"/>

<xsl:output method="xml"/>

<xsl:key name="nats" match="person" use="nationality/@code"/>
<xsl:key name="CATS" match="category" use="@id"/>
<xsl:key name="LANGS" match="language" use="@id"/>

<xsl:template match="/">
<cemetery>
 <xsl:for-each
   select=".//person[generate-id(.)=generate-id(key('nats',nationality/@code)[1])]" >
     <xsl:sort select="nationality/@code"/>
     <xsl:variable name="y" select="nationality/@code"/>
     <xsl:variable name="country">
       <xsl:value-of select="key('CATS',$y)/catDesc"/>
     </xsl:variable>
     &nl;
    <Section>Country <xsl:value-of select="$y"/><xsl:text>: </xsl:text><xsl:value-of select="$country"/>.</Section>
      &nl;
  <xsl:for-each select="key('nats',$y)">
   <xsl:sort select="death/@date"/>
   <xsl:sort select="persName/surname"/>
   <xsl:sort select="persName/foreName"/>
<xsl:choose>
<xsl:when test="not(preceding-sibling::person)">
     <xsl:apply-templates select="ancestor::TEI.2">  
       <xsl:with-param name="Country" select="$country"/>
     </xsl:apply-templates>
</xsl:when>
<xsl:otherwise>
 <par/>See also <xsl:value-of select="persName/foreName"/><xsl:text> </xsl:text>
 <xsl:value-of select="persName/surname"/>
 (stone <xsl:value-of select="ancestor::TEI.2/@id"/>), listed under
 country <xsl:value-of select="ancestor::TEI.2//person[1]/nationality/@code"/>
 (<xsl:value-of select="key('CATS',ancestor::TEI.2//person[1]/nationality/@code)/catDesc"/>),
 <xsl:value-of select="ancestor::TEI.2//person[1]/persName/foreName"/>
 <xsl:text> </xsl:text>
 <xsl:value-of select="ancestor::TEI.2//person[1]/persName/surname"/>
 (<xsl:value-of select="substring-before(ancestor::TEI.2//person[1]/death/@date,'-')"/>)
</xsl:otherwise>
</xsl:choose>
  </xsl:for-each>
 </xsl:for-each>
</cemetery>
</xsl:template>



<xsl:template match="header"/>


</xsl:stylesheet>
