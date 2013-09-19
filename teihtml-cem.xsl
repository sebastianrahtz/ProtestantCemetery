<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml" 
		xmlns:xi="http://www.w3.org/2001/XInclude"
		exclude-result-prefixes="xi"
		xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
		version="2.0">
  <xsl:import href="/usr/share/xml/tei/stylesheet/html/html.xsl"/>
  <xsl:param name="cellAlign">center</xsl:param>
  <xsl:param name="autoToc"/>
  <xsl:template name="logoPicture"/>
  <xsl:param name="cssFile">cem.css</xsl:param>
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
  <xsl:param name="topNavigationPanel"/>
  <xsl:param name="bottomNavigationPanel"/>
  <xsl:param name="alignNavigationPanel">right</xsl:param>
  <xsl:param name="linkPanel">true</xsl:param>
  <xsl:template name="copyrightStatement">British School at Rome</xsl:template>
  <xsl:key name="nats" match="person" use="nationality/@key"/>
  <xsl:key name="CATS" match="category" use="@xml:id"/>
  <xsl:key name="LANGS" match="language" use="@xml:id"/>
  <xsl:template match="teiCorpus">
    <html>
      <xsl:call-template name="addLangAtt"/>
      <head>
        <title>
          <xsl:apply-templates select="teiHeader/fileDesc/titleStmt/title/text()"/>
        </title>
        <link rel="stylesheet" type="text/css" href="{$cssFile}"/>
      </head>
      <body>
        <xsl:call-template name="bodyHook"/>
        <xsl:call-template name="bodyJavascriptHook"/>
        <xsl:call-template name="stdheader">
          <xsl:with-param name="title">
            <xsl:apply-templates select="teiHeader/fileDesc/titleStmt/title"/>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="stdfooter"/>
      </body>
    </html>
    <xsl:apply-templates select="TEI"/>
    <table>
    <xsl:for-each
	select="TEI/teiHeader/profileDesc/particDesc/listPerson/person">
      <xsl:sort select="persName/surname"/>
      <xsl:sort select="death/@when"/>
      <xsl:variable name="id" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
	<tr>
	  <td>	<a href="{$id}.html"><xsl:value-of select="$id"/></a></td>
	  <td>	<xsl:value-of select="death/@when"/></td>
	  <td>	<xsl:value-of select="xi:types(ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/physDesc/objectDesc/@form)"/></td>
	  <td>	<xsl:value-of select="nationality/@key"/></td>
	  <td>	<xsl:value-of select="persName/surname"/>, 	<xsl:value-of select="persName/forename"/></td>
	</tr>
    </xsl:for-each>
      </table>
  </xsl:template>
  <xsl:template match="TEI">
    <xsl:result-document href="{teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno}.html" method="xhtml">
      <xsl:call-template name="writeDiv"/>
    </xsl:result-document>
  </xsl:template>


  <xsl:template name="doDivBody">
    <xsl:param name="Depth">0</xsl:param>
    <xsl:param name="nav">false</xsl:param>
    <xsl:variable name="z" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdenifier/idno"/>
    <xsl:variable name="f" select=".//objectDesc/@form"/>
    <xsl:variable name="m" select=".//material"/>
    <xsl:variable name="n" select="teiHeader/profileDesc/particDesc/listPerson/person[1]/nationality/@key"/>
    <xsl:variable name="p1">
      <xsl:value-of select="teiHeader/profileDesc/particDesc/listPerson/person[1]/persName/surname"/>
    </xsl:variable>
    <table>
      <tr valign="top">
        <td>
          <xsl:value-of select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
        </td>
        <td>
	  <xsl:value-of select="$z"/>
	  <xsl:text>;  	</xsl:text>
	  <xsl:value-of select="key('CATS',$f)/catDesc"/>
	  <xsl:text>;  </xsl:text>
	  <xsl:value-of select="$m"/>.
	  <xsl:value-of select=".//height"/>
	  <xsl:text> x </xsl:text>
	  <xsl:value-of select=".//width"/>	
	  <xsl:text> x </xsl:text>
	  <xsl:value-of select=".//depth"/>
	</td>
        <xsl:apply-templates select="teiHeader/profileDesc/particDesc/listPerson/person[1]"/>
      </tr>
      <xsl:if test="count(teiHeader/profileDesc/particDesc/listPerson/person) &gt; 1">
        <xsl:for-each select="teiHeader/profileDesc/particDesc/listPerson/person">
          <xsl:if test="position() &gt; 1">
            <tr>
              <td/>
              <td/>
              <xsl:apply-templates select="."/>
            </tr>
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
    </table>
    <xsl:if test="count(text/body/div)&gt;0">
      <table>
        <xsl:apply-templates select="text/body/div"/>
      </table>
    </xsl:if>
    <xsl:apply-templates select="./teiHeader//msDesc/physDesc/decoDesc"/>
  </xsl:template>

  <xsl:template match="person">
    <td>
      <xsl:apply-templates select="persName"/>
    </td>
    <td>
      * <xsl:apply-templates select="birth"/>
      <xsl:text> </xsl:text>
      + <xsl:apply-templates select="death"/>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="nationality"/>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="occupation"/>
   </td>
  </xsl:template>
  <xsl:template match="nationality">
      <xsl:value-of select="key('CATS',@key)"/>
  </xsl:template>
  <xsl:template match="persName">
    <xsl:text>[</xsl:text>
    <xsl:choose>
      <xsl:when test="../sex=2">female</xsl:when>
      <xsl:otherwise>male</xsl:otherwise>
    </xsl:choose>
    <xsl:text>] </xsl:text>
    <xsl:apply-templates select="foreName"/>
    <xsl:variable name="myName">
      <xsl:apply-templates select="surname"/>
    </xsl:variable>
    <xsl:text> </xsl:text>
      <span class="snm">
	<xsl:value-of select="$myName"/>
      </span>
