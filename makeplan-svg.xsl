<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg" 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0"                
>
  
  <xsl:key name="ALL" match="TEI" use="1"/>
  <xsl:key name="SVG" match="svg:g" use="@id"/>

  <xsl:key name="ZONES" match="zone" use="@xml:id"/>  

  <xsl:key name="FORMS" match="objectDesc" use="@form"/>

  <xsl:output method="xhtml" indent="yes"/> 
  
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <title>Protestant Cemetery</title>
  <style type="text/css">
    .panzoom-parent { border: 2px solid #333; }
    .panzoom-parent .panzoom { border: 2px dashed #666; }
    .buttons { margin: 40px 0 0; }
  </style>

  <script src="jquery-1.10.2.min.js" type="text/javascript"><!-- dummy --></script>
  <script src="jquery.panzoom.min.js" type="text/javascript"><!-- dummy --></script>
  <script src="jquery.mousewheel.js"  type="text/javascript"><!-- dummy --></script>
  <script type="text/javascript"><![CDATA[
   $(document).ready(function() {
          var $section = $('.buttons');
	  var $panzoom = $('#ProtestantCemetery').panzoom({
            $zoomIn: $section.find(".zoom-in"),
            $zoomOut: $section.find(".zoom-out"),
            $zoomRange: $section.find(".zoom-range"),
            $reset: $section.find(".reset")});
	  $panzoom.parent().on('mousewheel.focal', function( e ) {
            e.preventDefault();
            var delta = e.delta || e.originalEvent.wheelDelta;
            var zoomOut = delta ? delta < 0 : e.originalEvent.deltaY > 0;
            $panzoom.panzoom('zoom', zoomOut, {
	    increment: 0.1,
	    focal: e
	    });
	    });
	    });
	    ]]>
      </script>

  </head>
  <body>
    <div id="map">
      <svg  
	  xmlns="http://www.w3.org/2000/svg" 
	  xmlns:xlink="http://www.w3.org/1999/xlink"
	  id="ProtestantCemetery" 
	  style='fill: none;'
	  viewBox="19.904121 0.0 3194.056566 1145.158275">
	<g id="map-matrix" transform="matrix(1 0 0 1 0 0)">
	  <xsl:call-template name="outline"/>
	  <xsl:for-each select="key('ALL',1)">
	    <xsl:apply-templates select="ancestor-or-self::TEI"/>
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
  </body>
</html>
  </xsl:template>
  
  <xsl:template name="outline">
    <xsl:for-each select="document('plan.svg')/svg:svg">
      <xsl:copy-of select="svg:style"/>
      <xsl:copy-of select="svg:g[@id='S0']"/>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="TEI">
    <xsl:variable name="id" select="teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
    <g id="{$id}" xmlns="http://www.w3.org/2000/svg">
      <a xlink:href="{$id}.html" xmlns="http://www.w3.org/2000/svg" >
	<polygon xmlns="http://www.w3.org/2000/svg">
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
	</polygon>
      </a>
	<!--
	    <xsl:if test="ancestor-or-self::teiHeader//nationality[@reg='UK']">
	    <text x="{../box/@x}" y="{../box/@y}"
	    style="fill:#000000; font-size:40pt;font-family:sans-serif">
	    <xsl:value-of select="ancestor-or-self::teiHeader//person/persName"/>
	    </text>
	    </xsl:if>
	-->
    </g>
  </xsl:template>
  
</xsl:stylesheet>
