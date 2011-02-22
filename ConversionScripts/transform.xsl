<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="tei exsl"
  extension-element-prefixes="exsl" version="1.0"
  xmlns:exsl="http://exslt.org/common" 
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output cdata-section-elements="tei:eg tei:egXML eg egXML" encoding="utf8"
    indent="yes" method="xml" omit-xml-declaration="yes"/>
  <xsl:variable name="ENG">ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz</xsl:variable>
  <xsl:variable name="CYR">АБЦДЕФГХИЙКЛМНОПЯРСТУВЖЬЫЗабцдефгхийклмнопярстужвьыз</xsl:variable>
  <xsl:variable name="GRK">ΑΒΨΔΕΦΓΗΙΞΚΛΜΝΟΠΘΡΣΤΥΣΩΧΥΖαβψδεφγηιξκλμνοπθρστυσωχυζ</xsl:variable>

  <xsl:template match="tei:*">
    <xsl:copy>
      <xsl:apply-templates
        select="*|@*|processing-instruction()|comment()|text()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|processing-instruction()|comment()">
    <xsl:copy/>
  </xsl:template>


<xsl:template match="tei:TEI">
    <xsl:variable name="ident">
      <xsl:value-of select="@xml:id"/>
    </xsl:variable>
    <xsl:message>write <xsl:value-of select="$ident"/></xsl:message>
    <exsl:document         
     method="xml"
     encoding="utf-8"
     omit-doctype-declaration="yes"
     omit-xml-declaration="yes" 
     href="newStones/{$ident}.xml">
      <xsl:copy>
	<xsl:apply-templates select="@*"/>
	<xsl:apply-templates select="tei:*|comment()|processing-instruction()|text()"/>
      </xsl:copy>
    </exsl:document>
</xsl:template>

<xsl:template match="tei:nationality">
  <nationality>
<xsl:choose>
<xsl:when test="@target='#AL'">
  <xsl:attribute name="reg">AL</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#AA'">
  <xsl:attribute name="reg">DZ</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#AM'">
  <xsl:attribute name="reg">US</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#AR'">
  <xsl:attribute name="reg">SA</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#AG'">
  <xsl:attribute name="reg">AR</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#AU'">
  <xsl:attribute name="reg">AU</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#AS'">
  <xsl:attribute name="reg">AT</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#BA'">
  <xsl:attribute name="reg">BB</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#BE'">
  <xsl:attribute name="reg">BE</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#BZ'">
  <xsl:attribute name="reg">BZ</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#BR'">
  <xsl:attribute name="reg">BR</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#GB'">
  <xsl:attribute name="reg">UK</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#BU'">
  <xsl:attribute name="reg">BG</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#CA'">
  <xsl:attribute name="reg">CA</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#CE'">
  <xsl:attribute name="reg">LK</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#CH'">
  <xsl:attribute name="reg">CN</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#CU'">
  <xsl:attribute name="reg">CU</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#CZ'">
  <xsl:attribute name="reg">CZ</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#DA'">
  <xsl:attribute name="reg">DK</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#EG'">
  <xsl:attribute name="reg">EG</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#EN'">
  <xsl:attribute name="reg">UK</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#EL'">
  <xsl:attribute name="reg">UK</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#ES'">
  <xsl:attribute name="reg">EE</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#FI'">
  <xsl:attribute name="reg">FI</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#FR'">
  <xsl:attribute name="reg">FR</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#GE'">
  <xsl:attribute name="reg">DE</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#DE'">
  <xsl:attribute name="reg">DE</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#GI'">
  <xsl:attribute name="reg">GI</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#GR'">
  <xsl:attribute name="reg">GR</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#HO'">
  <xsl:attribute name="reg">NL</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#HU'">
  <xsl:attribute name="reg">HU</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#IN'">
  <xsl:attribute name="reg">IN</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#IR'">
  <xsl:attribute name="reg">IE</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#IT'">
  <xsl:attribute name="reg">IT</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#JA'">
  <xsl:attribute name="reg">JP</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#JV'">
  <xsl:attribute name="reg">ID</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#KE'">
  <xsl:attribute name="reg">KE</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#LA'">
  <xsl:attribute name="reg">LV</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#LE'">
  <xsl:attribute name="reg">LB</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#LI'">
  <xsl:attribute name="reg">LT</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#MA'">
  <xsl:attribute name="reg">MT</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#NE'">
  <xsl:attribute name="reg">NL</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#NZ'">
  <xsl:attribute name="reg">NZ</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#NO'">
  <xsl:attribute name="reg">NO</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#PO'">
  <xsl:attribute name="reg">PL</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#PR'">
  <xsl:attribute name="reg">DE</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#RA'">
  <xsl:attribute name="reg">RO</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#RU'">
  <xsl:attribute name="reg">RU</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#SC'">
  <xsl:attribute name="reg">UK</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#SE'">
  <xsl:attribute name="reg">CS</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#SL'">
  <xsl:attribute name="reg">SI</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#SA'">
  <xsl:attribute name="reg">ZA</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#SW'">
  <xsl:attribute name="reg">SE</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#SS'">
  <xsl:attribute name="reg">CH</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#TA'">
  <xsl:attribute name="reg">TW</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#TN'">
  <xsl:attribute name="reg">TN</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#TU'">
  <xsl:attribute name="reg">TR</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#WE'">
  <xsl:attribute name="reg">UK</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#YU'">
  <xsl:attribute name="reg">CS</xsl:attribute>
