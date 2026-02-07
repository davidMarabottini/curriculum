<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
>
  <xsl:import href="./src/template/index.xsl" />

  <xsl:param name="root_folder" select="'david_marabottini'"/>
  <xsl:param name="lang" select="'it'"/>
  <xsl:param name="data" select="'onepagecv.xml'"/>
  <xsl:param name="name_template" select="'human'" />
  
  <xsl:variable
    name="cur-profile"
    select="concat('profiles/', $root_folder, '/', $lang)"
  />

  <xsl:variable
    name="labels"
    select="document(concat($cur-profile, '/labels.xml'))/labels"
  />

  <xsl:variable
    name="cv_data"
    select="document(concat($cur-profile,'/',$data))/curriculum"
  />
  
  <xsl:variable
    name="dati_personali"
    select="document(concat('profiles/', $root_folder, '/datipersonali.xml'))/dati-personali"
  />
  
  <xsl:template match="/">
    <fo:root>
      <xsl:choose>
        <xsl:when test="$name_template = 'modern-dark'">
          <xsl:call-template name="layout-modern-dark">
            <xsl:with-param name="cv_data" select="$cv_data"/>
            <xsl:with-param name="labels" select="$labels"/>
            <xsl:with-param name="dati_personali" select="$dati_personali"/>
          </xsl:call-template>
        </xsl:when>
        
        <xsl:otherwise>
          <xsl:call-template name="layout-human">
            <xsl:with-param name="cv_data" select="$cv_data"/>
            <xsl:with-param name="labels" select="$labels"/>
            <xsl:with-param name="dati_personali" select="$dati_personali"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </fo:root>
  </xsl:template>
</xsl:stylesheet>
