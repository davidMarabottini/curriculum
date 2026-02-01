<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:fo="http://www.w3.org/1999/XSL/Format"
>
     <xsl:import href="../../constants/index.xsl"/>
     <xsl:import href="../01-atoms/titolo-sezione.xsl"/>
     
     <xsl:template name="radar-chart">
          <xsl:param name="label" />
          <xsl:param name="spiderweb" />
          <xsl:param name="chat-title" />
          <xsl:param name="chart-description" />
          
          <fo:block>
               <xsl:call-template name="titolo-sezione">
                    <xsl:with-param name="testo" select="$label" />
               </xsl:call-template>
               <fo:block text-align="center">
                    <fo:external-graphic>
                         <xsl:attribute name="src">
                              <xsl:value-of select="concat('url(', $spiderweb, ')')"/>
                         </xsl:attribute>
                         <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
                         <xsl:attribute name="width">60%</xsl:attribute>
                         <xsl:attribute name="height">auto</xsl:attribute>
                         <xsl:attribute name="space-after">10mm</xsl:attribute>
                         
                         <title>
                              <xsl:value-of select="$chat-title" />
                         </title>
                         <desc>
                              <xsl:value-of select="$chart-description" />
                         </desc>
                    </fo:external-graphic>
               </fo:block>
          </fo:block>
     </xsl:template>
</xsl:stylesheet>

