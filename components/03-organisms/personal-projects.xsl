<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="../../constants/index.xsl"/>
  <xsl:import href="../01-atoms/titolo-sezione.xsl"/>
  <xsl:import href="../utils//md-parser/md-parser.xsl"/>

  <xsl:template name="personal-projects">
    <xsl:param name="label" />
    <xsl:param name="progetti-personali" />
    <xsl:param name="approfondimento-progetti-personali" />

    <fo:block>
      <xsl:call-template name="titolo-sezione">
        <xsl:with-param name="testo" select="$label"/>
        <xsl:with-param name="link" select="$approfondimento-progetti-personali" />
      </xsl:call-template>
      <xsl:for-each select="$progetti-personali/progetto-personale">
        <fo:block space-after="{$spaziatura-base}" space-before="{$spaziatura-base}">
          <xsl:if test="position() != last()">
            <xsl:attribute name="border-bottom">1px dotted #888888</xsl:attribute>
          </xsl:if>
          <xsl:call-template name="sottotitolo">
            <xsl:with-param name="testo" select="titolo"/>
          </xsl:call-template>

          <xsl:for-each select="descrizione">
            <xsl:call-template name="render-markdown-poc">
              <xsl:with-param name="text" select="."/>
              <xsl:with-param name="font-size" select="$font-size-small"/>
              <xsl:with-param name="color" select="$colore-principale"/>
              <xsl:with-param name="margin-top" select="'1mm'"/>
            </xsl:call-template>
          </xsl:for-each>
        </fo:block>
      </xsl:for-each>
    </fo:block>
  </xsl:template>
  
</xsl:stylesheet>