<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../../constants/colors.xsl"/>
  <xsl:import href="../../constants/fonts.xsl"/>

  <xsl:template name="sottotitolo">
    <xsl:param name="testo"/>
    <fo:block
      font-weight="bold"
      font-size="{$font-size-small}"
      color="{$colore-principale}"
    >
      <xsl:value-of select="$testo"/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
