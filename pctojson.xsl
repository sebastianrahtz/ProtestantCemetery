<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="2.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" indent="yes"/>
  <xsl:variable name="top" select="/"/>
  <xsl:variable name="inq">"</xsl:variable>
  <xsl:variable name="outq">\\"</xsl:variable>

  <xsl:template match="/">
    <xsl:message>stones</xsl:message>
    <xsl:text>{ "stones" : [ </xsl:text>
      <xsl:for-each select="//TEI[not(@type='doc')]">
	<xsl:text>{</xsl:text>
        <xsl:sequence
	    select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno,'ID')"/>
        <xsl:sequence select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='zone'],'zone')"/>
        <xsl:sequence select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='tomb'],'tomb')"/>
        <xsl:sequence select="tei:field(.//objectDesc/@form,'form')"/>
        <xsl:sequence select="tei:field(.//material,'material')"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@ulx,'ulx')"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@uly,'uly')"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@lrx,'lrx')"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@lry,'lry')"/>
	<xsl:sequence
	    select="tei:field(.//condition,'condition')"/>
	"persons" : [
	<xsl:for-each select=".//person">
	  <xsl:text> { </xsl:text>
	  <xsl:variable name="s" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
	  <xsl:variable name="n" select="nationality/@key"/>
	  <xsl:variable name="id"><xsl:number level="any"/></xsl:variable>
	  <xsl:sequence select="tei:field(age,'age')"/>
	  <xsl:sequence select="tei:field(sex,'sex')"/>
	  <xsl:sequence select="tei:field(birth/@when,'birth')"/>
	  <xsl:sequence select="tei:field(death/@when,'death')"/>
	  <xsl:sequence select="tei:field($n,'nationality')"/>
	  <xsl:sequence select="tei:field(persName/forename,'forename')"/>
	  <xsl:sequence
	      select="tei:finalfield(persName/surname,'surname')"/>
	  <xsl:text> } </xsl:text>
	  <xsl:if test="position()&lt;last()">
	    <xsl:text>,</xsl:text>
	  </xsl:if>
	</xsl:for-each>
	<xsl:text> ] }</xsl:text>
	<xsl:if test="position()&lt;last()">
	  <xsl:text>,</xsl:text>
	</xsl:if>
	<xsl:text>&#10;</xsl:text>	
      </xsl:for-each>
      ]}
    <xsl:message>inscrips</xsl:message>
    <xsl:result-document href="inscrips.csv" method="text">
      <xsl:text>"inscrip","condition","method","stone"&#10;</xsl:text>
      <xsl:for-each select="//div[@type='inscription']">
	<xsl:number level="any"/>
	<xsl:text>,</xsl:text>
	<xsl:for-each select="tokenize(@decls,' ')">
	  <xsl:if test="starts-with(.,'#c')">
	    <xsl:value-of select="substring(.,4)"/>
	    <xsl:text>,</xsl:text>
	  </xsl:if>
	  <xsl:if test="starts-with(.,'#m')">
	    <xsl:text>"</xsl:text>
	    <xsl:value-of select="substring(.,4)"/>
	    <xsl:text>",</xsl:text>
	  </xsl:if>
	</xsl:for-each>
	<xsl:text>"</xsl:text>
	<xsl:value-of
	    select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>

	<xsl:text>"&#10;</xsl:text>
      </xsl:for-each>
    </xsl:result-document>
<!--
    <xsl:message>lines</xsl:message>
    <xsl:result-document href="lines.csv" method="text">
      <xsl:text>"inscrip","line","text"&#10;</xsl:text>
      <xsl:for-each select="//div[@type='inscription']/ab">
	<xsl:for-each select="parent::div">
	  <xsl:number level="any"/>
	</xsl:for-each>
	<xsl:text>,</xsl:text>
	<xsl:number/>
	<xsl:text>,"</xsl:text>
	<xsl:value-of select="normalize-space(.)"/>
	<xsl:text>"&#10;</xsl:text>
      </xsl:for-each>
    </xsl:result-document>
-->
  </xsl:template>

  <xsl:function name="tei:field">
    <xsl:param name="data"/>
    <xsl:param name="label"/>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="$label"/>
    <xsl:text>": "</xsl:text>
    <xsl:value-of select="replace(normalize-space($data),$inq,$outq)"/>
    <xsl:text>",</xsl:text>
  </xsl:function>
  <xsl:function name="tei:finalfield">
    <xsl:param name="data"/>
    <xsl:param name="label"/>
    <xsl:text>"</xsl:text>
    <xsl:value-of select="$label"/>
    <xsl:text>": "</xsl:text>
    <xsl:value-of select="replace(normalize-space($data),$inq,$outq)"/>
    <xsl:text>"</xsl:text>
  </xsl:function>
</xsl:stylesheet>
