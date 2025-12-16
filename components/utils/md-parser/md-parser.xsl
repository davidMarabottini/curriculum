<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:import href="../../constants/spacing.xsl"/>
    <xsl:import href="modules/blocks.xsl"/>
    <!-- <xsl:include href="modules/items-inline.xsl"/> -->
    <!-- <xsl:include href="modules/format-inline.xsl"/> -->

    <xsl:param name="spaziatura-min"/>

    <xsl:template name="render-markdown-poc">
        <xsl:param name="text"/>
        <xsl:param name="font-size"/>
        <xsl:param name="color"/>
        <xsl:param name="margin-top" select="'1mm'"/>
        
        <fo:block font-size="{$font-size}" color="{$color}" margin-top="{$margin-top}">
            <xsl:call-template name="parse-blocks-and-lists">
                <xsl:with-param name="text" select="$text"/>
            </xsl:call-template>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>
