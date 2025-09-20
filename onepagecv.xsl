<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:param name="root_folder" select="'david_marabottini'"/>
  <xsl:param name="lang" select="'it'"/>
  <xsl:param name="data" select="'onepagecv.xml'"/>

  <xsl:variable name="labels" select="document(concat($root_folder, '/', $lang, '/labels.xml'))/labels"/>
  <xsl:variable name="cv_data" select="document(concat($root_folder, '/', $lang,'/',$data))/curriculum"/> 

  <xsl:variable name="colore-principale" select="'#222'"/>
  <xsl:variable name="colore-secondario" select="'#555'"/>
  <xsl:variable name="colore-link" select="'#007acc'"/>
  
  <xsl:variable name="margine-pagina" select="'1cm'"/>
  <xsl:variable name="spaziatura-titolo-sezione" select="'5mm'"/>
  <xsl:variable name="spaziatura-dettaglio" select="'2mm'"/>
  <xsl:variable name="spaziatura-base" select="'2mm'"/>
  <xsl:variable name="spazio-colonne" select="'0.3cm'"/>

  <xsl:variable name="progressbar-width" select="'100'"/>
  <xsl:variable name="progressbar-height" select="'2'"/>

  <xsl:variable name="font-size-titolo-principale" select="'16pt'"/>
  <xsl:variable name="font-size-titolo-sezione" select="'12pt'"/>
  <xsl:variable name="font-size-sottotitolo" select="'10pt'"/>
  <xsl:variable name="font-size-base" select="'10pt'"/>
  <xsl:variable name="font-size-small" select="'8pt'"/>

  <xsl:template name="titolo-sezione">
    <xsl:param name="testo"/>
    <fo:block
      font-size="{$font-size-titolo-sezione}"
      font-weight="bold"
      color="{$colore-secondario}"
      space-after="3mm"
      border-bottom="1pt solid black"
      margin-top="{$spaziatura-titolo-sezione}"
    >
      <xsl:value-of select="$testo"/>
    </fo:block>
  </xsl:template>

  <xsl:template name="sottotitolo">
    <xsl:param name="testo"/>
    <fo:block
      font-weight="bold"
      font-size="{$font-size-sottotitolo}"
      color="{$colore-principale}"
    >
      <xsl:value-of select="$testo"/>
    </fo:block>
  </xsl:template>

  <xsl:template name="link">
    <xsl:param name="url"/>
    <xsl:param name="tipo"/>

    <fo:basic-link
      external-destination="{$url}"
      color="{$colore-link}"
      text-decoration="underline"
    >
      <xsl:value-of select="$tipo"/>
    </fo:basic-link>
  </xsl:template>

<xsl:template name="progress-bar">
  <xsl:param name="valore"/>

  <xsl:variable name="percent" select="number($valore) div 10"/> <!-- valore da 0 a 10 -->
  <xsl:variable name="perc100" select="$percent * 100"/> <!-- percentuale da 0 a 100 -->

  <!-- calcolo del colore in base alla percentuale -->
  <xsl:variable name="r" select="255 - floor(255 * $perc100 div 100)"/>
  <xsl:variable name="g" select="0"/>
  <xsl:variable name="b" select="floor(255 * $perc100 div 100)"/>

  <!-- conversione a stringa colore rgb -->
  <xsl:variable name="fillColor" select="concat('rgb(',$r,',',$g,',',$b,')')"/>

  <!-- calcolo larghezza riempita -->
  <xsl:variable name="width" select="$progressbar-width * $perc100 div 100"/>

  <fo:block>
    <fo:instream-foreign-object>
      <svg width="{$progressbar-width}" height="{$progressbar-height}" xmlns="http://www.w3.org/2000/svg">
        <!-- background grigio -->
        <rect x="0" y="0" width="{$progressbar-width}" height="{$progressbar-height}" fill="#e0e0e0"/>

        <!-- riempimento con colore calcolato -->
        <rect x="0" y="0" width="{$width}" height="{$progressbar-height}" fill="{$fillColor}"/>
      </svg>
    </fo:instream-foreign-object>
  </fo:block>
