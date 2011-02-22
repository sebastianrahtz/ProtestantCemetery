<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="2.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:key name="IDS" use="@xml:id" match="*"/>
  <xsl:key name="LOCATIONS" match="location" use="1"/>

  <xsl:output cdata-section-elements="eg egXML" 
	      encoding="utf8"
	      indent="yes" 
	      method="xml" 
	      omit-xml-declaration="yes"/>

  <xsl:template match="TEI/@xml:id"/>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates
        select="*|@*|processing-instruction()|comment()|text()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|processing-instruction()|comment()">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="teiCorpus">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="teiHeader"/>
      <facsimile>
	<surface ulx="0" uly="1100" lrx="3200" lry="0">
	  <xsl:for-each select="key('LOCATIONS',1)">
	    <zone xml:id="Plot_{ancestor::TEI/@xml:id}">
	      <xsl:for-each select="box">
		<xsl:attribute name="ulx" select="number(@x)"/>
		<xsl:attribute name="uly" select="number(@y) + number(@height)"/>
		<xsl:attribute name="lrx" select="number(@x) + number(@width)"/>
		<xsl:attribute name="lry" select="number(@y)"/>
	      </xsl:for-each>
	      <xsl:attribute name="points" select="polygon/@points"/>
	    <xsl:for-each select="ancestor::stoneDescription/history/surrogates">
	      <xsl:apply-templates/>
	    </xsl:for-each>
	    </zone>
	  </xsl:for-each>
	</surface>
      </facsimile>
      <xsl:apply-templates select="TEI"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="stoneDescription">
    <msDesc facs="#Plot_{ancestor::TEI/@xml:id}">
      <msIdentifier>
	<idno><xsl:value-of select="ancestor::TEI/@xml:id"/></idno>
	<altIdentifier>
	  <idno type="zone">
	    <xsl:call-template name="lookup">
	      <xsl:with-param name="key"
			      select="substring-after(location/zone/@target,'#')"/>
	    </xsl:call-template>
	  </idno>
	  <xsl:apply-templates select="location/plot"/>
	</altIdentifier>
      </msIdentifier>
      <physDesc>
	<objectDesc form="{substring-after(physicalDescription/form/@target,'#')}">
	  <supportDesc>
	    <support>
	      <material>
		<xsl:call-template name="lookup">
		  <xsl:with-param name="key"
				  select="substring-after(physicalDescription/material/@target,'#')"/>
		</xsl:call-template>
	      </material>
	    </support>
	    <extent><num><xsl:value-of select="physicalDescription/numElements"/></num>
	    <dimensions unit="cm">
	      <xsl:apply-templates
		  select="physicalDescription/dimensions/height"/>
	      <xsl:apply-templates
		  select="physicalDescription/dimensions/breadth"/>
	      <xsl:apply-templates
		  select="physicalDescription/dimensions/width"/>
	      <xsl:apply-templates
		  select="physicalDescription/dimensions/diam"/>
	    </dimensions>
	    </extent>
	    <condition>
		<xsl:call-template name="lookup">
		  <xsl:with-param name="key"
				  select="substring-after(physicalDescription/condition/@target,'#')"/>
		</xsl:call-template>
	    </condition>
	  </supportDesc>
            </objectDesc>
	    <xsl:for-each select="physicalDescription">
		<xsl:choose>
		  <xsl:when test="faces or decoration/feature[p]">
		    <decoDesc>
		      <xsl:if test="decoration/feature[p]">
			<summary>
			  <xsl:value-of  select="decoration/p"/>
			</summary>
		      </xsl:if>
		      <xsl:for-each select="decoration/feature">
			<decoNote type="feature"><num><xsl:value-of select="@occs"/></num><ptr target="{@decls}"/></decoNote>
		      </xsl:for-each>
		      <xsl:if test="faces">
			<decoNote type="faces">
			  <xsl:call-template name="lookup">
			    <xsl:with-param name="key" select="substring-after(faces/@target,'#')"/>
			  </xsl:call-template>
			</decoNote>
		      </xsl:if>
		    </decoDesc>
		  </xsl:when>
		  <xsl:when test="decoration/p">
		    <decoDesc>
		      <p>
			<xsl:value-of select="decoration/p"/>
		      </p>
		    </decoDesc>
		  </xsl:when>
		</xsl:choose>
	    </xsl:for-each>
          </physDesc>

        </msDesc>
</xsl:template>

<xsl:template match="photo">
  <graphic url="film/{translate(@film,'*','_')}/{@neg}">
    <xsl:if test="string-length(.)&gt;0">
      <desc><xsl:apply-templates/></desc>
    </xsl:if>
  </graphic>
</xsl:template>

<xsl:template match="TEI/teiHeader">
  <xsl:copy>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates
	select="*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="TEI">
    <xsl:variable name="ident">
      <xsl:value-of select="@xml:id"/>
    </xsl:variable>
    <!--    <xsl:message>write <xsl:value-of select="$ident"/></xsl:message>-->
    <include xmlns="http://www.w3.org/2001/XInclude" href="newStones/{@xml:id}.xml"/>
    <xsl:result-document         
	method="xml"
	encoding="utf-8"
	omit-xml-declaration="yes" 
	href="newStones/{$ident}.xml">
      <xsl:copy>
	<xsl:apply-templates select="@*"/>
	<xsl:apply-templates select="*|comment()|processing-instruction()|text()"/>
      </xsl:copy>
    </xsl:result-document>
</xsl:template>

<xsl:template match="@age">
  <age><xsl:value-of select="."/></age>
</xsl:template>

<xsl:template match="@sex">
  <sex><xsl:value-of select="."/></sex>
</xsl:template>

<xsl:template match="death/@date">
  <xsl:attribute name="when">
    <xsl:value-of select="."/>
  </xsl:attribute>
</xsl:template>

<xsl:template match="birth/@date">
  <xsl:attribute name="when">
    <xsl:value-of select="."/>
  </xsl:attribute>
</xsl:template>

<xsl:template match="breadth">
  <depth>
    <xsl:value-of select="."/>
  </depth>
</xsl:template>

<xsl:template match="diam">
  <dim type="diameter">
    <xsl:value-of select="."/>
  </dim>
</xsl:template>

<xsl:template match="plot">
  <xsl:if test="not(normalize-space(.)='')">
    <note>
      <xsl:value-of select="."/>
    </note>
  </xsl:if>
</xsl:template>

<xsl:template match="nationality/@reg">
  <xsl:attribute name="key">
    <xsl:value-of select="."/>
  </xsl:attribute>
</xsl:template>

<xsl:template name="lookup">
  <xsl:param name="key"/>
  <xsl:for-each select="document('cem.xml')">
    <xsl:for-each select="key('IDS',$key)">
      <xsl:value-of select="catDesc"/>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>


</xsl:stylesheet>
