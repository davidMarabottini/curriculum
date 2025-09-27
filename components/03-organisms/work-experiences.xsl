<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../../constants/index.xsl"/>
  <xsl:import href="../01-atoms/titolo-sezione.xsl"/>

  <xsl:template name="work-experiences">
    <xsl:param name="label" />
    <xsl:param name="esperienze" />
    <xsl:param name="approfondimento-esperienze" />

    <fo:block>
      <xsl:call-template name="titolo-sezione">
        <xsl:with-param name="testo" select="$label"/>
      </xsl:call-template>
      <xsl:for-each select="$esperienze/esperienza">
        <fo:block space-after="{$spaziatura-dettaglio}">
          <xsl:call-template name="sottotitolo">
            <!-- <fo:inline font-family="FontAwesome" padding-left="3mm" padding-right="1mm">&#xf2b9;</fo:inline> -->
            <xsl:with-param name="testo" select="titolo"/>
          </xsl:call-template>

          <fo:block font-size="{$font-size-small}" color="{$colore-secondario}">
            <fo:inline font-family="FontAwesome" padding-right="1mm">&#xf2b5;</fo:inline>
            <xsl:value-of select="azienda"/>
            <fo:inline font-family="FontAwesome" padding-left="3mm" padding-right="1mm">&#xf133;</fo:inline>
            <xsl:value-of select="periodo"/>
          </fo:block>

          <xsl:for-each select="attivita/attivita-item">
            <fo:block font-size="{$font-size-small}" margin-top="1mm" color="{$colore-principale}">
              <xsl:value-of select="."/>
            </fo:block>
          </xsl:for-each>
        </fo:block>
      </xsl:for-each>
    </fo:block>

    <fo:block margin-top="{$spaziatura-base}" font-size="{$font-size-small}">
      <xsl:call-template name="link">
        <xsl:with-param name="icon">&#x2b;</xsl:with-param>
        <xsl:with-param name="url" select="$approfondimento-esperienze/url"/>
        <xsl:with-param name="tipo" select="$approfondimento-esperienze/label"/>
      </xsl:call-template>
    </fo:block>
      
  </xsl:template>
  
</xsl:stylesheet>