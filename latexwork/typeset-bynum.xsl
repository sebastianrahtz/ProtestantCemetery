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
  <xsl:apply-templates select=".//TEI.2"/>  
</cemetery>
</xsl:template>

</xsl:stylesheet>
