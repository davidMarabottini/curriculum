<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:import href="./format-inline.xsl"/>
    <xsl:import href="./items-inline.xsl"/>
    <xsl:import href="../../../../constants/spacing.xsl" />

    <xsl:template name="parse-blocks-and-lists">
        <xsl:param name="text"/>
        <xsl:variable name="list-delimiter-hyphen" select="'- '"/>
        <xsl:variable name="list-delimiter-star" select="'* '"/>
        <xsl:variable name="newline-delimiter" select="'&#xa;'"/>
        
        <xsl:choose>
            
            <xsl:when test="starts-with($text, $newline-delimiter)">
                <xsl:variable name="rest-of-text" select="substring-after($text, $newline-delimiter)"/>
                
                <xsl:choose>
                    <xsl:when test="normalize-space($rest-of-text) = '' or starts-with(normalize-space($rest-of-text), $newline-delimiter)">
                        <fo:block space-after="{$spaziatura-min}"/> 
                    </xsl:when>
                    <xsl:otherwise>
                        </xsl:otherwise>
                </xsl:choose>

                <xsl:call-template name="parse-blocks-and-lists">
                    <xsl:with-param name="text" select="$rest-of-text"/>
                </xsl:call-template>
            </xsl:when>
            
            <xsl:when test="starts-with($text, $list-delimiter-hyphen)">
                <fo:list-block provisional-distance-between-starts="5pt" provisional-label-separation="2pt">
                    <xsl:call-template name="parse-list-items-inline">
                        <xsl:with-param name="text" select="substring-after($text, $list-delimiter-hyphen)"/>
                        <xsl:with-param name="delimiter" select="'&#xa;-'"/>
                    </xsl:call-template>
                </fo:list-block>
            </xsl:when>
            
            <xsl:when test="starts-with($text, $list-delimiter-star)">
                <fo:list-block provisional-distance-between-starts="5pt" provisional-label-separation="2pt">
                    <xsl:call-template name="parse-list-items-inline">
                        <xsl:with-param name="text" select="substring-after($text, $list-delimiter-star)"/>
                        <xsl:with-param name="delimiter" select="'&#xa;*'"/>
                    </xsl:call-template>
                </fo:list-block>
            </xsl:when>
            
            <xsl:when test="contains($text, $newline-delimiter)">
                <fo:block space-after="{$spaziatura-min}">
                    <xsl:call-template name="parse-inline-format">
                        <xsl:with-param name="text" select="substring-before($text, $newline-delimiter)"/>
                    </xsl:call-template>
                </fo:block>
                <xsl:call-template name="parse-blocks-and-lists">
                    <xsl:with-param name="text" select="substring-after($text, $newline-delimiter)"/>
                </xsl:call-template>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:if test="normalize-space($text) != ''">
                    <fo:block>
                        <xsl:call-template name="parse-inline-format">
                            <xsl:with-param name="text" select="$text"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
            </xsl:otherwise>
            
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>