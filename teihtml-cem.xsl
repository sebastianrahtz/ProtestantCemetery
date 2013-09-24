<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="xi tei svg xlink" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
  <xsl:import href="/usr/share/xml/tei/stylesheet/html5/html5.xsl"/>
  <xsl:param name="cellAlign">center</xsl:param>
  <xsl:param name="cssFile">cem.css</xsl:param>
  <xsl:param name="institution"/>
  <xsl:param name="department"/>
  <xsl:param name="parentURL">index.html</xsl:param>
  <xsl:param name="parentWords"/>
  <xsl:param name="topNavigationPanel"/>
  <xsl:param name="bottomNavigationPanel"/>
  <xsl:param name="alignNavigationPanel">right</xsl:param>
  <xsl:param name="linkPanel">true</xsl:param>
  <xsl:template name="copyrightStatement">British School at Rome</xsl:template>
  <xsl:variable name="TOP" select="/"/>
  <xsl:template name="logoPicture"/>
  <xsl:template match="teiCorpus">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <xsl:call-template name="addLangAtt"/>
      <head>
        <title>
          <xsl:apply-templates select="teiHeader/fileDesc/titleStmt/title/text()"/>
        </title>
	<link rel="stylesheet" type="text/css" href="jquery-ui-1.10.3.custom.css"/>
        <link type="text/css" rel="stylesheet" href="DataTables-1.9.4/media/css/demo_table.css"/>
        <link type="text/css" rel="stylesheet" href="DataTables-1.9.4/media/css/demo_table_jui.css"/>
        <link type="text/css" rel="stylesheet" href="DataTables-1.9.4/media/css/demo_page.css"/>
        <link rel="stylesheet" type="text/css" href="cem.css"/>
        <script src="jquery-1.10.2.min.js" type="text/javascript">
          <xsl:comment>brk</xsl:comment>
        </script>
        <script src="jquery-ui-1.10.3.custom.js" type="text/javascript">
          <xsl:comment>brk</xsl:comment>
        </script>
        <script src="DataTables-1.9.4/media/js/jquery.dataTables.min.js" type="text/javascript">
          <xsl:comment>brk</xsl:comment>
        </script>
        <script src="jquery.panzoom.min.js" type="text/javascript">
          <xsl:comment>brk</xsl:comment>
        </script>
        <!--
	    <script src="jquery.mousewheel.js" type="text/javascript"><xsl:comment>brk</xsl:comment></script>
	-->
        <script type="text/javascript" src="cem.js">
          <xsl:comment>brk</xsl:comment>
        </script>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      </head>
      <body>
        <xsl:call-template name="bodyHook"/>
        <xsl:call-template name="bodyJavascriptHook"/>
        <xsl:call-template name="stdheader">
          <xsl:with-param name="title">
            <xsl:apply-templates select="teiHeader/fileDesc/titleStmt/title"/>
          </xsl:with-param>
        </xsl:call-template>

        <section>
          <div id="tabs">
            <ul>
              <li>
                <a href="#cat">Catalogue of people</a>
              </li>
              <li>
                <a href="#map">Map of cemetery</a>
              </li>
              <li>
                <a href="#summarybynat">Summary by country</a>
              </li>
              <li>
                <a href="#summarybyyr">Summary by year</a>
              </li>
              <li>
                <a href="#about">About</a>
              </li>
            </ul>
            <div id="cat">
	      <div class="cat">
              <table class="stones" id="stones">
                <thead>
                  <tr>
                    <th>Grave</th>
                    <th>Form</th>
                    <th>Person</th>
                    <th>Date of death</th>
                    <th>Nationality</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="TEI/teiHeader/profileDesc/particDesc/listPerson/person">
                    <xsl:sort select="persName/surname"/>
                    <xsl:sort select="death/@when"/>
                    <xsl:variable name="id" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
                    <tr>
                      <td>
                        <span class="numlink">
                          <xsl:value-of select="$id"/>
                        </span>
                      </td>
                      <td>
                        <xsl:value-of select="id(ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/physDesc/objectDesc/@form)/catDesc"/>
                      </td>
                      <td>
                        <xsl:variable name="myName">
                          <xsl:value-of select="persName/surname"/>
                          <xsl:text>, </xsl:text>
                          <xsl:value-of select="persName/forename"/>
                        </xsl:variable>
                        <xsl:value-of select="if ($myName=', ') then        '[unknown]' else $myName "/>
                      </td>
                      <td>
                        <xsl:value-of select="death/@when"/>
                      </td>
                      <td>
                        <xsl:value-of select="id(nationality/@key)/catDesc"/>
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </div>
            <div class="displaystone" id="stonebycat">
	      <p></p>
	    </div>
	  </div>

	  <div id="map">
            <div class="displaystone" id="stonebymap">
	      <p></p>
	    </div>
	    <div class="cat">
	    <div class="map">
              <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" id="ProtestantCemetery" style="fill: none;" viewBox="19.904121 43.0 3194.056566 1102.158275">
                <g id="map-matrix" transform="matrix(1 0 0 1 0 0)">
                  <xsl:for-each select="document('plan.svg')/svg:svg">
                    <xsl:copy-of select="svg:style"/>
                    <xsl:copy-of select="svg:g[@id='S0']"/>
                  </xsl:for-each>
                  <xsl:for-each select="/teiCorpus/TEI">
                    <xsl:variable name="id" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
                    <g xmlns="http://www.w3.org/2000/svg" class="gstone" id="{$id}">
                      <polygon xmlns="http://www.w3.org/2000/svg" style="fill:F5FCFF">
                        <xsl:for-each select="id(concat('Plot_',$id))">
                          <xsl:copy-of select="@points"/>
                        </xsl:for-each>
                        <!--   
			   <xsl:for-each select="teiHeader//person[1]//death">
			   <xsl:variable name="code">
			   <xsl:text>decade_</xsl:text>
			   <xsl:value-of select="substring(ancestor::teiHeader//person[1]//death/@when,1,3)"/>
			   </xsl:variable>
			   <xsl:attribute name="style">
                          <xsl:text>fill:rgb(</xsl:text>
                          <xsl:value-of select="document('colorsrgb.xml')/colorcodes/color[@id=$code]"/>
                          <xsl:text>)</xsl:text>
                        </xsl:attribute>
                      </xsl:for-each>
		      -->
                      </polygon>
                    </g>
                  </xsl:for-each>
                </g>
              </svg>
            </div>
            <div class="buttons">
              <button class="zoom-in">Zoom In</button>
              <button class="zoom-out">Zoom Out</button>
              <input type="range" class="zoom-range"/>
              <button class="reset">Reset</button>
            </div>
	    </div>
	  </div>

	  <div id="summarybynat">
	    <div class="cat">

              <table class="simplestones">
                <thead>
                  <tr>
                    <th>Country</th>
                    <th>Count</th>
                    <th>Stones</th>
                  </tr>
                </thead>
                <tbody>

		<xsl:for-each-group
		    select="TEI/teiHeader/profileDesc/particDesc/listPerson/person"
		    group-by="id(nationality/@key)/catDesc">
		    <xsl:sort select="id(nationality/@key)/catDesc"/>
		  <tr>
		    <td>
		      <xsl:value-of select="current-grouping-key()"/>
		    </td>
		    <td>
		      <xsl:value-of select="count(current-group())"/>
		    </td>
		    <td>
		      <xsl:for-each select="current-group()">
			<xsl:variable name="id" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
			<span class="numlink2">
			  <xsl:value-of select="$id"/>
			</span>
			<xsl:text> </xsl:text>
		      </xsl:for-each>
		    </td>
		  </tr>
		</xsl:for-each-group>
		</tbody>
	      </table>

	    </div>
	      <div class="displaystone" id="stonebynat">
		<p></p>
	      </div>
	  </div>
	  <div id="summarybyyr">
	    <div class="cat">

              <table class="simplestones">
                <thead>
                  <tr>
                    <th>Year</th>
                    <th>Count</th>
                    <th>Stones</th>
                  </tr>
                </thead>
                <tbody>

		<xsl:for-each-group
		    select="TEI/teiHeader/profileDesc/particDesc/listPerson/person"
		    group-by="substring(death/@when,1,4)">
		    <xsl:sort select="substring(death/@when,1,4)"/>
		  <tr>
		    <td>
		      <xsl:value-of select="current-grouping-key()"/>
		    </td>
		    <td>
		      <xsl:value-of select="count(current-group())"/>
		    </td>
		    <td>
		      <xsl:for-each select="current-group()">
			<xsl:variable name="id" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
			<span class="numlink3">
			  <xsl:value-of select="$id"/>
			</span>
			<xsl:text> </xsl:text>
		      </xsl:for-each>
		    </td>
		  </tr>
		</xsl:for-each-group>
		</tbody>
	      </table>

	    </div>

	      <div class="displaystone" id="stonebyyr">
		<p></p>
	      </div>
	  </div>
	  <div id="about">
	    <xsl:for-each select="TEI[@type='doc']/text/body/div">
	      <h1><xsl:call-template name="header"/></h1>
	      <xsl:apply-templates/>
	    </xsl:for-each>
	  </div>
	</div>
        </section>
        <script type="text/javascript">	  
	$( "g.gstone" ).click(function() {
	    $("#stonebymap").load($(this).attr('id') + ".html #main");
	});
	$( "span.maplink" ).click(function() {
	alert("show " + $this.text() + " on map");
	});
	</script>
        <xsl:call-template name="stdfooter"/>
      </body>
    </html>
    <xsl:apply-templates select="TEI[not(@type='doc')]"/>
  </xsl:template>
  <xsl:template name="stdfooter">
    <div class="footer">
      <hr/>
      <xsl:call-template name="menu"/>
      <p>Prepared by Sebastian Rahtz, University of Oxford IT Services</p>
      <p>Generated on <xsl:sequence select="tei:generateDate(.)"/></p>
    </div>
  </xsl:template>
  <xsl:template match="TEI[not(@type='doc')]">
    <xsl:result-document href="{teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno}.html" method="xhtml">
      <xsl:call-template name="writeDiv"/>
    </xsl:result-document>
  </xsl:template>
  <xsl:template name="doDivBody">
    <xsl:param name="Depth">0</xsl:param>
    <xsl:param name="nav">false</xsl:param>
    <xsl:choose>