</xsl:when>
<xsl:when test="@target='#ZA'">
  <xsl:attribute name="reg">ZM</xsl:attribute>
</xsl:when>
</xsl:choose>
  </nationality>
</xsl:template>

<xsl:template match="tei:foreName">
  <forename>
    <xsl:apply-templates/>
  </forename>
</xsl:template>

<xsl:template match="tei:sourceDesc/tei:p[.='Generated from database records originally']"/>

<xsl:template match="tei:particDesc">
 <xsl:copy>
  <listPerson>
    <xsl:apply-templates/>
  </listPerson>
 </xsl:copy>
</xsl:template>

<xsl:template match="tei:death">
  <death date="{@value}"/>
</xsl:template>

<xsl:template match="tei:birth">
  <xsl:choose>
    <xsl:when test="@value">
      <birth date="{@value}">
	<xsl:apply-templates/>
      </birth>
    </xsl:when>
    <xsl:when test="node()">
      <birth>
	<xsl:apply-templates/>
      </birth>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="tei:death">
  <xsl:if test="@value">
    <death date="{@value}">
      <xsl:apply-templates/>
    </death>
  </xsl:if>
</xsl:template>

<xsl:template match="tei:person">
  <person>
    <xsl:copy-of select="@age"/>
    <xsl:attribute name="sex">
    <xsl:choose>
      <xsl:when test="@sex='m'">1</xsl:when>
      <xsl:when test="@sex='f'">2</xsl:when>
      <xsl:when test="@sex='u'">0</xsl:when>
    </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates/>
  </person>
</xsl:template>

  <xsl:template match="tei:div[@xml:lang='ru']/tei:ab/tei:note">
    <xsl:copy>
      <xsl:attribute name="xml:lang">en</xsl:attribute>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

<!--
  <xsl:template match="tei:div[@xml:lang='ru']/tei:ab//text()">
    <xsl:choose>
      <xsl:when test="parent::tei:note">
        <xsl:value-of select="."/>
      </xsl:when>
      <xsl:when test="../@xml:lang='en'">
        <xsl:value-of select="."/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="translate(.,$ENG,$CYR)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
-->

  <xsl:template 
      match="tei:div[@xml:lang='ru']/tei:ab/@xml:lang[.='en']"> 
  </xsl:template>


  <!--
<xsl:template match="@decls">
  <xsl:attribute name="decls">
    <xsl:call-template name="targs">
      <xsl:with-param name="values">
	<xsl:value-of select="normalize-space(.)"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:attribute>
</xsl:template>

<xsl:template name="targs">
  <xsl:param name="values"/>
  <xsl:choose>
    <xsl:when test="contains($values,' ')">
      <xsl:text>#</xsl:text>
      <xsl:value-of select="substring-before($values,' ')"/>
      <xsl:text> </xsl:text>
      <xsl:call-template name="targs">
	<xsl:with-param name="values">
	  <xsl:value-of select="substring-after($values,' ')"/>
	</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>#</xsl:text>
      <xsl:value-of select="$values"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
-->
</xsl:stylesheet>
