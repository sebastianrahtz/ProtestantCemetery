<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg" 
    xmlns="http://www.w3.org/2000/svg" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0"                
>
  
  <xsl:key name="SVG" match="svg:g" use="@id"/>

  <xsl:key name="ZONES" match="zone" use="@xml:id"/>  

  <xsl:key name="FORMS" match="objectDesc" use="@form"/>

  <xsl:output method="xml" indent="yes"/> 
  
  <xsl:template match="/">
    <svg  
	xmlns="http://www.w3.org/2000/svg" 
	xmlns:xlink="http://www.w3.org/1999/xlink"
	id="ProtestantCemetery" 
	style='fill: none;'
	viewBox="19.904121 0.0 3194.056566 1145.158275">
      <xsl:call-template name="outline"/>
      <xsl:for-each select="key('FORMS','CROSS')">
	<xsl:apply-templates select="ancestor::TEI"/>
      </xsl:for-each>
    </svg>
  </xsl:template>
  
  <xsl:template name="outline">
    <xsl:for-each select="document('plan.svg')/svg:svg">
      <xsl:copy-of select="svg:style"/>
      <xsl:copy-of select="svg:g[@id='S0']"/>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="TEI">
    <xsl:variable name="id" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
    <svg:g id="{$id}">
      <a xlink:href="{$id}.html">
	<svg:polygon>
	  <xsl:for-each select="key('ZONES',concat('Plot_',$id))">
	    <xsl:copy-of select="@points"/>
	  </xsl:for-each>
	  <xsl:for-each select="teiHeader//person[1]//death">
	    <xsl:variable name="code">
	      <xsl:text>decade_</xsl:text>
	      <xsl:value-of select="substring(ancestor::teiHeader//person[1]//death/@when,1,3)"/>
	    </xsl:variable>
	    <xsl:attribute name="style">
	      <xsl:text>fill:rgb(</xsl:text>
	      <xsl:value-of  select="document('colorsrgb.xml')/colorcodes/color[@id=$code]"/>
	      <xsl:text>)</xsl:text>
	    </xsl:attribute>
	  </xsl:for-each>
	</svg:polygon>
      </a>
	<!--
	    <xsl:if test="ancestor-or-self::teiHeader//nationality[@reg='UK']">
	    <svg:text x="{../box/@x}" y="{../box/@y}"
	    style="fill:#000000; font-size:40pt;font-family:sans-serif">
	    <xsl:value-of select="ancestor-or-self::teiHeader//person/persName"/>
	    </svg:text>
	    </xsl:if>
	-->
    </svg:g>
  </xsl:template>
  
</xsl:stylesheet>
