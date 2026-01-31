<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:import href="../constants/index.xsl"/>
  <xsl:import href="../components/index.xsl"/>

  <xsl:template name="ats">
    <xsl:param name="cv_data"/>
    <xsl:param name="root_folder" />
    <xsl:param name="labels" />
    <xsl:call-template name="header">
      <xsl:with-param name="nome" select="$cv_data/dati-personali/nome"/>
      <xsl:with-param name="email" select="string(document(concat('../profiles/', $root_folder, '/datipersonali.xml'))/dati-personali/email)" />
      <xsl:with-param name="telefono" select="string(document(concat('../profiles/', $root_folder, '/datipersonali.xml'))/dati-personali/telefono)"/>
      <xsl:with-param name="luogo" select="string(document(concat('../profiles/', $root_folder, '/datipersonali.xml'))/dati-personali/luogo)"/>
    </xsl:call-template>

            <fo:block font-size="{$font-size-small}" color="{$colore-secondario}">
              <xsl:call-template name="titolo-sezione">
                <xsl:with-param name="testo" select="$labels/professional-profile"/>
              </xsl:call-template>

              <fo:block>
                  <xsl:call-template name="render-markdown-poc">
                    <xsl:with-param name="text" select="$cv_data/descrizione"/>
                    <xsl:with-param name="font-size" select="$font-size-small"/>
                    <xsl:with-param name="color" select="$colore-principale"/>
                    <xsl:with-param name="margin-top" select="'1mm'"/>
                  </xsl:call-template>
                </fo:block>
            </fo:block>

            <fo:block>
              <xsl:if test="string-length($cv_data/progetti-personali) &gt; 0">
                <xsl:call-template name="personal-projects">
                  <xsl:with-param name="label" select="$labels/personal-projects"/>
                  <xsl:with-param name="progetti-personali" select="$cv_data/progetti-personali"/>
                  <xsl:with-param name="approfondimento-progetti-personali" select="$cv_data/approfondimento-progetti-personali"/>
                </xsl:call-template>
              </xsl:if>

              <xsl:call-template name="work-experiences">
                <xsl:with-param name="label" select="$labels/work-experience"/>
                <xsl:with-param name="esperienze" select="$cv_data/esperienze"/>
                <xsl:with-param name="approfondimento-esperienze" select="$cv_data/approfondimento-esperienze"/>
              </xsl:call-template>

              <xsl:call-template name="template-formazione">
                <xsl:with-param name="label" select="$labels/education"/>
                <xsl:with-param name="formazione" select="$cv_data/formazione"/>
                <xsl:with-param name="approfondimento-formazione" select="$cv_data/approfondimento-formazione"/>
              </xsl:call-template>
              
              <xsl:if test="string-length($cv_data/progetti-personali) &gt; 0">
                <xsl:call-template name="personal-projects">
                  <xsl:with-param name="label" select="$labels/conceptual-projects"/>
                  <xsl:with-param name="progetti-personali" select="$cv_data/progetti-concettuali"/>
                  <xsl:with-param name="approfondimento-progetti-personali" select="$cv_data/approfondimento-progetti-personali"/>
                </xsl:call-template>
              </xsl:if>
            </fo:block>

            <fo:block>
              <xsl:call-template name="radar-chart-ats">
                <xsl:with-param name="label" select="$labels/expertise" />
                <xsl:with-param name="chart-description" select="$cv_data/competenze/chart-description"/>
              </xsl:call-template>
              
              <xsl:call-template name="certification">
                <xsl:with-param name="label" select="$labels/certificates"/>
                <xsl:with-param name="certificates" select="$cv_data/competenze/certificates/item"/>
              </xsl:call-template>

              <xsl:call-template name="skill-list">
                <xsl:with-param name="label" select="$labels/hard-skills"/>
                <xsl:with-param name="skill-ls" select="$cv_data/competenze/hardskills"/>
              </xsl:call-template>
              
              <xsl:call-template name="skill-list">
                <xsl:with-param name="label" select="$labels/soft-skills"/>
                <xsl:with-param name="skill-ls" select="$cv_data/competenze/softskills"/>
              </xsl:call-template>
              
              <xsl:call-template name="external-links">
                <xsl:with-param name="title" select="$labels/external-links" />
                <xsl:with-param name="links" select="$cv_data/link-esterni" />
              </xsl:call-template>
              
              <xsl:call-template name="languages">
                <xsl:with-param name="label" select="$labels/languages"/>
                <xsl:with-param name="langs" select="$cv_data/lingue/lingua"/>
              </xsl:call-template>
            </fo:block>

    <fo:block font-size="{$font-size-small}" color="{$colore-secondario}" space-before="6mm">
      <xsl:value-of select="$labels/policies"/>
    </fo:block>
  </xsl:template>
</xsl:stylesheet>