<xsl:when  test="ancestor::TEI/@type='doc'">
	    <xsl:call-template name="divContents">
	      <xsl:with-param name="Depth" select="$Depth"/>
	      <xsl:with-param name="nav" select="$nav"/>
	    </xsl:call-template>
</xsl:when>
<xsl:otherwise>
    <xsl:variable name="id" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
    <xsl:variable name="z" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno"/>
    <xsl:variable name="f" select=".//objectDesc/@form"/>
    <xsl:variable name="m" select=".//material"/>
    <xsl:variable name="n" select="teiHeader/profileDesc/particDesc/listPerson/person[1]/nationality/@key"/>
    <div id="main">
      <p><xsl:value-of select="$z"/><xsl:text>;  	</xsl:text><xsl:value-of select="id($f)/catDesc"/><xsl:text>;  </xsl:text><xsl:value-of select="$m"/>.
	  <xsl:value-of select="(.//height,.//width,.//depth)"
			separator=" x "/>
      <span class="maplink"><xsl:value-of select="$id"/></span>
      </p>
      <hr/>
      <table class="people">
        <xsl:apply-templates select="teiHeader/profileDesc/particDesc/listPerson/person"/>
      </table>
      <xsl:if test="count(text/body/div)&gt;0">
        <hr/>
        <table>
          <xsl:apply-templates select="text/body/div"/>
        </table>
      </xsl:if>
      <xsl:apply-templates select="teiHeader//msDesc/physDesc/decoDesc"/>
      <xsl:for-each select="id(concat('Plot_',$id))/graphic[not(starts-with(@url,'film:'))]">
        <div>
          <img height="300" src="{replace(@url,'pictures/','webpictures/')}"/>
        </div>
      </xsl:for-each>
    </div>
