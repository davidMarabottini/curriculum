<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  
  <xsl:import href="../../../constants/index.xsl"/>
  
  <xsl:template name="europass__skill-list">
    <xsl:param name="label" />
    <xsl:param name="skill-ls" />
    
    <fo:table table-layout="fixed" width="100%" margin-top="8mm" margin-bottom="4mm">
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
    
    <xsl:choose>
      <xsl:when test="$skill-ls/area">
        <xsl:for-each select="$skill-ls/area">
          <fo:table table-layout="fixed" width="100%" space-after="4mm">
            <fo:table-column column-width="30%"/>
            <fo:table-column column-width="70%"/>
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell padding-right="5mm" text-align="right">
                  <fo:block font-size="9pt" font-weight="bold" color="#666666" text-transform="uppercase" margin-top="1mm">
                    <xsl:value-of select="name"/>
                  </fo:block>
                </fo:table-cell>
                
                <fo:table-cell padding-left="5mm" border-left="0.5pt solid #cccccc">
                  <fo:block font-size="9pt" color="#333333">
                    <xsl:for-each select="skills/hardskill">
                      <fo:inline><xsl:value-of select="item"/></fo:inline>
                      <xsl:if test="position() != last()">
                        <fo:inline color="#cccccc"> | </fo:inline>
                      </xsl:if>
                    </xsl:for-each>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </xsl:for-each>
      </xsl:when>
      
      <xsl:otherwise>
        <fo:table table-layout="fixed" width="100%">
          <fo:table-column column-width="30%"/>
          <fo:table-column column-width="70%"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell><fo:block/></fo:table-cell>
              <fo:table-cell padding-left="5mm" border-left="0.5pt solid #cccccc">
                <fo:block font-size="9pt" color="#333333">
                  <xsl:for-each select="$skill-ls/softskill">
                    <fo:inline><xsl:value-of select="item"/></fo:inline>
                    <xsl:if test="position() != last()">
                      <fo:inline color="#cccccc"> | </fo:inline>
                    </xsl:if>
                  </xsl:for-each>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>