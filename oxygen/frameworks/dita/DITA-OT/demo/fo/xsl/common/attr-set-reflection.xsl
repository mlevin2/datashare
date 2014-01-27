<?xml version='1.0'?>

<!-- 
Copyright © 2004-2005 by Idiom Technologies, Inc. All rights reserved. 
IDIOM is a registered trademark of Idiom Technologies, Inc. and WORLDSERVER
and WORLDSTART are trademarks of Idiom Technologies, Inc. All other 
trademarks are the property of their respective owners. 

IDIOM TECHNOLOGIES, INC. IS DELIVERING THE SOFTWARE "AS IS," WITH 
ABSOLUTELY NO WARRANTIES WHATSOEVER, WHETHER EXPRESS OR IMPLIED,  AND IDIOM
TECHNOLOGIES, INC. DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING
BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
PURPOSE AND WARRANTY OF NON-INFRINGEMENT. IDIOM TECHNOLOGIES, INC. SHALL NOT
BE LIABLE FOR INDIRECT, INCIDENTAL, SPECIAL, COVER, PUNITIVE, EXEMPLARY,
RELIANCE, OR CONSEQUENTIAL DAMAGES (INCLUDING BUT NOT LIMITED TO LOSS OF 
ANTICIPATED PROFIT), ARISING FROM ANY CAUSE UNDER OR RELATED TO  OR ARISING 
OUT OF THE USE OF OR INABILITY TO USE THE SOFTWARE, EVEN IF IDIOM
TECHNOLOGIES, INC. HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. 

Idiom Technologies, Inc. and its licensors shall not be liable for any
damages suffered by any person as a result of using and/or modifying the
Software or its derivatives. In no event shall Idiom Technologies, Inc.'s
liability for any damages hereunder exceed the amounts received by Idiom
Technologies, Inc. as a result of this transaction.

These terms and conditions supersede the terms and conditions in any
licensing agreement to the extent that such terms and conditions conflict
with those set forth herein.

This file is part of the DITA Open Toolkit project hosted on Sourceforge.net. 
See the accompanying license.txt file for applicable licenses.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version='1.0'>

    <xsl:template name="processAttrSetReflection">
        <xsl:param name="attrSet"/>
        <xsl:param name="path"/>
        <xsl:choose>
            <xsl:when test="document('cfg:fo/attrs/custom.xsl')//xsl:attribute-set[@name = $attrSet]">
                <xsl:apply-templates select="document('cfg:fo/attrs/custom.xsl')//xsl:attribute-set[@name = $attrSet]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="document($path)//xsl:attribute-set[@name = $attrSet]"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="xsl:attribute-set">

        <xsl:if test="@use-attribute-sets">
            <xsl:call-template name="processNestedAttrSets">
                <xsl:with-param name="setNames" select="normalize-space(@use-attribute-sets)"/>
            </xsl:call-template>
        </xsl:if>

        <xsl:for-each select="xsl:attribute">
            <xsl:attribute name="{@name}">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="processNestedAttrSets">
        <xsl:param name="setNames"/>
        <xsl:choose>
            <xsl:when test="contains($setNames, ' ')">
                <xsl:apply-templates select="//xsl:attribute-set[@name = substring-before($setNames, ' ')]"/>
                <xsl:call-template name="processNestedAttrSets">
                    <xsl:with-param name="setNames" select="substring-after($setNames, ' ')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="//xsl:attribute-set[@name = $setNames]"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>