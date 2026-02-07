<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:import href="../../constants/index.xsl"/>
  <xsl:import href="../../components/index.xsl"/>
  <xsl:import href="./specific-components/skill-list.xsl"/>
  <xsl:import href="./specific-components/certification.xsl"/>
  <xsl:import href="./specific-components/languages.xsl"/>
  
  <!-- TEMPLATE SIDEBAR -->
  <xsl:template name="modern-dark-sidebar">
    <xsl:param name="cv_data"/>
    <xsl:param name="labels"/>
    <xsl:param name="dati_personali"/>
    
    <fo:block text-align="center" margin-bottom="5mm">
      <fo:external-graphic src="url({$cv_data/dati-personali/foto})" content-width="35mm" content-height="35mm"/>
    </fo:block>
    
    <fo:block font-size="18pt" font-weight="bold" margin-bottom="2mm" color="{$colore-accento}">
      <xsl:value-of select="$cv_data/dati-personali/nome"/>
    </fo:block>
    
    <fo:block font-size="{$font-size-small}" space-after="10mm">
      <xsl:if test="$dati_personali/email">
        <fo:block margin-bottom="{$spaziatura-dettaglio}">
          <fo:inline font-family="FontAwesome" color="{$colore-testo-chiaro}" padding-right="2mm">&#xf0e0;</fo:inline>
          <fo:inline color="{$colore-testo-chiaro}">
            <xsl:value-of select="$dati_personali/email"/>
          </fo:inline>
        </fo:block>
      </xsl:if>
      <xsl:if test="$dati_personali/telefono">
        <fo:block margin-bottom="{$spaziatura-dettaglio}">
          <fo:inline font-family="FontAwesome" color="{$colore-testo-chiaro}" padding-right="2mm">&#xf2b9;</fo:inline>
          <fo:inline color="{$colore-testo-chiaro}">
            <xsl:value-of select="$dati_personali/telefono"/>
          </fo:inline>
        </fo:block>
      </xsl:if>
      <xsl:if test="$dati_personali/luogo">
        <fo:block margin-bottom="{$spaziatura-dettaglio}">
          <fo:inline font-family="FontAwesome" color="{$colore-testo-chiaro}" padding-right="2mm">&#xf279;</fo:inline>
          <fo:inline color="{$colore-testo-chiaro}">
            <xsl:value-of select="$dati_personali/luogo"/>
          </fo:inline>
        </fo:block>
      </xsl:if>
    </fo:block>
    <fo:block padding="{$spaziatura-base}" border="1px solid #fff" text-align="center" space-after="10mm">
      <xsl:call-template name="link">
        <xsl:with-param name="tipo" select="$labels/other-cv"/>
        <xsl:with-param name="url" select="$cv_data/dati-personali/other-cv"/>
        <xsl:with-param name="is-dark" select="true()"/>
      </xsl:call-template>
    </fo:block>
    
    <xsl:call-template name="certification-modern-dark">
      <xsl:with-param name="label" select="$labels/certificates"/>
      <xsl:with-param name="certificates" select="$cv_data/competenze/certificates/item"/>
    </xsl:call-template>
    
    <xsl:call-template name="skill-list-dark-modern">
      <xsl:with-param name="label" select="$labels/hard-skills"/>
      <xsl:with-param name="skill-ls" select="$cv_data/competenze/hardskills"/>
    </xsl:call-template>
    
    <xsl:call-template name="skill-list-dark-modern">
      <xsl:with-param name="label" select="$labels/soft-skills"/>
      <xsl:with-param name="skill-ls" select="$cv_data/competenze/softskills"/>
    </xsl:call-template>
    
    <xsl:call-template name="languages">
      <xsl:with-param name="label" select="$labels/languages"/>
      <xsl:with-param name="langs" select="$cv_data/lingue/lingua"/>
    </xsl:call-template>
    
  </xsl:template>
  
  <xsl:template name="modern-dark-main">
    <xsl:param name="cv_data"/>
    <xsl:param name="labels"/>
    
    <fo:block border-left="3pt solid {$colore-accento}" padding-left="4mm" margin-bottom="8mm">
      <fo:block font-size="{$font-size-titolo-sezione}" font-weight="bold" color="{$colore-sidebar}" text-transform="uppercase">
        <xsl:value-of select="$labels/professional-profile"/>
      </fo:block>
      <fo:block font-size="{$font-size-base}" margin-top="2mm" font-style="italic">
        <xsl:value-of select="$cv_data/descrizione"/>
      </fo:block>
    </fo:block>
    
    <xsl:call-template name="paragraph">
      <xsl:with-param name="label" select="$labels/work-experience"/>
      <xsl:with-param name="data" select="$cv_data/esperienze"/>
      <xsl:with-param name="company-icon" select="'&#xf0b1;'"/>
    </xsl:call-template>
    
    <xsl:call-template name="paragraph">
      <xsl:with-param name="label" select="$labels/personal-projects"/>
      <xsl:with-param name="data" select="$cv_data/progetti-personali"/>
      <xsl:with-param name="company-icon" select="'&#xf0ad;'"/>
    </xsl:call-template>
    
    <xsl:call-template name="paragraph">
      <xsl:with-param name="label" select="$labels/education"/>
      <xsl:with-param name="data" select="$cv_data/formazione"/>
      <xsl:with-param name="company-icon" select="'&#xf02d;'"/>
    </xsl:call-template>
    
    <xsl:call-template name="paragraph">
      <xsl:with-param name="label" select="$labels/conceptual-projects"/>
      <xsl:with-param name="data" select="$cv_data/progetti-concettuali"/>
    </xsl:call-template>
    
    <fo:block font-size="7pt" color="#aaa" margin-top="10mm" text-align="right">
      <xsl:value-of select="$labels/footer"/>
    </fo:block>
    
  </xsl:template>
  
</xsl:stylesheet>
