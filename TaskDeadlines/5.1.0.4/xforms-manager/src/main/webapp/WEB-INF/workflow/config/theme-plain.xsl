<!--
    Copyright (C) 2006 Orbeon, Inc.

    This program is free software; you can redistribute it and/or modify it under the terms of the
    GNU Lesser General Public License as published by the Free Software Foundation; either version
    2.1 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
    without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU Lesser General Public License for more details.

    The full text of the license is available at http://www.gnu.org/copyleft/lesser.html
-->
<!--
    This is a very simple theme that shows you how to create a common layout for all your pages. You
    can modify it at will.
-->
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="http://orbeon.org/oxf/xml/formatting"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:xforms="http://www.w3.org/2002/xforms"
    xmlns:xxforms="http://orbeon.org/oxf/xml/xforms">


    <!-- - - - - - - Themed page template - - - - - - -->
    <xsl:template match="/">
        <xhtml:html>
            <xhtml:head>
                <!-- Standard scripts/styles -->
                <!-- NOTE: The XForms engine may place additional scripts and stylesheets here as needed -->
                <xhtml:link rel="stylesheet" href="/config/theme/orbeon.css" type="text/css"/>
                <!-- Handle head elements -->
                <xsl:for-each select="/xhtml:html/xhtml:head/(xhtml:meta | xhtml:link | xhtml:style | xhtml:script)">
                    <xsl:element name="xhtml:{local-name()}" namespace="{namespace-uri()}">
                        <xsl:copy-of select="@*"/>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:for-each>
                <!-- Title -->
                <xhtml:title>
                    <xsl:choose>
                        <xsl:when test="/xhtml:html/xhtml:head/xhtml:title != ''">
                            <xsl:value-of select="/xhtml:html/xhtml:head/xhtml:title"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="(/xhtml:html/xhtml:body/xhtml:h1)[1]"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xhtml:title>
                <!-- Orbeon Forms version -->
                <!--<xhtml:meta name="generator" content="Orbeon Forms {$orbeon-forms-version}"/>-->
            </xhtml:head>
            <xhtml:body>
                <!-- Copy body attributes -->
                <xsl:apply-templates select="/xhtml:html/xhtml:body/@*"/>
                <!-- Copy body -->
                <xsl:apply-templates select="/xhtml:html/xhtml:body/node()"/>
            </xhtml:body>
        </xhtml:html>
    </xsl:template>

    <!-- - - - - - - XForms adjustments (should probably be native) - - - - - - -->

    <!-- Populate content of loading indicator -->
    <xsl:template match="xhtml:span[tokenize(@class, ' ') = 'xforms-loading-loading']">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            Loading...
        </xsl:copy>
    </xsl:template>

    <!-- - - - - - - Generic copy rules - - - - - - -->

    <!-- Copy attributes in XHTML namespace to no namespace -->
    <xsl:template match="@xhtml:*">
        <xsl:attribute name="{local-name()}">
            <xsl:value-of select="."/>
            <xsl:message>Got XHTML attribute: <xsl:value-of select="concat(local-name(), '=', .)"/></xsl:message>
        </xsl:attribute>
    </xsl:template>

    <!-- Simply copy everything that's not matched -->
    <xsl:template match="@*|node()" priority="-2">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
