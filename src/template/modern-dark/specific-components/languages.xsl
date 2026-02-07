<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../../../constants/index.xsl"/>
  <xsl:import href="../../../components/01-atoms/titolo-sezione.xsl"/>
  <xsl:import href="../../../components/01-atoms/rating.xsl"/>
  <xsl:import href="../../../components/02-molecules/conditional-link.xsl"/>

  <xsl:template name="languages">
    <xsl:param name="label" />
    <xsl:param name="langs" />

    <xsl:call-template name="titolo-sezione">
      <xsl:with-param name="testo" select="$label" />
      <xsl:with-param name="is-dark" select="true()"/>
    </xsl:call-template>
    
    <xsl:for-each select="$langs">
      <fo:block font-size="{$font-size-small}" space-after="{$spaziatura-dettaglio}">
        <!-- <xsl:call-template name="conditional-link">
          <xsl:with-param name="text" select="nome" />
          <xsl:with-param name="url" select="url" />
          <xsl:with-param name="is-dark" select="true()"/>
        </xsl:call-template> -->
        <fo:block color="{$colore-testo-chiaro}">
          <xsl:value-of select="nome"/>
        </fo:block>
        <xsl:call-template name="rating">
          <xsl:with-param name="value" select="valore"/>
          <xsl:with-param name="livello" select="livello"/>
        </xsl:call-template>
      </fo:block>
    </xsl:for-each>

    <fo:block>
      
    </fo:block>
  </xsl:template>
  
</xsl:stylesheet>