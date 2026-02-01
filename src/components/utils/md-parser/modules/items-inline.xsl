<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <xsl:import href="./format-inline.xsl"/>
    
        <xsl:template name="parse-list-items-inline">
        <xsl:param name="text"/>
        <xsl:param name="delimiter"/>
        
        <xsl:choose>
            <xsl:when test="contains($text, $delimiter)">
                <fo:list-item>
                    <fo:list-item-label end-indent="after">
                        <fo:block text-align="end" font-size="1.2em" line-height="0.8"> • </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="label-end()">
                        <fo:block>
                            <xsl:call-template name="parse-inline-format">
                                <xsl:with-param name="text" select="normalize-space(substring-before($text, $delimiter))"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
                <xsl:call-template name="parse-list-items-inline">
                    <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
                    <xsl:with-param name="delimiter" select="$delimiter"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="normalize-space($text) != ''">
                <fo:list-item>
                    <fo:list-item-label end-indent="after">
                        <fo:block text-align="end" font-size="1.2em" line-height="0.8"> • </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="label-end()">
                        <fo:block>
                            <xsl:call-template name="parse-inline-format">
                                <xsl:with-param name="text" select="normalize-space($text)"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>