</xsl:template>

  <xsl:template match="decoDesc">
    <xsl:apply-templates select="p"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:for-each select="decoNote[@type='feature']">
      <xsl:call-template name="splitDecl">
        <xsl:with-param name="decl" select="translate(ptr/@target,'#','')"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="div">
    <xsl:variable name="l" select="@lang"/>
    <tr valign="top">
      <td width="5%">
        <strong>
          <xsl:number/>
        </strong>
      </td>
      <td width="20%">
        <xsl:call-template name="splitDecl">
	  <xsl:with-param name="decl" select="translate(@decls,'#','')"/>
        </xsl:call-template>
        <xsl:value-of select="key('LANGS',$l)"/>
      </td>
      <td width="75%">
        <table class="inscrip">
          <xsl:apply-templates/>
        </table>
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="ab">
    <tr>
      <td>
        <xsl:choose>
          <xsl:when test="@rend='Alignr'">
            <xsl:attribute name="align">right</xsl:attribute>
          </xsl:when>
          <xsl:when test="@rend='Alignc'">
            <xsl:attribute name="align">center</xsl:attribute>
          </xsl:when>
          <xsl:when test="@rend='Alignl'">
            <xsl:attribute name="align">left</xsl:attribute>
            <xsl:text>  </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="align">center</xsl:attribute>
            <xsl:choose>
              <xsl:when test="starts-with(@rend,'indent(')">
                <xsl:attribute name="text-indent">
                  <xsl:value-of select="concat(substring-before(substring-after(@rend,'('),')'),'em')"/>
                </xsl:attribute>
              </xsl:when>
              <xsl:when test="starts-with(@rend,'indent')">
                <xsl:attribute name="text-indent">1em</xsl:attribute>
              </xsl:when>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates/>
      </td>
    </tr>
  </xsl:template>
  <xsl:template name="splitDecl">
    <xsl:param name="decl"/>
    <xsl:choose>
      <xsl:when test="contains($decl,' ')">
	<xsl:variable name="this" select="substring-before($decl,' ')"/>
	<i>
	  <xsl:value-of select="key('CATS',$this)/../@xml:id"/>
	</i>
	<xsl:text>: </xsl:text>
	<xsl:value-of select="key('CATS',$this)/catDesc"/>
	<xsl:text>, </xsl:text>
	<xsl:call-template name="splitDecl">
	  <xsl:with-param name="decl" select="substring-after($decl,' ')"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<i>
	<xsl:value-of  select="key('CATS',$decl)/../@xml:id"/></i>
	<xsl:text>: </xsl:text>
	<xsl:value-of select="key('CATS',$decl)/catDesc"/>.
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="death">
    <xsl:variable name="myYear">
      <xsl:value-of select="substring-before(@when,'-')"/>
    </xsl:variable>
      <span class="yr">
        <xsl:apply-templates select="@when"/>
      </span>

  </xsl:template>
  <xsl:template match="birth">
    <xsl:apply-templates select="@when"/>
  </xsl:template>

  <xsl:function name="xi:types">
    <xsl:param name="code"/>
    <xsl:choose>
<xsl:when test="$code='ARCH'">Arch</xsl:when>
<xsl:when test="$code='BASE'">Base</xsl:when>
<xsl:when test="$code='BATH'">Bath-shape</xsl:when>
<xsl:when test="$code='BLOCK'">Block</xsl:when>
<xsl:when test="$code='BOOK'">Book</xsl:when>
<xsl:when test="$code='BROKE'">Broken</xsl:when>
<xsl:when test="$code='BUILD'">Building</xsl:when>
<xsl:when test="$code='BUST'">Bust</xsl:when>
<xsl:when test="$code='CHES'">Chest</xsl:when>
<xsl:when test="$code='CHEST'">Chest</xsl:when>
<xsl:when test="$code='COL'">Column</xsl:when>
<xsl:when test="$code='COLB'">Broken</xsl:when>
<xsl:when test="$code='COPE'">Coped</xsl:when>
<xsl:when test="$code='CROSS'">Cross</xsl:when>
<xsl:when test="$code='CUSH'">Cushion</xsl:when>
<xsl:when test="$code='FOOT'">Footstone</xsl:when>
<xsl:when test="$code='HEAD'">Headstone</xsl:when>
<xsl:when test="$code='KERB'">Kerb</xsl:when>
<xsl:when test="$code='LAMP'">Lamp</xsl:when>
<xsl:when test="$code='LEDG'">Ledger</xsl:when>
<xsl:when test="$code='OBEL'">Obelisk</xsl:when>
<xsl:when test="$code='OSS'">Ossuary</xsl:when>
<xsl:when test="$code='OTHER'">unique</xsl:when>
<xsl:when test="$code='PED'">Pedestal</xsl:when>
<xsl:when test="$code='PLB'">Plaque on base</xsl:when>
<xsl:when test="$code='PLG'">Plaque in ground</xsl:when>
<xsl:when test="$code='PLW'">Plaque on wall</xsl:when>
<xsl:when test="$code='ROCK'">Rocks</xsl:when>
<xsl:when test="$code='SCRLL'">Scroll</xsl:when>
<xsl:when test="$code='STAT'">Statue</xsl:when>
<xsl:when test="$code='TREE'">Tree</xsl:when>
<xsl:when test="$code='URN'">Urn</xsl:when>
<xsl:when test="$code='VASE'">Urn</xsl:when>
<xsl:when test="$code='WRETH'">Wreath</xsl:when>
<xsl:when test="$code='unknown'">Unknown</xsl:when>
</xsl:choose>

</xsl:function>
</xsl:stylesheet>