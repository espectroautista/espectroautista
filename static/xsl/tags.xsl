<?xml version="1.0" encoding="UTF-8"?>
<!--
 * tags.xsl - Genera <lang>-tags.xml
 *
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY XHTMLNS "http://www.w3.org/1999/xhtml">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:h="&XHTMLNS;"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:exsl="http://exslt.org/common"
	xmlns:set="http://exslt.org/sets"
	xmlns:str="http://exslt.org/strings"
	xmlns:dyn="http://exslt.org/dynamic"
  extension-element-prefixes="dyn exsl set str"
	exclude-result-prefixes="h x"
>

<xsl:import href="lib/xlib.xsl"/>

<xsl:output
	method="xml"
	encoding="UTF-8"
	indent="yes"
	version="1.0"
	omit-xml-declaration="no"
/>

<xsl:param name="sLang"/>

<xsl:variable name="Nodes" select="/descendant::outline[@tags = 'yes']"/>

<xsl:template match="/">
	<xsl:variable name="rPages">
		<xsl:call-template name="build-pages"/>
	</xsl:variable>
	<xsl:variable name="pages" select="exsl:node-set($rPages)/pages/page"/>

	<tags xml:lang="{$sLang}">
		<xsl:for-each select="set:distinct($pages/tag/@term)">
			<xsl:sort select="."/>

			<tag term="{.}" id="{parent::tag/@id}"
					 count="{count($pages/tag[@term = current()])}">
				<xsl:for-each select="$pages[tag/@term = current()]">
					<xsl:copy-of select="."/>
				</xsl:for-each>
			</tag>
		</xsl:for-each>
	</tags>

	<xsl:text>&#10;</xsl:text>
	<xsl:comment>
		vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
	</xsl:comment>
</xsl:template>

<xsl:template name="build-pages">
	<pages>
		<xsl:for-each select="$Nodes[@tags = 'yes']">
			<xsl:sort select="@id"/>

			<xsl:variable name="filename" select="concat('../', @source)"/>
			<xsl:variable name="description"
				select="document($filename)/h:html/h:head/h:meta[@name = 'description']"/>
			<xsl:variable name="keywords"
				select="document($filename)/h:html/h:head/h:meta[@name = 'keywords']"/>
			<xsl:variable name="tokens"
				select="str:split($keywords/@content, ',')"/>

			<page description="{$description/@content}" url="{@url}">
				<xsl:for-each select="dyn:map($tokens, 'normalize-space()')">
					<xsl:sort select="."/>

					<tag term="{.}" id="{x:makeID(.)}"/>
				</xsl:for-each>
			</page>
		</xsl:for-each>
	</pages>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
