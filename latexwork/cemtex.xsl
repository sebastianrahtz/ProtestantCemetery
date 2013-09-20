<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="TEI.2">
 <xsl:param name="Country" select="'XXX'"/>
 <xsl:variable name="z" select=".//location/zone/@target"/>
 <xsl:variable name="f" select=".//form/@target"/>
 <xsl:variable name="m" select=".//material/@target"/>
 <xsl:variable name="n" select=".//person[1]/nationality/@code"/>
 <xsl:variable name="p1"><xsl:value-of select=".//person[1]/persName/surname"/></xsl:variable>
 <gravestone
    id="{@id}" 
    nat="{$n}"
    natfull="{$Country}"
    name="{$p1}"
   date="{substring-before(.//person[1]/death/@date,'-')}">
<row>
<stone><xsl:value-of select="@id"/></stone>
<cell>
  <xsl:value-of select="key('CATS',$z)/catDesc"/>
   <xsl:text>;  </xsl:text>
   <xsl:value-of select="key('CATS',$f)/catDesc"/>
   <xsl:text>;  </xsl:text>
   <xsl:value-of select="key('CATS',$m)/catDesc"/>.
   <math><xsl:value-of select=".//height"/><times/> 
   <xsl:value-of select=".//width"/><times/><xsl:value-of select=".//breadth"/>
 </math></cell>
 <xsl:apply-templates select=".//person[1]"/>
</row>
<xsl:if test="count(.//person) &gt; 1">
  <xsl:for-each select=".//person">
     <xsl:if test="position() &gt; 1">
      <row><cell/><cell/><xsl:apply-templates select="."/></row>
     </xsl:if>
  </xsl:for-each>
</xsl:if>
 </gravestone>
 <xsl:if test="count(.//div)&gt;0">
 <inscrips>
   <xsl:apply-templates select=".//div"/>
 </inscrips>
</xsl:if>
<xsl:apply-templates select=".//physicalDescription/decoration"/>
</xsl:template>

<xsl:template match="decoration">
<xsl:apply-templates select="p"/>
  <xsl:text>
</xsl:text>
  <xsl:for-each select="feature">
   <xsl:call-template name="splitDecl">
     <xsl:with-param name="decl" select="@decls"/>
   </xsl:call-template>
    
  </xsl:for-each>
</xsl:template>

<xsl:template match="tab">
 <tabbed><xsl:apply-templates/></tabbed>
</xsl:template> 
<xsl:template match="note">
 <GLOSS><xsl:text>note: </xsl:text><xsl:apply-templates/></GLOSS>
</xsl:template> 
<xsl:template match="hi[@rend='gothic']">
 <Gothic><xsl:apply-templates/></Gothic>
</xsl:template> 
<xsl:template match="emph">
 <emph><xsl:apply-templates/></emph>
</xsl:template> 
<xsl:template match="hi">
 <textbf><xsl:apply-templates/></textbf>
</xsl:template> 
<xsl:template match="hi[@rend='sup']">
 <Raised><xsl:apply-templates/></Raised>
</xsl:template> 

<xsl:template match="ab">
 <line>
<xsl:choose>
    <xsl:when test="count(.//text())=0"> 
      <xsl:text> </xsl:text>
    </xsl:when>
    <xsl:when test="@rend='Alignr'">
      <xsl:attribute name="align">right</xsl:attribute><xsl:apply-templates/>
    </xsl:when>
    <xsl:when test="@rend='Alignl'">
      <xsl:attribute name="align">left</xsl:attribute>
          <hspace>.5cm</hspace><xsl:apply-templates/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>      
    </xsl:otherwise>
