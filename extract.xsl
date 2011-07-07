<?xml version='1.0'?>
<xsl:stylesheet 
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" >


<xsl:output method="text"/>

<xsl:key name="P" match="unlock" use="@key"/>
<xsl:key name="CATS" match="category" use="@id"/>
<xsl:key name="LANGS" match="language" use="@id"/>

<xsl:template match="/">
  <xsl:text>"Stone","Person","Forename","Surname","Age","Sex","Birthdate","Birth place","Geonames ID","lat","long","Birth Country","Nationality","Gravestone type"&#10;</xsl:text>
<xsl:for-each
   select=".//person[birth/placeName]" >
  <xsl:text>"</xsl:text>
  <xsl:value-of select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
  <xsl:text>","</xsl:text>
  <xsl:number/>
  <xsl:text>",</xsl:text>
  <xsl:value-of select="persName/forename"/>
  <xsl:text>","</xsl:text>
  <xsl:value-of select="persName/surname"/>
  <xsl:text>","</xsl:text>
  <xsl:value-of select="age"/>
  <xsl:text>","</xsl:text>
  <xsl:value-of select="sex"/>
  <xsl:text>","</xsl:text>
  <xsl:value-of select="birth/@when"/>
  <xsl:text>","</xsl:text>
  <xsl:value-of select="normalize-space(birth/placeName/settlement)"/>
  <xsl:text>","</xsl:text>
  <xsl:variable name="p">
  <xsl:value-of select="translate(normalize-space(birth/placeName/settlement),' ','-')"/>
  </xsl:variable>
  <xsl:for-each select="document('places.xml')">
    <xsl:choose>
      <xsl:when test="key('P',$p)">
	<xsl:for-each select="key('P',$p)">
	  <xsl:value-of select="feature[1]/identifier"/>
	  <xsl:text>","</xsl:text>
	  <xsl:value-of select="substring-before(feature[1]/centroid,',')"/>
	  <xsl:text>","</xsl:text>
	  <xsl:value-of select="substring-after(feature[1]/centroid,',')"/>
	  <xsl:text>",</xsl:text>
	</xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>","","</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
  <xsl:text>","</xsl:text>
  <xsl:value-of select="normalize-space(birth/placeName/country)"/>
  <xsl:text>","</xsl:text>
  <xsl:value-of select="nationality/@key"/>
  <xsl:text>","</xsl:text>
  <xsl:value-of select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/physDesc/objectDesc/@form"/>
  <xsl:text>"&#10;</xsl:text>
</xsl:for-each>
</xsl:template>
</xsl:stylesheet>
