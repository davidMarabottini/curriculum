<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
     >
     <xsl:import href="../../../constants/index.xsl"/>
     
     <xsl:template name="europass__certification">
          <xsl:param name="label" />
          <xsl:param name="certificates" /> <fo:table table-layout="fixed" width="100%" margin-top="5mm" margin-bottom="3mm">
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
          
          <xsl:for-each select="$certificates">
               <fo:table table-layout="fixed" width="100%" space-after="2mm">
                    <fo:table-column column-width="30%"/>
                    <fo:table-column column-width="70%"/>
                    <fo:table-body>
                         <fo:table-row>
                              <fo:table-cell padding-right="5mm" text-align="right">
                                   <fo:block font-size="9pt" font-family="FontAwesome" color="#666666"> </fo:block>
                              </fo:table-cell>
                              
                              <fo:table-cell padding-left="5mm" border-left="0.5pt solid #cccccc">
                                   <fo:block font-size="10pt" font-weight="bold" color="#333333">
                                        <xsl:value-of select="."/>
                                   </fo:block>
                              </fo:table-cell>
                         </fo:table-row>
                    </fo:table-body>
               </fo:table>
          </xsl:for-each>
          
     </xsl:template>
</xsl:stylesheet>