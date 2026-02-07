<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date"
  >
  
  <xsl:import href="../../constants/index.xsl"/>
  <xsl:import href="../../components/index.xsl"/>
  <xsl:import href="./template.xsl" />
  
  <xsl:template name="layout-human">
    
    <xsl:param name="cv_data"/>
    <xsl:param name="labels"/>
    <xsl:param name="dati_personali"/>
    
    <fo:layout-master-set>
      <fo:simple-page-master
        master-name="human-page"
        page-height="29.7cm"
        page-width="21cm"
        margin="{$margine-pagina}">
        <fo:region-body/>
      </fo:simple-page-master>
    </fo:layout-master-set>
    
    <fo:page-sequence master-reference="human-page">
      <fo:flow flow-name="xsl-region-body">
        
        <xsl:call-template name="human">
          <xsl:with-param name="cv_data" select="$cv_data"/>
          <xsl:with-param name="labels" select="$labels"/>
          <xsl:with-param name="dati_personali" select="$dati_personali"/>
        </xsl:call-template>
        
      </fo:flow>
    </fo:page-sequence>
    
  </xsl:template>

</xsl:stylesheet>
