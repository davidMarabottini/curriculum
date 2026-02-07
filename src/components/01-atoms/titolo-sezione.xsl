<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:import href="../../constants/index.xsl"/>
  
  <xsl:template name="titolo-sezione">
    <xsl:param name="testo"/>
    <xsl:param name="is-dark" select="false()"/> <xsl:variable name="colore-testo">
      <xsl:choose>
        <xsl:when test="$is-dark"><xsl:value-of select="$colore-testo-chiaro"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$colore-secondario"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="colore-bordo">
      <xsl:choose>
        <xsl:when test="$is-dark"><xsl:value-of select="$colore-testo-chiaro"/></xsl:when>
        <xsl:otherwise>black</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <fo:block
      font-size="{$font-size-titolo-sezione}"
      font-weight="bold"
      color="{$colore-testo}"
      space-after="2mm"
      border-bottom="1pt solid {$colore-bordo}"
      margin-top="{$spaziatura-titolo-sezione}"
      width="100%"
      >
      <xsl:value-of select="$testo"/>
    </fo:block>
  </xsl:template>
  
</xsl:stylesheet>
