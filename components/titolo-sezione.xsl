<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../constants/fonts.xsl"/>
  <xsl:import href="../constants/spacing.xsl"/>

  <xsl:template name="titolo-sezione">
    <xsl:param name="testo"/>
    <fo:block
      font-size="{$font-size-titolo-sezione}"
      font-weight="bold"
      color="{$colore-secondario}"
      space-after="3mm"
      border-bottom="1pt solid black"
      margin-top="{$spaziatura-titolo-sezione}"
    >
      <xsl:value-of select="$testo"/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
