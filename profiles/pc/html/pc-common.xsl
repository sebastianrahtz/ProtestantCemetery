<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="xi tei svg xlink" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
  <xsl:template match="teiCorpus">
    <xsl:call-template name="pcCorpus"/>
  </xsl:template>
  <xsl:template match="teiCorpus" mode="split">
    <xsl:call-template name="pcCorpus"/>
  </xsl:template>
  <xsl:template name="pcCorpus">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <xsl:call-template name="addLangAtt"/>
      <head>
        <title>
          <xsl:apply-templates select="teiHeader/fileDesc/titleStmt/title/text()"/>
        </title>
        <xsl:call-template name="includeCSS"/>
        <xsl:call-template name="make-javascript"/>
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
          <xsl:call-template name="make-display"/>
          <div class="displaystone" id="stone">
            <p>Click on the table entries or map to display stone details here.</p>
          </div>
          <xsl:call-template name="make-map"/>
        </section>
        <xsl:call-template name="stdfooter"/>
      </body>
    </html>
    <xsl:apply-templates select="TEI[not(@type='doc')]"/>
  </xsl:template>
  <xsl:template name="make-javascript">
    <script src="jquery-1.10.2.min.js" type="text/javascript">
      <xsl:comment>brk</xsl:comment>
    </script>
    <script src="jquery-ui-1.10.3.custom.js" type="text/javascript">
      <xsl:comment>brk</xsl:comment>
    </script>
    <script src="jquery.dataTables.min.js" type="text/javascript">
      <xsl:comment>brk</xsl:comment>
    </script>
    <script src="jquery.panzoom.min.js" type="text/javascript">
      <xsl:comment>brk</xsl:comment>
    </script>
    <script src="jquery.svg.min.js" type="text/javascript">
      <xsl:comment>brk</xsl:comment>
    </script>
    <script type="text/javascript" src="cem.js">
      <xsl:comment>brk</xsl:comment>
    </script>
  </xsl:template>
  <xsl:template name="make-display">
    <div class="maindisplay">
      <div id="tabs">
        <ul>
          <li>
            <a href="#cat">Catalogue of people</a>
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
        <div id="cat" class="cat">
          <table class="stones" id="stones">
            <thead>
              <tr>
                <th>Stone</th>
                <th>Tomb</th>
                <th>Form</th>
                <th>Person</th>
                <th>Date of death</th>
                <th>Nationality</th>
                <th/>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="TEI/teiHeader/profileDesc/particDesc/listPerson/person">
                <xsl:sort data-type="number" select="substring(ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno,2)"/>
                <xsl:variable name="id" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
		<xsl:variable name="c" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='tomb']"/>
                <tr>
		  <td>
		    <span title="{$id}" class="{if ($outputTarget='epub3') then
				 'numlinkiframe' else 'numlink'}">
                      <xsl:value-of select="$id"/>
		    </span>
                  </td>
		  <td>
                      <xsl:value-of select="$c"/>
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
                  <td>
                    <a href="{$id}.html">¶</a>
                  </td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </div>
        <div id="summarybynat" class="cat">
          <table class="simplestones">
            <thead>
              <tr>
                <th>Country</th>
                <th>Count</th>
                <th>Stones</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each-group select="TEI/teiHeader/profileDesc/particDesc/listPerson/person" group-by="id(nationality/@key)/catDesc">
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
                      <span class="{if ($outputTarget='epub3') then
				 'numlinkiframe' else 'numlink'}">
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
        <div id="summarybyyr" class="cat">
          <table class="simplestones">
            <thead>
              <tr>
                <th>Year</th>
                <th>Count</th>
                <th>Stones</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each-group select="TEI/teiHeader/profileDesc/particDesc/listPerson/person" group-by="substring(death/@when,1,4)">
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
                      <span class="{if ($outputTarget='epub3') then
				 'numlinkiframe' else 'numlink'}">
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
        <div id="about">
          <xsl:for-each select="TEI[@type='doc']/text/body/div">
            <h1>
              <xsl:call-template name="header"/>
            </h1>
            <xsl:apply-templates/>
          </xsl:for-each>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template name="make-map">
    <div id="map" class="map">
      <div>
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" id="ProtestantCemetery" style="fill: none;" viewBox="19.904121 43.0 3194.056566 1102.158275">
          <g id="map-matrix">
            <xsl:for-each select="doc(resolve-uri('plan.svg',base-uri($TOP)))/svg:svg">
              <xsl:copy-of select="svg:style"/>
              <xsl:copy-of select="svg:g[@id='S0']"/>
            </xsl:for-each>
            <circle cx="-100" cy="-100" id="locatorcircle" r="100" fill-opacity="0.2" fill="green"/>
            <xsl:for-each select="/teiCorpus/TEI">
              <xsl:variable name="id" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
              <xsl:variable name="c" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='tomb']"/>
              <xsl:for-each select="id(concat('Plot_',$id))">
                <g xmlns="http://www.w3.org/2000/svg" class="stone" id="{$id}">
                  <rect x="{@ulx}" y="{@uly}" width="0" height="0"/>
                  <polygon xmlns="http://www.w3.org/2000/svg"
			   class="{if            ($c!='' or graphic[starts-with(@url,'pictures')])            then            'gstone withpic'            else            'gstone'}">
                    <xsl:copy-of select="@points"/>
                  </polygon>
                </g>
              </xsl:for-each>
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
    <xsl:result-document href="{teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno}.html" method="xml">
      <html>
        <xsl:call-template name="addLangAtt"/>
        <xsl:variable name="pagetitle">
          <xsl:choose>
            <xsl:when test="tei:head">
              <xsl:apply-templates select="tei:head" mode="plain"/>
            </xsl:when>
            <xsl:when test="self::tei:TEI">
              <xsl:value-of select="tei:generateTitle(.)"/>
            </xsl:when>
            <xsl:when test="self::tei:text">
              <xsl:value-of select="tei:generateTitle(ancestor::tei:TEI)"/>
              <xsl:value-of select="concat('[',position(),']')"/>
            </xsl:when>
            <xsl:otherwise> </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="tei:htmlHead($pagetitle,21)"/>
        <body>
          <div class="teidiv">
            <xsl:call-template name="stdheader">
              <xsl:with-param name="title">
                <xsl:call-template name="header"/>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="doDivBody"/>
            <xsl:if test="not($outputTarget='epub3')">
	      <xsl:call-template name="stdfooter"/>
	    </xsl:if>
            <xsl:call-template name="bodyEndHook"/>
          </div>
        </body>
      </html>
    </xsl:result-document>
  </xsl:template>
  <xsl:template name="doDivBody">
    <xsl:param name="Depth">0</xsl:param>
    <xsl:param name="nav">false</xsl:param>
    <xsl:choose>
      <xsl:when test="ancestor::TEI/@type='doc'">
        <xsl:call-template name="divContents">
          <xsl:with-param name="Depth" select="$Depth"/>
          <xsl:with-param name="nav" select="$nav"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="id" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
        <xsl:variable name="z" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='zone']"/>
        <xsl:variable name="c" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='tomb']"/>
        <xsl:variable name="f" select=".//objectDesc/@form"/>
        <xsl:variable name="m" select=".//material"/>
        <xsl:variable name="n" select="teiHeader/profileDesc/particDesc/listPerson/person[1]/nationality/@key"/>
        <div id="main">
          <p><xsl:value-of select="$id"/><xsl:text>: </xsl:text><xsl:value-of select="$z"/><xsl:text>: </xsl:text><xsl:value-of select="id($f)/catDesc"/><xsl:text>; </xsl:text><xsl:value-of select="$m"/>.
	    <xsl:value-of select="(.//height,.//width,.//depth)" separator=" x "/></p>
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
	  <div class="pictures">
	    <xsl:for-each select="id(concat('Plot_',$id))/graphic[not(starts-with(@url,'film:'))]">
              <img height="300" src="{@url}"/>
	    </xsl:for-each>
	    <xsl:if test="$c!=''">
              <img height="300" src="http://www.cemeteryrome.it/infopoint/ShowFoto.asp?NTomba={$c}"/>
	    </xsl:if>
	  </div>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="person">
    <tr>
      <td>
        <xsl:apply-templates select="persName"/>
      </td>
      <td><xsl:if test="birth">
	  * <xsl:apply-templates select="birth"/>
	  <xsl:text> </xsl:text>
	</xsl:if>
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
    <tr>
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
            <xsl:attribute name="class">alignright</xsl:attribute>
          </xsl:when>
          <xsl:when test="@rend='Alignc'">
            <xsl:attribute name="class">aligncenter</xsl:attribute>
          </xsl:when>
          <xsl:when test="@rend='Alignl'">
            <xsl:attribute name="class">alignleft</xsl:attribute>
            <xsl:text>  </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="class">aligncenter</xsl:attribute>
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
  <xsl:template name="stdheader">
    <xsl:param name="title">(no title)</xsl:param>
    <xsl:if test="not($outputTarget='epub3')">
      <div id="header">
        <h1 class="maintitle">
          <xsl:copy-of select="$title"/>
        </h1>
      </div>
    </xsl:if>
  </xsl:template>
  <xsl:template name="includeJavascript"/>
  <xsl:template name="javascriptHook"/>
</xsl:stylesheet>
