<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../../constants/colors.xsl"/>
  <xsl:import href="../01-atoms/link.xsl"/>
  
  <xsl:template name="conditional-link">

    <xsl:param name="text"/>
    <xsl:param name="url"/>

    <xsl:choose>
      <xsl:when test="string($url)">
        <xsl:call-template name="link">
          <xsl:with-param name="url" select="$url"/>
          <xsl:with-param name="tipo" select="$text"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>