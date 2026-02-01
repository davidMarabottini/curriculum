<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../../constants/colors.xsl"/>
  <xsl:import href="../../constants/spacing.xsl"/>

  <xsl:template name="header">
    <xsl:param name="nome"/>
    <xsl:param name="email"/>
    <xsl:param name="telefono"/>
    <xsl:param name="luogo"/>

    <fo:block-container text-align="center">
      <fo:block font-size="{$font-size-titolo-principale}" font-weight="bold" space-after="1mm" color="{$colore-principale}">
        <xsl:value-of select="$nome"/>
      </fo:block>
      <fo:block font-size="{$font-size-base}" space-after="1mm" color="{$colore-secondario}">
        <xsl:if test="$email">
          <fo:inline font-family="FontAwesome" padding-right="1mm">&#xf0e0;</fo:inline>
          <xsl:value-of select="$email"/>
        </xsl:if>
        <xsl:if test="$telefono">
          <fo:inline font-family="FontAwesome" padding-left="3mm" padding-right="1mm">&#xf2b9;</fo:inline>
          <xsl:value-of select="$telefono"/>
        </xsl:if>
        <xsl:if test="$luogo">
        <fo:inline font-family="FontAwesome" padding-left="3mm" padding-right="1mm">&#xf279;</fo:inline>
        <xsl:value-of select="$luogo"/>
        </xsl:if>
      </fo:block>
    </fo:block-container>
  </xsl:template>
  
</xsl:stylesheet>