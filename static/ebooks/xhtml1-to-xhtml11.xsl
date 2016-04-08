<?xml version="1.0" encoding="UTF-8"?>
<!--
 * xhtml1-to-xhtml11.xsl
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY FPI "-//W3C//DTD XHTML 1.1//EN">
	<!ENTITY XHTMLNS "http://www.w3.org/1999/xhtml">
	<!ENTITY ASCII-LOWER "abcdefghijklmnopqrstuvwxyz">
	<!ENTITY ASCII-UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ">
	<!ENTITY TO-UPPER "'&ASCII-LOWER;', '&ASCII-UPPER;'">
	<!ENTITY MIME "application/xhtml+xml">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	exclude-result-prefixes="h"
>

<xsl:output
	method="xml"
	omit-xml-declaration="no"
	version="1.0"
	encoding="UTF-8"
	doctype-public="&FPI;"
	doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11-flat.dtd"
	cdata-section-elements="script style"
	media-type="&MIME;"
	indent="no"
/>

<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ! root & document nodes
 !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
<xsl:template match="/">
	<xsl:apply-templates select="node()"/>
</xsl:template>

<xsl:template match="h:html">
	<html xmlns="&XHTMLNS;" version="&FPI;">
		<xsl:variable name="lang" select="string((@lang | @xml:lang)[1])"/>

		<xsl:if test="$lang">
			<xsl:attribute name="xml:lang">
				<xsl:value-of select="$lang"/>
			</xsl:attribute>
		</xsl:if>

		<xsl:apply-templates select="node()"/>
	</html>
</xsl:template>

<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ! head
 !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
<xsl:template match="h:head">
		<head>
			<xsl:apply-templates select="@*"/>

			<meta http-equiv="Content-Type" content="&MIME;; charset=UTF-8"/>

			<xsl:apply-templates select="node()"/>
		</head>
</xsl:template>

<xsl:template match="h:title">
			<title><xsl:value-of select="."/></title>
</xsl:template>

<xsl:template match="h:meta[translate(@http-equiv, &TO-UPPER;)
														= 'CONTENT-TYPE']">
	<!-- ignore -->
</xsl:template>

<xsl:template match="h:meta">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="h:link">
	<xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="h:script">
	<xsl:copy-of select="."/>
</xsl:template>

<!--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ! body
 !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-->
<xsl:template match="h:body">
		<body>
			<xsl:apply-templates select="@* | node()"/>
		</body>
</xsl:template>

<!--
 ! elements
 !-->
<xsl:template match="*">
	<xsl:copy>
		<xsl:apply-templates select="@* | node()"/>
	</xsl:copy>
</xsl:template>

<!--
 ! attributes
 !-->
<xsl:template match="h:a/@name | h:map/@name">
	<xsl:if test="not(../@id)">
		<xsl:attribute name="id">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:if>
	<!-- Warn if @name != @id ??? -->
</xsl:template>

<xsl:template match="@lang">
	<xsl:if test="not(../@xml:lang)">
		<xsl:attribute name="xml:lang">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="@*">
	<xsl:copy/>
</xsl:template>

<!--
 ! other node types
 !-->
<xsl:template match="comment() | processing-instruction() | text()">
	<xsl:copy/>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
