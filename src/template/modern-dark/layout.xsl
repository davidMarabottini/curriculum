<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:import href="../../constants/index.xsl"/>
  <xsl:import href="../../components/index.xsl"/>
  <xsl:import href="./template.xsl" />
  
  <xsl:template name="layout-modern-dark">
    <xsl:param name="cv_data"/>
    <xsl:param name="labels"/>
    <xsl:param name="dati_personali"/>
    
    <fo:layout-master-set>
      <fo:simple-page-master master-name="modern-dark-page"
                             page-height="29.7cm" page-width="21cm"
        >
        
        <fo:region-body />
      </fo:simple-page-master>
    </fo:layout-master-set>
    
    <fo:page-sequence master-reference="modern-dark-page">
      <fo:flow flow-name="xsl-region-body">
        <fo:table table-layout="fixed" width="100%" border-collapse="collapse" border-spacing="0pt">
          
          <fo:table-column column-width="35%"/>
          <fo:table-column column-width="65%"/>
          
          <fo:table-header>
            <fo:table-row height="10px">
              <fo:table-cell background-color="{$colore-sidebar}" padding="0pt" border="0pt">
                <fo:block margin="0pt" padding="0pt" />
              </fo:table-cell>
              <fo:table-cell padding="0pt" border="0pt">
                <fo:block margin="0pt" padding="0pt"/>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-header>
          
          <fo:table-footer>
            <fo:table-row height="10px">
              <fo:table-cell background-color="{$colore-sidebar}" padding="0pt" border="0pt">
                <fo:block margin="0pt" padding="0pt"/>
              </fo:table-cell>
              <fo:table-cell padding="0pt" border="0pt">
                <fo:block margin="0pt" padding="0pt"/>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-footer>
          
          <fo:table-body padding-top="{$spaziatura-dettaglio}" padding-bottom="{$spaziatura-dettaglio}">
            <fo:table-row>
              <fo:table-cell background-color="{$colore-sidebar}" padding="8mm">
                <fo:block>
                  <xsl:call-template name="modern-dark-sidebar">
                    <xsl:with-param name="cv_data" select="$cv_data"/>
                    <xsl:with-param name="labels" select="$labels"/>
                    <xsl:with-param name="dati_personali" select="$dati_personali"/>
                  </xsl:call-template>
                </fo:block>
              </fo:table-cell>
              
              <fo:table-cell padding="8mm">
                <fo:block>
                  <xsl:call-template name="modern-dark-main">
                    <xsl:with-param name="cv_data" select="$cv_data"/>
                    <xsl:with-param name="labels" select="$labels"/>
                  </xsl:call-template>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>
  
</xsl:stylesheet>
