<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
>
  
  <xsl:import href="../../constants/index.xsl"/>
  <xsl:import href="../01-atoms/titolo-sezione.xsl"/>
  <xsl:import href="../01-atoms/progress-bar.xsl"/>
  <xsl:import href="../02-molecules/conditional-link.xsl"/>
  
  <xsl:template name="skill-list">
    <xsl:param name="label" />
    <xsl:param name="skill-ls" />
    
    <fo:block>
      <xsl:call-template name="titolo-sezione">
        <xsl:with-param name="testo" select="$label" />
      </xsl:call-template>
      <xsl:choose>
        <xsl:when test="$skill-ls/area">
          <xsl:for-each select="$skill-ls/area">
            <xsl:variable name="iconCode" select="./icon"/>
            
            <fo:block font-size="{$font-size-small}" font-weight="bold" margin-top="{$spaziatura-dettaglio}" margin-bottom="{$spaziatura-dettaglio}">
              <fo:inline font-family="FontAwesome" padding-right="1mm" font-weight="bold">&#xf005;</fo:inline>
              <xsl:value-of select="./name" />
            </fo:block>
            
            <xsl:for-each select="./skills/hardskill">
              <xsl:call-template name="atomic-skills">
                <xsl:with-param name="skill" select="."/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="$skill-ls/softskill">
            <xsl:call-template name="atomic-skills">
              <xsl:with-param name="skill" select="."/>
            </xsl:call-template> 
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
  </xsl:template>
  
  <xsl:template name="atomic-skills">
    <xsl:param name="skill" />
    <fo:block font-size="{$font-size-small}" color="{$colore-secondario}" space-after="2.1mm" space-before="0" line-height="0.7">
      <xsl:call-template name="conditional-link">
        <xsl:with-param name="text" select="$skill/item" />
        <xsl:with-param name="url" select="$skill/url" />
      </xsl:call-template>
      <xsl:call-template name="progress-bar">
        <xsl:with-param name="valore" select="$skill/valore" />
      </xsl:call-template>
    </fo:block>
  </xsl:template>
  
</xsl:stylesheet>