</xsl:template>

  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4" page-height="29.7cm" page-width="21cm" margin="{$margine-pagina}">
          <fo:region-body/>
          <fo:region-after extent=".2cm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      

      <fo:page-sequence master-reference="A4">
          <fo:static-content flow-name="xsl-region-after">
            <fo:block text-align="right" font-size="8pt" color="{$colore-secondario}">
              <xsl:value-of select="$labels/footer"/>
            </fo:block>
          </fo:static-content>

        <fo:flow flow-name="xsl-region-body">

          <fo:block-container text-align="center">
            <fo:block font-size="{$font-size-titolo-principale}" font-weight="bold" space-after="1mm" color="{$colore-principale}">
              <xsl:value-of select="$cv_data/dati-personali/nome"/>
            </fo:block>
            <fo:block font-size="{$font-size-base}" space-after="1mm" color="{$colore-secondario}">
              <!-- <xsl:value-of select="dati-personali/contatto"/> -->
              <xsl:value-of select="document(concat($root_folder, '/datipersonali.xml'))/dati-personali/email"/>
                <xsl:if
                  test="string(document(concat($root_folder, '/datipersonali.xml'))/dati-personali/email)
                  and string(document(concat($root_folder, '/datipersonali.xml'))/dati-personali/telefono)"
                >
                <xsl:text> | </xsl:text>
              </xsl:if>
              <xsl:value-of select="document(concat($root_folder, '/datipersonali.xml'))/dati-personali/telefono"/>
            </fo:block>
          </fo:block-container>

          <fo:table table-layout="fixed" width="100%" space-before="0.2cm">
            <fo:table-column column-width="66.6%"/>
            <fo:table-column column-width="33.4%"/>
            <fo:table-body>
              <fo:table-row>

                <fo:table-cell padding-right="{$spazio-colonne}">
                  <fo:block>
                    <xsl:call-template name="titolo-sezione">
                      <xsl:with-param name="testo" select="$labels/work-experience"/>
                    </xsl:call-template>
                    <xsl:for-each select="$cv_data/esperienze/esperienza">
                      <fo:block space-after="{$spaziatura-dettaglio}">
                        <xsl:call-template name="sottotitolo">
                          <xsl:with-param name="testo" select="titolo"/>
                        </xsl:call-template>
                        <fo:block font-size="{$font-size-small}" color="{$colore-secondario}">
                          <xsl:value-of select="azienda"/> | <xsl:value-of select="periodo"/>
                        </fo:block>
                        <xsl:for-each select="attivita/attivita-item">
                          <fo:block font-size="{$font-size-base}" margin-top="1mm" color="{$colore-principale}">
                            <xsl:value-of select="."/>
                          </fo:block>
                        </xsl:for-each>
                      </fo:block>
                    </xsl:for-each>

                    <fo:block margin-top="{$spaziatura-base}" font-size="{$font-size-small}">
                       <xsl:call-template name="link">
                        <xsl:with-param name="url" select="$cv_data/approfondimento-esperienze/url"/>
                        <xsl:with-param name="tipo" select="$cv_data/approfondimento-esperienze/label"/>
                      </xsl:call-template>
                    </fo:block>

                    <xsl:call-template name="titolo-sezione">
                      <xsl:with-param name="testo" select="$labels/education" />
                    </xsl:call-template>
                    <xsl:for-each select="$cv_data/formazione/corso-studio">
                      <fo:block space-after="{$spaziatura-dettaglio}">
                        <xsl:call-template name="sottotitolo">
                          <xsl:with-param name="testo" select="titolo"/>
                        </xsl:call-template>
                        <fo:block font-size="{$font-size-base}" color="{$colore-secondario}">
                          <xsl:value-of select="ente"/> | <xsl:value-of select="anno"/>
                        </fo:block>
                      </fo:block>
                    </xsl:for-each>

                    <fo:block margin-top="{$spaziatura-base}" font-size="{$font-size-small}" >
                       <xsl:call-template name="link">
                        <xsl:with-param name="url" select="$cv_data/approfondimento-formazione/url"/>
                        <xsl:with-param name="tipo" select="$cv_data/approfondimento-formazione/label"/>
                      </xsl:call-template>
                    </fo:block>
                  </fo:block>

                  <xsl:call-template name="titolo-sezione">
                      <xsl:with-param name="testo" select="$labels/external-links" />
                    </xsl:call-template>
                    <fo:block margin-top="{$spaziatura-base}">
                      <xsl:for-each select="$cv_data/link-esterni/link">
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
                </fo:table-cell>

                <fo:table-cell padding-left="{$spazio-colonne}">
                  <fo:block>
                    <xsl:call-template name="titolo-sezione">
                      <xsl:with-param name="testo" select="$labels/expertise" />
                    </xsl:call-template>
                    <fo:block>
                      <!-- <fo:external-graphic src="url('./skills_chart.svg')" content-width="scale-to-fit" width="100%" height="auto" space-after="10mm"/> -->
                      <fo:external-graphic>
                        <xsl:attribute name="src">
                          <xsl:value-of select="concat('url(', $cv_data/competenze/skillsspiderweb, ')')"/>
                        </xsl:attribute>
                        <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
                        <xsl:attribute name="width">100%</xsl:attribute>
                        <xsl:attribute name="height">auto</xsl:attribute>
                        <xsl:attribute name="space-after">10mm</xsl:attribute>
                      </fo:external-graphic>
                    </fo:block>

                    <xsl:call-template name="titolo-sezione">
                      <xsl:with-param name="testo" select="$labels/certificates" />
                    </xsl:call-template>
                    <xsl:for-each select="$cv_data/competenze/certificates/item">
                      <fo:block font-size="{$font-size-base}" color="{$colore-secondario}">
                        <xsl:value-of select="."/>
                      </fo:block>
                    </xsl:for-each>

                    <xsl:call-template name="titolo-sezione">
                      <xsl:with-param name="testo" select="$labels/hard-skills" />
                    </xsl:call-template>
                    <xsl:for-each select="$cv_data/competenze/hardskills/hardskill">
                      <fo:block font-size="{$font-size-base}" color="{$colore-secondario}" space-after="2.1mm" space-before="0" line-height="0.7">
                        <xsl:value-of select="item"/>
                        <xsl:call-template name="progress-bar">
                          <xsl:with-param name="valore" select="valore" />
                        </xsl:call-template>
                      </fo:block>
                    </xsl:for-each>

                    <xsl:call-template name="titolo-sezione">
                      <xsl:with-param name="testo" select="$labels/soft-skills" />
                    </xsl:call-template>
                    <xsl:for-each select="$cv_data/competenze/softskills/softskill">
                      <fo:block font-size="{$font-size-base}" color="{$colore-secondario}" space-after="2.1mm" space-before="0" line-height="0.7">
                        <xsl:value-of select="item"/>
                        <xsl:call-template name="progress-bar">
                          <xsl:with-param name="valore" select="valore" />
                        </xsl:call-template>
                      </fo:block>
                    </xsl:for-each>

                    <xsl:call-template name="titolo-sezione">
                      <xsl:with-param name="testo" select="$labels/languages" />
                    </xsl:call-template>
                    <xsl:for-each select="$cv_data/lingue/lingua">
                      <fo:block font-size="{$font-size-base}" space-after="{$spaziatura-dettaglio}">
                        <xsl:call-template name="sottotitolo">
                          <xsl:with-param name="testo" select="nome"/>
                        </xsl:call-template>
                        <fo:block font-size="{$font-size-base}" color="{$colore-secondario}">
                          <xsl:value-of select="livello"/>
                        </fo:block>
                      </fo:block>
                    </xsl:for-each>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

</xsl:stylesheet>