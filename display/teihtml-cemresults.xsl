<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0"
  xmlns:exsl="http://exslt.org/common"
  extension-element-prefixes="exsl"
  exclude-result-prefixes="exsl" 
  xmlns:html="http://www.w3.org/1999/xhtml">

  <xsl:import href="../stylesheets/teihtml-oucs.xsl"/>
  <xsl:import href="../teihtml-cemlib.xsl"/>

   <xsl:param name="cellAlign">center</xsl:param>
   <xsl:param name="autoToc"></xsl:param>
   <xsl:template name="logoPicture"></xsl:template>
   <xsl:param name="cssFile">/stylesheets/tei-oucs.css</xsl:param>
   <xsl:param name="feedbackURL">pcYears.html</xsl:param>
   <xsl:template name="feedbackWords">Catalogue by Year</xsl:template>
   <xsl:param name="homeLabel">Protestant Cemetery Catalogue</xsl:param>
   <xsl:param name="homeURL">pcCountries.html</xsl:param>
   <xsl:param name="homeWords">Catalogue by Country</xsl:param>
   <xsl:param name="institution">Protestant Cemetery catalogue</xsl:param>
   <xsl:param name="department"/>
   <xsl:param name="parentURL">index.html</xsl:param>
   <xsl:param name="parentWords">Protestant Cemetery, Rome</xsl:param>
   <xsl:param name="searchURL">pcNames.html</xsl:param>
   <xsl:template name="searchWords">Catalogue by Name</xsl:template>
   <xsl:param name="topNavigationPanel"></xsl:param>
   <xsl:param name="bottomNavigationPanel"></xsl:param>
   <xsl:param name="alignNavigationPanel">right</xsl:param>
   <xsl:param name="linkPanel">true</xsl:param>
   <xsl:template name="copyrightStatement">British School at Rome</xsl:template>

<xsl:key name="nats" match="person" use="nationality/@code"/>
<xsl:key name="CATS" match="category" use="@id"/>
<xsl:key name="LANGS" match="language" use="@id"/>

<xsl:template match="cell/TEI.2">
      <xsl:call-template name="doDivBody"/>          
</xsl:template>


<xsl:template match="cell/div">
  <table><xsl:apply-templates/></table>
</xsl:template>


</xsl:stylesheet>