</xsl:choose>
</line>
<!--
  my $pos = $element->attribute('P')->value;
  my $script = $element->attribute('SCRIPT')->value;
  if ($script eq "CY") { $cyrillic=1 ; }
  elsif ($script eq "RM") { $cyrillic=0 ; }
  if ($cyrillic) {
     s/([A-Z])'/\1\\char94{}/g;
     s/([a-z])'/\1\\char126{}/g;
     s/([A-Z])\"/\1\\char95{}/g;
     s/([a-z])\"/\1\\char127{}/g;
     s/\.([IVX])+\./.\\Romanize{\1}\./g;
     s/-([IVX])+-/-\\Romanize{\1}-/g;
     output "{\\Cyrillic $_}}\n";
-->
</xsl:template> 


<xsl:template match="desc">
 <par/><xsl:text>Notes: </xsl:text>
 <xsl:apply-templates/>
</xsl:template> 

<xsl:template match="photo">
 <xsl:text> (Photo </xsl:text><xsl:value-of select="@film"/>
 <xsl:text>.</xsl:text><xsl:value-of select="@neg"/><xsl:text>)</xsl:text>
</xsl:template>


<xsl:template match="birth">
  <xsl:if test="not(@date='0-0-0')">
   <xsl:text>*</xsl:text><xsl:apply-templates select="@date"/>
   <xsl:text> </xsl:text>
   <xsl:apply-templates/>
   <xsl:text> </xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="death">
 <textdagger/><xsl:apply-templates select="@date"/>
  <xsl:text> </xsl:text>
  <xsl:apply-templates/>
 <newline/>
</xsl:template>

<xsl:template match="birth/placeName">
  <xsl:call-template name="ifnotempty">
    <xsl:with-param name="tag"></xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="death/placeName">
  <xsl:call-template name="ifnotempty">
    <xsl:with-param name="tag"></xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="occupation">
  <xsl:call-template name="ifnotempty">
    <xsl:with-param name="tag">Profession</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="age">
  <xsl:call-template name="ifnotempty">
    <xsl:with-param name="tag">Age</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!--
lang="l_EN" decls="f_E c_1 m_IF t_P"
-->

<xsl:template match="div">
 <xsl:variable name="l" select="@lang"/>
 <row>
 <cell><textbf><xsl:number/></textbf></cell>
 <cell>
   <xsl:call-template name="splitDecl">
     <xsl:with-param name="decl" select="@decls"/>
   </xsl:call-template>
   <xsl:value-of select="key('LANGS',$l)"/>
 </cell><cell>
    <xsl:apply-templates/>
 </cell>
 </row>
</xsl:template>

<xsl:template name="splitDecl">
  <xsl:param name="decl"/>
<xsl:choose>
  <xsl:when  test="contains($decl,' ')">
    <xsl:variable name="this" select="substring-before($decl,' ')"/>
    <emph><xsl:value-of select="key('CATS',$this)/../@id"/></emph>:
    <xsl:value-of select="key('CATS',$this)/catDesc"/>,
    <xsl:call-template name="splitDecl">
     <xsl:with-param name="decl" select="substring-after($decl,' ')"/>
    </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
    <emph><xsl:value-of select="key('CATS',$decl)/../@id"/></emph>:
    <xsl:value-of select="key('CATS',$decl)/catDesc"/>.
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="nationality">
 <xsl:variable name="y" select="@code"/>
 <natcode><xsl:value-of select="$y"/></natcode>
   <emph><xsl:text>Nationality: </xsl:text></emph>
   <xsl:value-of select="key('CATS',$y)/catDesc"/>
</xsl:template>

<xsl:template match="person">
   <cell><xsl:apply-templates select="persName"/></cell>
   <cell>
      <xsl:apply-templates select="birth"/>
      <xsl:apply-templates select="death"/>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="nationality"/>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="profess"/>
      <xsl:apply-templates select="comment"/>
   </cell>
</xsl:template>

<xsl:template match="persName">
 <xsl:text>[</xsl:text><xsl:value-of select="../@sex"/>
 <xsl:text>] </xsl:text>
<Person>
 <fnm><xsl:apply-templates select="foreName"/></fnm>
 <snm><xsl:apply-templates select="surname"/></snm>
</Person>
</xsl:template>

<xsl:template name="ifnotempty">
<xsl:param name="tag"/>
<xsl:if test="count(.//text())>0"> 
  <xsl:text> </xsl:text>
  <xsl:if test="$tag">
    <emph><xsl:value-of select="$tag"/></emph><xsl:text>: </xsl:text> 
  </xsl:if>
  <xsl:apply-templates/>  
</xsl:if>
</xsl:template>

</xsl:stylesheet>
