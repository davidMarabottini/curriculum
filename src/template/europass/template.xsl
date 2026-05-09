<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:import href="../../constants/index.xsl"/>
  <xsl:import href="./specific-components/skill-list.xsl"/>
  <xsl:import href="./specific-components/certification.xsl"/>
  <xsl:import href="./specific-components/languages.xsl"/>
  
  <xsl:variable name="europass-blue" select="'#0055a4'"/> <xsl:variable name="europass-gray-text" select="'#3e3e3e'"/> <xsl:variable name="europass-gray-line" select="'#cccccc'"/> <xsl:variable name="europass-font-size-label" select="'9pt'"/>
  <xsl:variable name="europass-font-size-base" select="'10pt'"/>
  
  <xsl:template name="europass-layout">
    <xsl:param name="cv_data"/>
    <xsl:param name="labels"/>
    <xsl:param name="dati_personali"/>
    
    <fo:table table-layout="fixed" width="100%" space-after="10mm">
      <fo:table-column column-width="30%"/> <fo:table-column column-width="70%"/> <fo:table-body>
        <fo:table-row>
          <fo:table-cell padding-right="5mm" text-align="right">
            <xsl:if test="$cv_data/dati-personali/foto">
              <fo:block>
                <fo:external-graphic src="url({$cv_data/dati-personali/foto})" 
                                     content-width="30mm" content-height="30mm" 
                                     content-type="content-type:image/jpeg"/>
              </fo:block>
            </xsl:if>
            <fo:block font-size="16pt" font-weight="bold" color="{$europass-blue}" margin-top="3mm">
              <xsl:value-of select="$cv_data/dati-personali/nome"/>
            </fo:block>
          </fo:table-cell>
          
          <fo:table-cell border-left="0.5pt solid {$europass-gray-line}" padding-left="5mm" display-align="center">
            <fo:block font-size="{$europass-font-size-base}" color="{$europass-gray-text}" line-height="1.4">
              <xsl:if test="$dati_personali/indirizzo">
                <fo:block><xsl:value-of select="$dati_personali/indirizzo"/></fo:block>
              </xsl:if>
              <xsl:if test="$dati_personali/telefono">
                <fo:block font-weight="bold">
                  <fo:inline font-family="FontAwesome">&#xf095;</fo:inline>
                  <xsl:value-of select="$dati_personali/telefono"/>
                </fo:block>
              </xsl:if>
              <xsl:if test="$dati_personali/email">
                <fo:block>
                  <fo:inline font-family="FontAwesome">&#xf0e0;</fo:inline>
                  <xsl:value-of select="$dati_personali/email"/>
                </fo:block>
              </xsl:if>
              <!-- <xsl:if test="$cv_data/dati-personali/linkedin">
                <fo:block>
                  <fo:inline font-family="FontAwesome">&#xf08c;</fo:inline>
                  <xsl:value-of select="$cv_data/dati-personali/linkedin"/>
                </fo:block>
              </xsl:if> -->
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>

    <fo:table table-layout="fixed" width="100%" space-after="8mm">
      <fo:table-column column-width="30%"/> <fo:table-column column-width="70%"/> <fo:table-body>
        <fo:table-row>
          <fo:table-cell><fo:block/></fo:table-cell>
          <fo:table-cell padding-left="5mm" border-left="0.5pt solid {$europass-gray-line}">
            <fo:block font-size="{$europass-font-size-base}" color="{$europass-gray-text}" font-style="italic">
              <xsl:value-of select="$cv_data/descrizione"/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
    
    
    <xsl:call-template name="europass-section-title">
      <xsl:with-param name="title" select="$labels/work-experience"/>
    </xsl:call-template>
    
    <xsl:for-each select="$cv_data/esperienze/item">
      <fo:table table-layout="fixed" width="100%" space-after="6mm">
        <fo:table-column column-width="30%"/> <fo:table-column column-width="70%"/> <fo:table-body>
          <fo:table-row>
            <fo:table-cell padding-right="5mm" text-align="right">
              <fo:block font-size="{$europass-font-size-label}" color="{$europass-gray-text}">
                <xsl:value-of select="periodo"/>
              </fo:block>
            </fo:table-cell>
            
            <fo:table-cell padding-left="5mm" border-left="0.5pt solid {$europass-gray-line}">
              <fo:block font-size="{$europass-font-size-base}" font-weight="bold" color="{$europass-blue}">
                <xsl:value-of select="titolo"/>
              </fo:block>
              <fo:block font-size="{$europass-font-size-base}" font-weight="bold" margin-top="1mm">
                <xsl:value-of select="azienda"/>
              </fo:block>
              <fo:block font-size="{$europass-font-size-base}" color="{$europass-gray-text}" margin-top="2mm">
                <!-- <xsl:value-of select="descrizione"/> -->
                <xsl:call-template name="parse-blocks-and-lists">
                  <xsl:with-param name="text" select="descrizione"/>
                </xsl:call-template>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </xsl:for-each>
    
    <xsl:if test="$cv_data/progetti-personali/item">
      <xsl:call-template name="europass-section-title">
        <xsl:with-param name="title" select="$labels/personal-projects"/>
      </xsl:call-template>
      
      <xsl:for-each select="$cv_data/progetti-personali/item">
        <fo:table table-layout="fixed" width="100%" space-after="6mm">
          <fo:table-column column-width="30%"/>
          <fo:table-column column-width="70%"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell padding-right="5mm" text-align="right">
                <fo:block font-size="{$europass-font-size-label}" color="{$europass-gray-text}">
                  <xsl:value-of select="periodo"/>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell padding-left="5mm" border-left="0.5pt solid {$europass-gray-line}">
                <fo:block font-size="{$europass-font-size-base}" font-weight="bold" color="{$europass-blue}">
                  <xsl:value-of select="titolo"/>
                </fo:block>
                <fo:block font-size="{$europass-font-size-base}" color="{$europass-gray-text}" margin-top="2mm">
                  <!-- <xsl:value-of select="descrizione"/> -->
                  <xsl:call-template name="parse-blocks-and-lists">
                    <xsl:with-param name="text" select="descrizione"/>
                  </xsl:call-template>
                </fo:block>
                <xsl:if test="url">
                  <fo:block font-size="9pt" color="{$europass-blue}" margin-top="1mm">
                    <fo:basic-link external-destination="url('{url}')">
                      <xsl:value-of select="url"/>
                    </fo:basic-link>
                  </fo:block>
                </xsl:if>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </xsl:for-each>
    </xsl:if>
    
    <xsl:call-template name="europass__certification">
      <xsl:with-param name="label" select="'Certificazioni'"/>
      <xsl:with-param name="certificates" select="$cv_data/competenze/certificates/item"/>
    </xsl:call-template>
    
    <xsl:if test="$cv_data/formazione/item">
      <xsl:call-template name="europass-section-title">
        <xsl:with-param name="title" select="$labels/education"/>
      </xsl:call-template>
      
      <xsl:for-each select="$cv_data/formazione/item">
        <fo:table table-layout="fixed" width="100%" space-after="6mm">
          <fo:table-column column-width="30%"/>
          <fo:table-column column-width="70%"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell padding-right="5mm" text-align="right">
                <fo:block font-size="{$europass-font-size-label}" color="{$europass-gray-text}">
                  <xsl:value-of select="periodo"/>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell padding-left="5mm" border-left="0.5pt solid {$europass-gray-line}">
                <fo:block font-size="{$europass-font-size-base}" font-weight="bold" color="{$europass-blue}">
                  <xsl:value-of select="titolo"/>
                </fo:block>
                <fo:block font-size="{$europass-font-size-base}" font-weight="bold" margin-top="1mm">
                  <xsl:value-of select="istituto"/>
                </fo:block>
                <xsl:if test="descrizione">
                  <!-- <fo:block font-size="{$font-size}" color="{$color}" margin-top="{$margin-top}"> -->
                    <xsl:call-template name="parse-blocks-and-lists">
                      <xsl:with-param name="text" select="descrizione"/>
                    </xsl:call-template>
                  <!-- </fo:block> -->
                  <!-- <fo:block font-size="{$europass-font-size-base}" color="{$europass-gray-text}" margin-top="2mm">
                    <xsl:value-of select="descrizione"/>
                  </fo:block> -->
                </xsl:if>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </xsl:for-each>
    </xsl:if>
    
    <xsl:call-template name="europass__skill-list">
      <xsl:with-param name="label" select="$labels/hard-skills"/>
      <xsl:with-param name="skill-ls" select="$cv_data/competenze/hardskills"/>
    </xsl:call-template>
    
    <xsl:call-template name="europass__skill-list">
      <xsl:with-param name="label" select="$labels/soft-skills"/>
      <xsl:with-param name="skill-ls" select="$cv_data/competenze/softskills"/>
    </xsl:call-template>
    
    <xsl:call-template name="europass__languages">
      <xsl:with-param name="label" select="'Lingue'"/>
      <xsl:with-param name="langs" select="$cv_data/lingue/lingua"/>
    </xsl:call-template>
    
    <xsl:if test="$cv_data/link-esterni/link">
      <xsl:call-template name="europass-section-title">
        <xsl:with-param name="title" select="'Link ed Approfondimenti'"/>
      </xsl:call-template>
      
      <xsl:for-each select="$cv_data/link-esterni/link">
        <fo:table table-layout="fixed" width="100%" space-after="2mm">
          <fo:table-column column-width="30%"/>
          <fo:table-column column-width="70%"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell padding-right="5mm" text-align="right">
                <fo:block font-size="9pt" font-weight="bold" color="#666666" text-transform="uppercase">
                  <xsl:value-of select="tipo"/>
                </fo:block>
              </fo:table-cell>
              
              <fo:table-cell padding-left="5mm" border-left="0.5pt solid #cccccc">
                <fo:block font-size="9pt" color="#0055a4" text-decoration="underline">
                  <fo:basic-link external-destination="url('{url}')">
                    <xsl:value-of select="url"/>
                  </fo:basic-link>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </xsl:for-each>
    </xsl:if>
    
    <fo:table table-layout="fixed" width="100%" margin-top="15mm" space-after="5mm">
      <fo:table-column column-width="30%"/>
      <fo:table-column column-width="70%"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell>
            <fo:block/>
          </fo:table-cell>
          <fo:table-cell padding-left="5mm" border-left="0.5pt solid #cccccc">
            <fo:block font-size="8pt" color="#666666" text-align="justify" line-height="1.2">
              Autorizzo il trattamento dei dati personali contenuti nel mio curriculum vitae ai sensi e per gli effetti del 
              Decreto Legislativo 30 giugno 2003, n. 196 (Codice in materia di protezione dei dati personali) 
              e del Regolamento UE 2016/679 (GDPR). Dichiaro inoltre di aver preso visione dell'informativa 
              privacy relativa alla selezione del personale.
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
    
  </xsl:template>
  
  <xsl:template name="europass-section-title">
    <xsl:param name="title"/>
    <fo:table table-layout="fixed" width="100%" margin-top="5mm" margin-bottom="3mm">
      <fo:table-column column-width="30%"/>
      <fo:table-column column-width="70%"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell><fo:block/></fo:table-cell>
          <fo:table-cell padding-left="5mm" border-left="3pt solid {$europass-blue}">
            <fo:block font-size="12pt" font-weight="bold" color="{$europass-blue}" text-transform="uppercase">
              <xsl:value-of select="$title"/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>
  
  
  
</xsl:stylesheet>
