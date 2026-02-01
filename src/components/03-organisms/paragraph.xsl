<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../../constants/index.xsl"/>
  <xsl:import href="../01-atoms/titolo-sezione.xsl"/>
  <xsl:import href="../01-atoms/sottotitolo.xsl"/>
  <xsl:import href="../utils/md-parser/md-parser.xsl"/>

  <xsl:template name="paragraph">
    <xsl:param name="label" />
    <xsl:param name="data" />
    <xsl:param name="company-icon" />

    <fo:block>
    <xsl:call-template name="titolo-sezione">
      <xsl:with-param name="testo" select="$label" />
    </xsl:call-template>

    <xsl:for-each select="$data/item">
      <fo:block space-after="{$spaziatura-base}" space-before="{$spaziatura-base}">
      <xsl:if test="position() != last()">
            <xsl:attribute name="border-bottom">1px dotted #888888</xsl:attribute>
        </xsl:if>
        <xsl:call-template name="sottotitolo">
          <xsl:with-param name="testo" select="titolo"/>
        </xsl:call-template>

        <fo:block font-size="{$font-size-small}" color="{$colore-secondario}">
          <fo:inline font-family="FontAwesome" padding-right="1mm" font-weight="bold">
            <xsl:value-of select="$company-icon" />    
          </fo:inline>
          <fo:inline padding-right="3mm">
            <xsl:value-of select="azienda" />
          </fo:inline>
          <fo:inline font-family="FontAwesome" padding-right="1mm">&#xf133;</fo:inline>
          <xsl:value-of select="periodo"/>
        </fo:block>
        <fo:block font-size="{$font-size-small}" color="{$colore-secondario}" margin-top="1mm">
          <xsl:call-template name="render-markdown-poc">
            <xsl:with-param name="text" select="descrizione"/>
            <xsl:with-param name="font-size" select="$font-size-small"/>
            <xsl:with-param name="color" select="$colore-principale"/>
            <xsl:with-param name="margin-top" select="'1mm'"/>
          </xsl:call-template>
        </fo:block>
      </fo:block>
    </xsl:for-each>
    </fo:block>
  </xsl:template>
  
</xsl:stylesheet>