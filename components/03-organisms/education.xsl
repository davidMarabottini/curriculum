<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../../constants/index.xsl"/>
  <xsl:import href="../01-atoms/titolo-sezione.xsl"/>

  <xsl:template name="template-formazione">
    <xsl:param name="label" />
    <xsl:param name="formazione" />
    <xsl:param name="approfondimento-formazione" />

    <fo:block>
    <xsl:call-template name="titolo-sezione">
      <xsl:with-param name="testo" select="$label" />
      <xsl:with-param name="link" select="$approfondimento-formazione" />
    </xsl:call-template>

    <xsl:for-each select="$formazione/corso-studio">
      <fo:block space-after="{$spaziatura-base}" space-before="{$spaziatura-base}">
      <xsl:if test="position() != last()">
            <xsl:attribute name="border-bottom">1px dotted #888888</xsl:attribute>
        </xsl:if>
        <xsl:call-template name="sottotitolo">
          <xsl:with-param name="testo" select="titolo"/>
        </xsl:call-template>

        <fo:block font-size="{$font-size-small}" color="{$colore-secondario}">
          <fo:inline font-family="FontAwesome" padding-right="1mm" font-weight="bold">&#xf02d;</fo:inline>
          <xsl:value-of select="ente"/>
          <fo:inline font-family="FontAwesome" padding-left="3mm" padding-right="1mm">&#xf133;</fo:inline>
          <xsl:value-of select="anno"/>
        </fo:block>
        <fo:block font-size="{$font-size-small}" color="{$colore-secondario}" margin-top="1mm">
          <!-- <xsl:value-of select="descrizione"/> -->
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