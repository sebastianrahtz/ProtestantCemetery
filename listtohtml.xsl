<?xml version='1.0'?>
<xsl:stylesheet 
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" >


<xsl:output method="html"/>

<xsl:template match="/">
<html>
<head>
<title>Matches between cemetery databases</title>
</head>
<body>
<table>
<thead>
<tr>
  <th>Stone</th><th>Surname</th><th>Forename</th><th>Year</th><th>Tomb</th></tr>
</thead>
<tbody>
<xsl:for-each select=".//person" >
<tr>
  <xsl:variable name="tomb"
		select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/altIdentifier/idno[@type='tomb']"/>
  <xsl:variable name="id"
		select="ancestor::TEI/teiHeader/fileDesc/sourceDesc/msDesc/msIdentifier/idno"/>
  <xsl:variable name="name"
		select="persName/surname"/>
  <xsl:variable name="year"
		select="substring(death/@when,1,4)"/>
<td>
  <xsl:value-of select="$id"/>
</td>
<td>
  <xsl:value-of select="$name"/>
</td>
<td>
  <xsl:value-of select="persName/forename"/>
</td>
<td>
  <xsl:value-of select="$year"/>
</td>
<td>
  <xsl:value-of select="$tomb"/>
</td>
</tr>
</xsl:for-each>
</tbody>
</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
