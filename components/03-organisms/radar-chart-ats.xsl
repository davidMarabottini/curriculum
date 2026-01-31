<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:fo="http://www.w3.org/1999/XSL/Format"
>
     <xsl:import href="../../constants/index.xsl"/>
     <xsl:import href="../01-atoms/titolo-sezione.xsl"/>
     
     <xsl:template name="radar-chart-ats">
          <xsl:param name="label" />
          <xsl:param name="chart-description" />
          
          <fo:block>
               <xsl:call-template name="titolo-sezione">
                    <xsl:with-param name="testo" select="$label" />
               </xsl:call-template>
               <fo:block font-size="{$font-size-small}">
                    <xsl:value-of select="$chart-description" />
               </fo:block>
          </fo:block>
     </xsl:template>
</xsl:stylesheet>

