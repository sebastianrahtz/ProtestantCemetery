<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="2.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"/>
      <xsl:variable name="top" select="/"/>

  <xsl:template match="/">
    <xsl:message>persons</xsl:message>
    <xsl:result-document href="person.csv" method="text">
<xsl:text>"person","age","sex","birth","death","nationality","forename","surname","occupation","stone"&#10;</xsl:text>
      <xsl:for-each select="//person">
        <xsl:variable name="s" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
        <xsl:variable name="n" select="nationality/@key"/>
	<xsl:variable name="id"><xsl:number level="any"/></xsl:variable>
	<xsl:sequence select="tei:field($id,false())"/>
	<xsl:sequence select="tei:field(age,false())"/>
	<xsl:sequence select="tei:field(sex,false())"/>
	<xsl:sequence select="tei:field(birth/@when,true())"/>
	<xsl:sequence select="tei:field(death/@when,true())"/>
	<xsl:sequence select="tei:field($n,true())"/>
	<xsl:sequence select="tei:field(persName/forename,true())"/>
	<xsl:sequence select="tei:field(persName/surname,true())"/>
	<xsl:sequence select="tei:field(occupation,true())"/>
	<xsl:text>"</xsl:text>
	<xsl:value-of select="$s"/>
	<xsl:text>"&#10;</xsl:text>
      </xsl:for-each>
    </xsl:result-document>
    <xsl:message>stones</xsl:message>
    <xsl:result-document href="stones.csv" method="text">
      <xsl:text>"stone","zone","tomb","form","material","ulx","uly","lrx","lry","condition"&#10;</xsl:text>
      <xsl:for-each select="//TEI[not(@type='doc')]">
        <xsl:sequence select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno,true())"/>
        <xsl:sequence select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='zone'],true())"/>
        <xsl:sequence select="tei:field(teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='tomb'],false())"/>
        <xsl:sequence select="tei:field(.//objectDesc/@form,true())"/>
        <xsl:sequence select="tei:field(.//material,true())"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@ulx,false())"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@uly,false())"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@lrx,false())"/>
	<xsl:sequence select="tei:field(facsimile/surface/zone[1]/@lry,false())"/>
	<xsl:text>"</xsl:text>
	<xsl:value-of select=".//condition"/>
	<xsl:text>"&#10;</xsl:text>
      </xsl:for-each>
    </xsl:result-document>
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
  </xsl:template>

  <xsl:function name="tei:field">
    <xsl:param name="data"/>
    <xsl:param name="text"/>
    <xsl:if test="$text">"</xsl:if>
    <xsl:value-of select="$data"/>
    <xsl:if test="$text">"</xsl:if>
    <xsl:text>,</xsl:text>
  </xsl:function>
</xsl:stylesheet>
