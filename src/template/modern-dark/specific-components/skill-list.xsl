<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
>
  
  <xsl:import href="../../../constants/index.xsl"/>
  <xsl:import href="../../../components/01-atoms/titolo-sezione.xsl"/>
  <xsl:import href="../../../components/01-atoms/progress-bar.xsl"/>
  <xsl:import href="../../../components/02-molecules/conditional-link.xsl"/>
  
  <xsl:template name="skill-list-dark-modern">
    <xsl:param name="label" />
    <xsl:param name="skill-ls" />
    
    <fo:block>
      <xsl:call-template name="titolo-sezione">
        <xsl:with-param name="testo" select="$label" />
        <xsl:with-param name="is-dark" select="true()"/>
      </xsl:call-template>
      <xsl:choose>
        <xsl:when test="$skill-ls/area">
          <xsl:for-each select="$skill-ls/area">
            
            <fo:block font-size="{$font-size-small}" font-weight="bold" margin-top="{$spaziatura-dettaglio}" color="{$colore-testo-chiaro}">
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
    <fo:block font-size="{$font-size-small}" color="{$colore-testo-chiaro}" space-after="0" line-height="0.7" padding-top="{$spaziatura-dettaglio}">
      <xsl:value-of select="$skill/item" />
    </fo:block>
  </xsl:template>
  
</xsl:stylesheet>