</xsl:otherwise>
</xsl:choose>
  </xsl:template>
  <xsl:template match="person">
    <tr>
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
    </tr>
  </xsl:template>
  <xsl:template match="nationality">
    <xsl:value-of select="id(@key)"/>
  </xsl:template>
  <xsl:template match="persName">
    <xsl:text>[</xsl:text>
    <xsl:choose>
      <xsl:when test="../sex=2">female</xsl:when>
      <xsl:when test="../sex=1">male</xsl:when>
      <xsl:otherwise>?</xsl:otherwise>
    </xsl:choose>
    <xsl:text>] </xsl:text>
    <xsl:variable name="myName">
      <xsl:value-of select="forename"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="surname"/>
    </xsl:variable>
    <span class="name">
      <xsl:value-of select="if ($myName=' ') then '[unknown]' else $myName "/>
    </span>
  </xsl:template>
  <xsl:template match="decoDesc">
    <xsl:apply-templates select="summary"/>
    <xsl:for-each select="decoNote[@type='feature']/ptr">
      <xsl:for-each select="tokenize(@target,' ')">
        <xsl:sequence select="tei:showDecl(substring(.,2))"/>
      </xsl:for-each>
      <br/>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="summary">
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="div[@type='inscription']">
    <xsl:variable name="l" select="@lang"/>
    <tr valign="top">
      <td class="num">
        <strong>
          <xsl:number/>
        </strong>
      </td>
      <td>
        <xsl:for-each select="tokenize(@decls,' ')">
          <xsl:sequence select="tei:showDecl(substring(.,2))"/>
        </xsl:for-each>
        <xsl:value-of select="id($l)"/>
      </td>
    </tr>
    <tr>
      <td> </td>
      <td>
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
  <xsl:function name="tei:showDecl">
    <xsl:param name="decl"/>
    <xsl:variable name="thing">
      <xsl:for-each select="$TOP"><i><xsl:value-of select="id($decl)/../@xml:id"/></i><xsl:text>: </xsl:text><xsl:value-of select="id($decl)/catDesc"/>.
      </xsl:for-each>
    </xsl:variable>
    <xsl:copy-of select="$thing"/>
  </xsl:function>
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
  <xsl:template name="menu">
    <nav>
      <span class="toc">
        <a href="http://www.cemeteryrome.it/index.html">Cemetery
      web site</a>
      </span>
    </nav>
  </xsl:template>

</xsl:stylesheet>
