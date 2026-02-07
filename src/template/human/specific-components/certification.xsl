<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:fo="http://www.w3.org/1999/XSL/Format"
>
     <xsl:import href="../../../constants/index.xsl"/>
     <xsl:import href="../../../components/01-atoms/titolo-sezione.xsl"/>
     
     <xsl:template name="certification">
          <xsl:param name="label" />
          <xsl:param name="certificates" />
          
          <fo:block>
               <xsl:call-template name="titolo-sezione">
                    <xsl:with-param name="testo" select="$label" />
               </xsl:call-template>
               <xsl:for-each select="$certificates">
                    <fo:block font-size="{$font-size-small}" color="{$colore-secondario}">
                         <fo:inline font-family="FontAwesome" padding-right="1mm">&#xf005;</fo:inline><xsl:value-of select="."/>
                    </fo:block>
               </xsl:for-each>

          </fo:block>
     </xsl:template>
</xsl:stylesheet>

