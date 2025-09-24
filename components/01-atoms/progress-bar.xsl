<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

<xsl:import href="../../constants/colors.xsl"/>
<xsl:import href="../../constants/spacing.xsl"/>


<xsl:variable name="progressbar-width" select="'100'"/>
<xsl:variable name="progressbar-height" select="'2'"/>

<xsl:template name="progress-bar">
  <xsl:param name="valore"/>

  <xsl:variable name="percent" select="number($valore) div 10"/> <!-- valore da 0 a 10 -->
  <xsl:variable name="perc100" select="$percent * 100"/> <!-- percentuale da 0 a 100 -->

  <!-- calcolo del colore in base alla percentuale -->
  <xsl:variable name="r" select="255 - floor(255 * $perc100 div 100)"/>
  <xsl:variable name="g" select="0"/>
  <xsl:variable name="b" select="floor(255 * $perc100 div 100)"/>

  <xsl:variable name="fillColor" select="concat('rgb(',$r,',',$g,',',$b,')')"/>

  <xsl:variable name="width" select="$progressbar-width * $perc100 div 100"/>

  <fo:block>
    <fo:instream-foreign-object>
      <svg width="{$progressbar-width}" height="{$progressbar-height}" xmlns="http://www.w3.org/2000/svg">

          <title><xsl:value-of select="$valore"/>/10</title>
          <desc>Livello competenza <xsl:value-of select="$valore"/> su 10</desc>
        <rect x="0" y="0" width="{$progressbar-width}" height="{$progressbar-height}" fill="#e0e0e0"/>

        <rect x="0" y="0" width="{$width}" height="{$progressbar-height}" fill="{$fillColor}"/>
      </svg>
    </fo:instream-foreign-object>
  </fo:block>
</xsl:template>
  
</xsl:stylesheet>
