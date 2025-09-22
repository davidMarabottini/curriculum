<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:include href="../constants/colors.xsl"/>

  <xsl:template name="link">
    <xsl:param name="url"/>
    <xsl:param name="tipo"/>

    <fo:basic-link
      external-destination="{$url}"
      color="{$colore-link}"
      text-decoration="underline"
    >
      <xsl:value-of select="$tipo"/>
    </fo:basic-link>
  </xsl:template>
  
</xsl:stylesheet>
