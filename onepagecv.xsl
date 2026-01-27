<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="./constants/index.xsl"/>
  <xsl:import href="./components/index.xsl"/>

  <xsl:param name="root_folder" select="'david_marabottini'"/>
  <xsl:param name="lang" select="'it'"/>
  <xsl:param name="data" select="'onepagecv.xml'"/>

  <xsl:variable name="labels" select="document(concat('profiles/', $root_folder, '/', $lang, '/labels.xml'))/labels"/>
  <xsl:variable name="cv_data" select="document(concat('profiles/', $root_folder, '/', $lang,'/',$data))/curriculum"/>

  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4" page-height="29.7cm" page-width="21cm" margin="{$margine-pagina}">
          <fo:region-body/>
          <fo:region-after extent=".0cm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="A4">
        <fo:flow flow-name="xsl-region-body">
          <xsl:call-template name="header">
            <xsl:with-param name="nome" select="$cv_data/dati-personali/nome"/>
            <xsl:with-param name="email" select="string(document(concat('profiles/', $root_folder, '/datipersonali.xml'))/dati-personali/email)" />
            <xsl:with-param name="telefono" select="string(document(concat('profiles/', $root_folder, '/datipersonali.xml'))/dati-personali/telefono)"/>
            <xsl:with-param name="luogo" select="string(document(concat('profiles/', $root_folder, '/datipersonali.xml'))/dati-personali/luogo)"/>
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

                    <xsl:call-template name="external-links">
                      <xsl:with-param name="title" select="$labels/external-links" />
                      <xsl:with-param name="links" select="$cv_data/link-esterni" />
                    </xsl:call-template>
                  </fo:block>
                </fo:table-cell>

                <fo:table-cell padding-left="{$spazio-colonne}">
                  <fo:block>
                    <xsl:call-template name="titolo-sezione">
                      <xsl:with-param name="testo" select="$labels/expertise" />
                    </xsl:call-template>
                    <fo:block text-align="center">
                      <fo:external-graphic>
                        <xsl:attribute name="src">
                          <xsl:value-of select="concat('url(', $cv_data/competenze/skillsspiderweb, ')')"/>
                        </xsl:attribute>
                        <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
                        <xsl:attribute name="width">60%</xsl:attribute>
                        <xsl:attribute name="height">auto</xsl:attribute>
                        <xsl:attribute name="space-after">10mm</xsl:attribute>

                        <title>
                          <xsl:value-of select="$labels/competenze/expertise-chart-title" />
                        </title>
                        <desc>
                          <xsl:value-of select="$cv_data/competenze/chart-description" />
                        </desc>
                      </fo:external-graphic>
                    </fo:block>

                    <xsl:call-template name="titolo-sezione">
                      <xsl:with-param name="testo" select="$labels/certificates" />
                    </xsl:call-template>
                    <xsl:for-each select="$cv_data/competenze/certificates/item">
                      <fo:block font-size="{$font-size-small}" color="{$colore-secondario}">
                        <fo:inline font-family="FontAwesome" padding-right="1mm">&#xf005;</fo:inline><xsl:value-of select="."/>
                      </fo:block>
                    </xsl:for-each>

                    <xsl:call-template name="skill-list">
                      <xsl:with-param name="label" select="$labels/hard-skills"/>
                      <xsl:with-param name="skill-ls" select="$cv_data/competenze/hardskills"/>
                    </xsl:call-template>
                    
                    <xsl:call-template name="skill-list">
                      <xsl:with-param name="label" select="$labels/soft-skills"/>
                      <xsl:with-param name="skill-ls" select="$cv_data/competenze/softskills"/>
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
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
</xsl:stylesheet>
