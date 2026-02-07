<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:date="http://exslt.org/dates-and-times"
  extension-element-prefixes="date"
>
  
  <xsl:import href="../constants/index.xsl"/>
  <xsl:import href="../components/index.xsl"/>


  <xsl:template name="human">
    <xsl:param name="cv_data"/>
    <xsl:param name="labels" />
    <xsl:param name="dati_personali" />
    <fo:block margin="{$margine-pagina}">
 
      <xsl:call-template name="header">
        <xsl:with-param
          name="nome"
          select="$cv_data/dati-personali/nome"
        />
        <xsl:with-param
          name="email"
          select="$dati_personali/email"
        />
        <xsl:with-param
          name="telefono"
          select="$dati_personali/telefono"
        />
        <xsl:with-param
          name="luogo"
          select="$dati_personali/luogo"
        />
      </xsl:call-template>

      <fo:table table-layout="fixed" width="100%" space-before="0.05cm">
        <fo:table-column column-width="70%"/>
        <fo:table-column column-width="30%"/>

        <fo:table-body>
          <fo:table-row>
            <fo:table-cell padding-right="{$spazio-colonne}">
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
                <xsl:call-template name="paragraph">
                  <xsl:with-param name="label" select="$labels/personal-projects"/>
                  <xsl:with-param name="data" select="$cv_data/progetti-personali"/>
                </xsl:call-template>
                
                <xsl:call-template name="paragraph">
                  <xsl:with-param name="label" select="$labels/work-experience"/>
                  <xsl:with-param name="data" select="$cv_data/esperienze"/>
                  <xsl:with-param name="company-icon" select="'&#xf2b5;'"/>
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
              </fo:block>
            </fo:table-cell>

            <fo:table-cell padding-left="{$spazio-colonne}">
              <fo:block>
                <xsl:call-template name="radar-chart">
                  <xsl:with-param name="label" select="$labels/expertise" />
                  <xsl:with-param name="spiderweb" select="$cv_data/competenze/skillsspiderweb"/>
                  <xsl:with-param name="chat-title" select="$labels/competenze/expertise-chart-title"/>
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
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>

      <fo:block font-size="{$font-size-small}" color="{$colore-secondario}" space-before="6mm">
        <xsl:value-of select="$labels/policies"/>
      </fo:block>
      <fo:block font-size="{$font-size-small}" color="{$colore-secondario}" space-before="6mm">
        <xsl:value-of select="substring(date:date-time(), 1, 10)"/>
      </fo:block>
    </fo:block>
  </xsl:template>
</xsl:stylesheet>
