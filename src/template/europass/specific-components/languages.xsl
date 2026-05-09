<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:import href="../../../constants/index.xsl"/>
  
  <xsl:template name="europass__languages">
    <xsl:param name="label" />
    <xsl:param name="langs" /> <fo:table table-layout="fixed" width="100%" margin-top="5mm" margin-bottom="3mm">
      <fo:table-column column-width="30%"/>
      <fo:table-column column-width="70%"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell><fo:block/></fo:table-cell>
          <fo:table-cell padding-left="5mm" border-left="3pt solid #0055a4">
            <fo:block font-size="11pt" font-weight="bold" color="#0055a4" text-transform="uppercase">
              <xsl:value-of select="$label" />
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
    
    <xsl:for-each select="$langs">
      <fo:table table-layout="fixed" width="100%" space-after="3mm">
        <fo:table-column column-width="30%"/>
        <fo:table-column column-width="70%"/>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell padding-right="5mm" text-align="right">
              <fo:block font-size="10pt" font-weight="bold" color="#666666">
                <xsl:value-of select="nome"/>
              </fo:block>
            </fo:table-cell>
            
            <fo:table-cell padding-left="5mm" border-left="0.5pt solid #cccccc">
              <fo:block font-size="10pt" color="#333333">
                <xsl:choose>
                  <xsl:when test="valore = 5 or livello = 'Madrelingua'">
                    <fo:inline font-weight="bold">Madrelingua</fo:inline>
                  </xsl:when>
                  <xsl:otherwise>
                    <fo:inline font-weight="bold"><xsl:value-of select="livello"/></fo:inline>
                    <fo:inline font-size="8pt" color="#666666" font-style="italic"> (Utente avanzato/intermedio)</fo:inline>
                  </xsl:otherwise>
                </xsl:choose>
              </fo:block>
              
              <!-- <xsl:if test="url">
                <fo:block font-size="8pt" color="#0055a4" margin-top="1mm">
                  <fo:basic-link external-destination="url('{url}')">
                    <xsl:value-of select="url"/>
                  </fo:basic-link>
                </fo:block>
              </xsl:if> -->
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </xsl:for-each>
    
  </xsl:template>
</xsl:stylesheet>