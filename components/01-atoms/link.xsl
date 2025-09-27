<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../../constants/colors.xsl"/>

  <xsl:template name="link">
    <xsl:param name="url"/>
    <xsl:param name="tipo"/>
    <xsl:param name="icon" select="''"/> <!-- opzionale -->

    <fo:basic-link
      external-destination="{$url}"
      color="{$colore-link}"
    >
      <xsl:if test="string-length($icon) &gt; 0">
        <fo:inline font-family="FontAwesome" font-weight="bold" padding-right="3pt">
          <xsl:value-of select="$icon"/>
        </fo:inline>
      </xsl:if>

      <xsl:value-of select="$tipo"/>
    </fo:basic-link>
  </xsl:template>
  
</xsl:stylesheet>
