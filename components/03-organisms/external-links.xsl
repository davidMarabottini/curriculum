<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../../constants/index.xsl"/>
  <xsl:import href="../01-atoms/titolo-sezione.xsl"/>

    <xsl:template name="external-links">
    <xsl:param name="title" />
    <xsl:param name="links" />

    <xsl:call-template name="titolo-sezione">
      <xsl:with-param name="testo" select="$title" />
    </xsl:call-template>

    <fo:block margin-top="{$spaziatura-base}">
      <xsl:for-each select="$links/link">
        <fo:inline font-size="{$font-size-base}" color="{$colore-secondario}">
          <xsl:call-template name="link">
            <xsl:with-param name="url" select="url"/>
            <xsl:with-param name="tipo" select="tipo"/>
          </xsl:call-template>

          <xsl:if test="position() != last()">
            <fo:inline padding-start="5pt" padding-end="5pt" font-size="{$font-size-base}" color="{$colore-secondario}">
              •
            </fo:inline>
          </xsl:if>
        </fo:inline>
      </xsl:for-each>
    </fo:block>
  </xsl:template>
  
</xsl:stylesheet>