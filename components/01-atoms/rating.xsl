<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../../constants/index.xsl"/>

  <xsl:template name="rating">
    <xsl:param name="value"/>
    <xsl:param name="livello"/>
    <xsl:param name="max" select="5"/>

    <fo:block>
      <xsl:call-template name="draw-circles">
        <xsl:with-param name="pos" select="1"/>
        <xsl:with-param name="value" select="$value"/>
        <xsl:with-param name="max" select="$max"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>


<xsl:template name="draw-circles">
  <xsl:param name="pos"/>
  <xsl:param name="value"/>
  <xsl:param name="max"/>
  <xsl:param name="livello"/>

  <fo:inline font-size="15pt" word-spacing="0pt" letter-spacing="0pt" padding-right="5pt">
    <xsl:attribute name="color">
      <xsl:choose>
        <xsl:when test="$pos &lt;= $value">blue</xsl:when>
        <xsl:otherwise>lightgrey</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:text>●</xsl:text>
  </fo:inline>

  <xsl:if test="$pos &lt; $max">
    <xsl:call-template name="draw-circles">
      <xsl:with-param name="pos" select="$pos + 1"/>
      <xsl:with-param name="value" select="$value"/>
      <xsl:with-param name="max" select="$max"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>
  
</xsl:stylesheet>
