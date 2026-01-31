<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="./template/index.xsl" />

  <xsl:param name="root_folder" select="'david_marabottini'"/>
  <xsl:param name="lang" select="'it'"/>
  <xsl:param name="data" select="'onepagecv.xml'"/>
  <xsl:param name="name_template" select="'human'" />

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
          <xsl:choose>
            <xsl:when test="$name_template = 'ats'">
              <xsl:call-template name="ats">
                <xsl:with-param name="cv_data" select="$cv_data"/>
                <xsl:with-param name="labels" select="$labels"/>
              </xsl:call-template>
            </xsl:when>
            
            <xsl:otherwise>
              <xsl:call-template name="human">
                <xsl:with-param name="cv_data" select="$cv_data"/>
                <xsl:with-param name="labels" select="$labels"/>
                <xsl:with-param name="root_folder" select="$root_folder"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
         </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
</xsl:stylesheet>
