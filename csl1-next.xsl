<?xml version="1.0"?>
<xsl:stylesheet xmlns:cs="http://purl.org/net/xbiblio/csl"
                xmlns="http://purl.org/net/xbiblio/csl/2"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <!-- converts CSL 1.0 to 1.1 -->
  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- update version number -->
  <xsl:template match="@version[.='1.0']">
    <xsl:attribute name="version">2.0</xsl:attribute>
  </xsl:template>

  <!-- template to change the namespace -->
  <xsl:template match="cs:*">
    <xsl:element name="{local-name()}" namespace="http://purl.org/net/xbiblio/csl/2">
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>

  <!-- strip elements with these deprecated attribute values -->
  <xsl:template match="//cs:link[@rel='independent-parent']"/>
  <xsl:template match="//cs:link[@rel='template']"/>

  <!-- convert stuff to generic list -->
  <xsl:template match="//cs:group|//cs:layout|//cs:names">
    <list>
      <xsl:apply-templates select="*|@*"/>
    </list>
  </xsl:template>

  <xsl:template match="//cs:text">
    <reference>
      <xsl:apply-templates select="*|@*"/>
    </reference>
  </xsl:template>

  <xsl:template match="//cs:macro">
    <template>
      <xsl:apply-templates select="*|@*"/>
    </template>
  </xsl:template>


</xsl:stylesheet>
