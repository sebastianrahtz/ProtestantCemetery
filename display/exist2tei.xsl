<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:exist="http://exist.sourceforge.net/NS/exist" 
  version="1.0"
>
<xsl:output method="xml" indent="yes"/>
<xsl:param name="query"></xsl:param>
<xsl:param name="delivery">both</xsl:param>
<xsl:param name="howmany">10</xsl:param>
<xsl:param name="startpoint">1</xsl:param>
<xsl:template match="*|@*|processing-instruction()">
 <xsl:copy>
  <xsl:apply-templates select="*|@*|processing-instruction()|comment()|text()"/>
 </xsl:copy>
</xsl:template>

<xsl:template match="*" mode="literal">
   <hi rend="important">
     <xsl:text>&lt;</xsl:text>
     <xsl:value-of select="name(.)"/>
     <xsl:for-each select="attribute::*">
       <xsl:text> </xsl:text>
       <xsl:value-of select="name(.)"/>
       <xsl:text>='</xsl:text><xsl:value-of select="."/>
       <xsl:text>'</xsl:text>
     </xsl:for-each>
     <xsl:text>&gt;</xsl:text>
   </hi>
   <xsl:apply-templates mode="literal"/>
   <hi rend="important">
     <xsl:text>&lt;/</xsl:text>
     <xsl:value-of select="name(.)"/>
     <xsl:text>&gt;</xsl:text>
   </hi>
  </xsl:template>


<xsl:template match="text()">
    <xsl:value-of select="."/> <!-- could normalize() here -->
</xsl:template>

<xsl:template match="exist:request">
  <xsl:variable name="QUERY">
    <xsl:text>http://localhost:8088/?_xpath=</xsl:text>
    <xsl:value-of select="translate($query,'_','%')"/>
    <xsl:text>&amp;_indent=</xsl:text><xsl:value-of select="display/@indent"/>
    <xsl:text>&amp;_howmany=</xsl:text><xsl:value-of select="$howmany"/>
    <xsl:text>&amp;_start=</xsl:text><xsl:value-of select="$startpoint"/>
  </xsl:variable>
  <p>Query: <xsl:value-of select="$QUERY"/></p>
  <xsl:for-each select="document($QUERY)/exist:result">
    <p>Found <xsl:value-of select="@hitCount"/> results.</p>
    <p>
  <table rend="rules">
    <xsl:for-each select="*">
    <xsl:variable name="S">
     <xsl:value-of 
       select="substring-after(substring-after(@exist:source,'/db/'),'/')"/>
   </xsl:variable>
      <row>
        <cell>
          <xptr>
            <xsl:attribute name="xref">              
               <xsl:value-of select="$S"/>
            </xsl:attribute>
          </xptr>
      </cell>
      <xsl:choose>
          <xsl:when test="$delivery='raw'">
           <cell align="left">
             <Screen><xsl:apply-templates select="." mode="literal"/>
              </Screen>
            </cell>
          </xsl:when>
          <xsl:when test="$delivery='both'">
           <cell><xsl:apply-templates select="."/></cell>
           <cell align="left">  
   <Screen><xsl:apply-templates select="." mode="literal"/></Screen></cell>
 </xsl:when>
          <xsl:otherwise>
            <cell><xsl:apply-templates select="."/></cell>
          </xsl:otherwise>
           
        </xsl:choose>
      </row>
    </xsl:for-each>
  </table></p>

<xsl:if test="$howmany &lt; @hitCount">
  <xsl:variable name="NEWQUERY">
    <xsl:text>http://localhost/display/pcresults.xml?query=</xsl:text>
    <xsl:value-of select="$query"/>
    <xsl:text>&amp;startpoint=</xsl:text><xsl:value-of select="$startpoint + $howmany"/>
    <xsl:text>&amp;delivery=</xsl:text><xsl:value-of select="$delivery"/>
  </xsl:variable>
  <xref url="{$NEWQUERY}">next lot</xref>
 </xsl:if>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
