<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml" 
		xmlns:xi="http://www.w3.org/2001/XInclude"
		exclude-result-prefixes="xi tei"
		xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
		xmlns:tei="http://www.tei-c.org/ns/1.0" 
		version="2.0">
  <xsl:import href="/usr/share/xml/tei/stylesheet/html/html.xsl"/>
  <xsl:param name="cellAlign">center</xsl:param>
  <xsl:param name="autoToc"/>
  <xsl:template name="logoPicture"/>
  <xsl:param name="cssFile">cem.css</xsl:param>
  <xsl:param name="institution">Protestant Cemetery catalogue</xsl:param>
  <xsl:param name="department"/>
  <xsl:param name="parentURL">index.html</xsl:param>
  <xsl:param name="parentWords">Protestant Cemetery, Rome</xsl:param>
  <xsl:param name="topNavigationPanel"/>
  <xsl:param name="bottomNavigationPanel"/>
  <xsl:param name="alignNavigationPanel">right</xsl:param>
  <xsl:param name="linkPanel">true</xsl:param>
  <xsl:template name="copyrightStatement">British School at Rome</xsl:template>
  <xsl:key name="nats" match="person" use="nationality/@key"/>
  <xsl:key name="CATS" match="category" use="@xml:id"/>
  <xsl:key name="LANGS" match="language" use="@xml:id"/>
  <xsl:variable name="TOP" select="/"/>
  <xsl:template match="teiCorpus">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <xsl:call-template name="addLangAtt"/>
      <head>
        <title>
          <xsl:apply-templates select="teiHeader/fileDesc/titleStmt/title/text()"/>
        </title>
        <link rel="stylesheet" type="text/css" href="{$cssFile}"/>
	<link type="text/css" rel="stylesheet" href="DataTables-1.9.4/media/css/demo_table.css"/>
	<link type="text/css" rel="stylesheet" href="DataTables-1.9.4/media/css/demo_table_jui.css"/>
	<link type="text/css" rel="stylesheet" href="DataTables-1.9.4/media/css/demo_page.css"/>
	<script src="jquery-1.10.2.min.js" type="text/javascript"/>
	<script src="DataTables-1.9.4/media/js/jquery.dataTables.min.js" type="text/javascript"/>
	<script type="text/javascript">
	  var fuzzyNum = function (x) {
	  return +x.replace(/[^\d\.\-]/g, "");
	  }; 
	  
	  jQuery.fn.dataTableExt.oSort['prettynumbers-asc'] = function(x, y) {
	  return fuzzyNum(x) - fuzzyNum(y);
	  };   
	  jQuery.fn.dataTableExt.oSort['prettynumbers-desc'] = function(x, y) {
	  return fuzzyNum(y) - fuzzyNum(x);
	  };
	  $(document).ready(function() {
	  $('table.stones').dataTable( {
	  "sPaginationType": "full_numbers",
	  "bPaginate": true,
	  "bLengthChange": true,
	  "bFilter": true,
	  "bSort": true,
	  "bInfo": true,
	  "aoColumns": [ { "sType": [ "prettynumbers" ] }, null,null,null,null ],
	  "bScrollCollapse": true,
	  "bAutoWidth": false,
	  "bJQueryUI": true,
	  "sDom": 'flprtip',
	  "aoColumnDefs": [
	  { "sWidth": "10%", "aTargets": [ 0 ] },
	  { "sWidth": "15%", "aTargets": [ 1 ] },
	  { "sWidth": "30%", "aTargets": [ 2 ] },
	  { "sWidth": "15%", "aTargets": [ 3 ] },
	  { "sWidth": "25%", "aTargets": [ 4 ] }
	  ]  
	  } );
	  });
	</script>
      </head>
      <body>
        <xsl:call-template name="bodyHook"/>
        <xsl:call-template name="bodyJavascriptHook"/>
        <xsl:call-template name="stdheader">
          <xsl:with-param name="title">
            <xsl:apply-templates select="teiHeader/fileDesc/titleStmt/title"/>
          </xsl:with-param>
        </xsl:call-template>
	<div>
	<table class="stones" id="stones">
	  <thead>
	    <tr>
	      <th>Gravestone</th>
	      <th>Form</th>
	      <th>Person</th>
	      <th>Date of death</th>
	      <th>Nationality</th>
	    </tr>
	  </thead>
	  <tbody>
	<xsl:for-each
	    select="TEI/teiHeader/profileDesc/particDesc/listPerson/person">
	  <xsl:sort select="persName/surname"/>
	  <xsl:sort select="death/@when"/>
	  <xsl:variable name="id" select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
	  <tr>
	    <td>	<a href="{$id}.html"><xsl:value-of select="substring($id,2)"/></a></td>
	    <td>	<xsl:value-of select="xi:lookup(ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/physDesc/objectDesc/@form)"/></td>
	    <td>	<xsl:value-of select="persName/surname"/>, 	<xsl:value-of select="persName/forename"/></td>
	    <td>	<xsl:value-of select="death/@when"/></td>
	    <td>	<xsl:value-of select="xi:lookup(nationality/@key)"/></td>
	  </tr>
	</xsl:for-each>
	  </tbody>
	</table>
	</div>
        <xsl:call-template name="stdfooter"/>
      </body>
    </html>
    <xsl:apply-templates select="TEI"/>
  </xsl:template>

  <xsl:template name="stdfooter">
    <div class="footer">
    <hr/>
      <p>Generated on <xsl:sequence select="tei:generateDate(.)"/></p>
    </div>
  </xsl:template>
  <xsl:template match="TEI">
    <xsl:result-document href="{teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno}.html" method="xhtml">
      <xsl:call-template name="writeDiv"/>
    </xsl:result-document>
  </xsl:template>


  <xsl:template name="doDivBody">
    <xsl:param name="Depth">0</xsl:param>
    <xsl:param name="nav">false</xsl:param>
    <xsl:variable name="id" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
    <xsl:variable name="z" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno"/>
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
	  <xsl:value-of select="(.//height,.//width,.//depth)"
			separator=" x "/>
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
    <xsl:apply-templates
	select="./teiHeader//msDesc/physDesc/decoDesc"/>
    <xsl:for-each
	select="id(concat('Plot_',$id))/graphic[not(starts-with(@url,'film:'))]">
      <div><img height="300" src="{@url}"/></div>
    </xsl:for-each>
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
    <xsl:apply-templates select="forename"/>
    <xsl:variable name="myName">
      <xsl:apply-templates select="surname"/>
    </xsl:variable>
    <xsl:text> </xsl:text>
      <span class="snm">
	<xsl:value-of select="$myName"/>
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

  <xsl:template match="div">
    <xsl:variable name="l" select="@lang"/>
    <tr valign="top">
      <td width="5%">
        <strong>
          <xsl:number/>
        </strong>
      </td>
      <td width="20%">
        <xsl:for-each select="tokenize(@decls,' ')">
	  <xsl:sequence select="tei:showDecl(substring(.,2))"/>
	</xsl:for-each>
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

  <xsl:function name="tei:showDecl">
    <xsl:param name="decl"/>
    <xsl:variable name="thing">
      <xsl:for-each select="$TOP">
	<i>
	  <xsl:value-of  select="key('CATS',$decl)/../@xml:id"/>
	</i>
	<xsl:text>: </xsl:text>
	<xsl:value-of select="key('CATS',$decl)/catDesc"/>.
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

  <xsl:function name="xi:lookup">
    <xsl:param name="code"/>
    <xsl:value-of select="$TOP/teiCorpus/teiHeader/encodingDesc/classDecl/taxonomy/category[@xml:id=$code]/catDesc"/>
  </xsl:function>


</xsl:stylesheet>
