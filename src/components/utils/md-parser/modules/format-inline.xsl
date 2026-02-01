<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:template name="parse-inline-format">
        <xsl:param name="text"/>
        <xsl:variable name="bold-delimiter" select="'**'"/>
        <xsl:variable name="link-start" select="'['"/>
        <xsl:variable name="pos-bold" select="substring-before(concat($text, $bold-delimiter), $bold-delimiter)"/>
        <xsl:variable name="pos-link" select="substring-before(concat($text, $link-start), $link-start)"/>
    
        <xsl:choose>
            <xsl:when test="not(contains($text, $bold-delimiter) or contains($text, $link-start))">
                <xsl:value-of select="$text"/>
            </xsl:when>

            <xsl:when test="string-length($pos-bold) &lt; string-length($pos-link) and contains($text, $bold-delimiter)">
                <xsl:value-of select="substring-before($text, $bold-delimiter)"/>
                
                <xsl:variable name="rest" select="substring-after($text, $bold-delimiter)"/>
                
                <xsl:if test="contains($rest, $bold-delimiter)">
                    <fo:inline font-weight="bold">
                        <xsl:value-of select="substring-before($rest, $bold-delimiter)"/>
                    </fo:inline>
                    <xsl:call-template name="parse-inline-format">
                        <xsl:with-param name="text" select="substring-after($rest, $bold-delimiter)"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>

            <xsl:when test="string-length($pos-link) &lt;= string-length($pos-bold) and contains($text, $link-start)">
                
                <xsl:variable name="link-end-tag" select="']('"/>
                <xsl:variable name="url-end-tag" select="')'"/>
                
                <xsl:if test="contains(substring-after($text, $link-start), $link-end-tag) and contains(substring-after(substring-after($text, $link-start), $link-end-tag), $url-end-tag)">
                
                    <xsl:value-of select="substring-before($text, $link-start)"/>
                    
                    <xsl:variable name="link-content-start" select="substring-after($text, $link-start)"/>
                    <xsl:variable name="link-text" select="substring-before($link-content-start, $link-end-tag)"/>
                    
                    <xsl:variable name="link-url-start" select="substring-after($link-content-start, $link-end-tag)"/>
                    <xsl:variable name="link-url" select="substring-before($link-url-start, $url-end-tag)"/>
                    <xsl:variable name="link-remainder" select="substring-after($link-url-start, $url-end-tag)"/>
                    
                    <fo:basic-link external-destination="{$link-url}" color="blue">
                        <xsl:value-of select="$link-text"/>
                    </fo:basic-link>
                    
                    <xsl:call-template name="parse-inline-format">
                        <xsl:with-param name="text" select="$link-remainder"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>