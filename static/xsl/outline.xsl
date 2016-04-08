<?xml version="1.0" encoding="UTF-8"?>
<!--
 * layout.xsl - Genera layout.xml para cada idioma
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../dtd/entities.dtd"> %ENTITIES;
	<!ENTITY BASELANG "es">
	<!ENTITY EXTENSION ".html">
	<!ENTITY NWORDS "30">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:h="&XHTMLNS;"
	xmlns:str="http://exslt.org/strings"
  extension-element-prefixes="str"
	exclude-result-prefixes="h"
>

<xsl:param name="lang"/>

<xsl:output
	doctype-system="../../dtd/layout.dtd"
	encoding="UTF-8"
	indent="yes"
	method="xml"
	version="1.0"
	omit-xml-declaration="no"
/>

<xsl:template match="/">
	<opml>
		<head><title>GENERATED OPML FILE. DON'T EDIT</title></head>
		<body>
			<xsl:apply-templates select="opml/body/outline"/>
		</body>
	</opml>
	<xsl:text>&#10;</xsl:text>
	<xsl:comment>
		vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
	</xsl:comment>
</xsl:template>

<xsl:template match="outline">
	<outline>
		<xsl:attribute name="page">
			<xsl:number count="outline" level="any"/>
		</xsl:attribute>

		<xsl:variable name="input"
			select="document(concat('../', $sLang, '/', @id, '.html'))"/>

		<xsl:attribute name="source">
			<xsl:value-of select="concat($sLang, '/', @id, '.html')"/>
		</xsl:attribute>

		<xsl:attribute name="filename">
			<xsl:choose>
				<xsl:when test="@suffix = 'lang' or ($sLang != '&BASELANG;')">
					<xsl:value-of select="concat(@id, '-', $sLang, '&EXTENSION;')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(@id, '&EXTENSION;')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

		<xsl:for-each select="@*[name() != 'suffix']">
			<xsl:copy/>
		</xsl:for-each>

		<!-- metadata -->
		<xsl:attribute name="url">
			<xsl:call-template name="build-path-url">
				<xsl:with-param name="step" select="."/>
			</xsl:call-template>
		</xsl:attribute>

		<xsl:attribute name="utf">
			<xsl:call-template name="build-path-utf">
				<xsl:with-param name="step" select="."/>
			</xsl:call-template>
		</xsl:attribute>

		<xsl:attribute name="text">
			<xsl:value-of select="$input/h:html/h:head/h:title"/>
		</xsl:attribute>

		<xsl:if test="'lecturas' = ancestor::outline/@id and not(*)">
			<xsl:attribute name="first-paragraph">
				<xsl:variable name="p"
						select="$input/h:html/h:body/h:p[1]"/>

				<xsl:for-each select="str:tokenize($p)[position() &lt;= &NWORDS;]">
					<xsl:value-of select="self::*"/>

					<xsl:if test="position() &lt; &NWORDS; and position() &lt; last()">
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:for-each>

				<xsl:text>&hellip;</xsl:text>
			</xsl:attribute>
		</xsl:if>

		<!-- recurse -->
		<xsl:apply-templates select="outline"/>
	</outline>
</xsl:template>

<xsl:template name="build-path-utf">
		<xsl:param name="step"/>
		<xsl:choose>
			<xsl:when test="not($step/parent::outline[@xid])">
				<xsl:text>/</xsl:text>
			</xsl:when>
			<xsl:when test="$step/parent::outline[@xid = '/']">
				<xsl:text>/</xsl:text>
				<xsl:value-of select="$step/@utf"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="build-path-utf">
					<xsl:with-param name="step" select="$step/parent::outline"/>
				</xsl:call-template>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="$step/@utf"/>
			</xsl:otherwise>
		</xsl:choose>
</xsl:template>

<xsl:template name="build-path-url">
		<xsl:param name="step"/>
		<xsl:choose>
			<xsl:when test="not($step/parent::outline[@xid])">
				<xsl:text>/</xsl:text>
			</xsl:when>
			<xsl:when test="$step/parent::outline[@xid = '/']">
				<xsl:text>/</xsl:text>
				<xsl:value-of select="$step/@xid"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="build-path-url">
					<xsl:with-param name="step" select="$step/parent::outline"/>
				</xsl:call-template>
				<xsl:text>/</xsl:text>
				<xsl:value-of select="$step/@xid"/>
			</xsl:otherwise>
		</xsl:choose>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
