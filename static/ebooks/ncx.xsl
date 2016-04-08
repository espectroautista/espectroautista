<?xml version="1.0" encoding="UTF-8"?>
<!--
 * ncx.xsl - 
 *
-->

<!DOCTYPE xsl:transform [
	<!ENTITY XMLNS "http://www.daisy.org/z3986/2005/ncx/">
	<!ENTITY XHTMLNS "http://www.w3.org/1999/xhtml">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XMLNS;"
	xmlns:h="&XHTMLNS;"
	xmlns:dyn="http://exslt.org/dynamic"
  xmlns:set="http://exslt.org/sets"
	extension-element-prefixes="dyn set"
	exclude-result-prefixes="h"
>

<xsl:output
	method="xml"
	omit-xml-declaration="no"
	version="1.0"
	encoding="UTF-8"
	doctype-public="-//NISO//DTD ncx 2005-1//EN"
	doctype-system="http://www.daisy.org/z3986/2005/ncx-2005-1.dtd"
	indent="yes"
/>

<!--
 !
 !-->
<xsl:template match="/">
	<ncx xmlns="&XMLNS;" version="2005-1">
		<head>
			<meta name="dtb:uid" content="EspectroAutista.Info"/>
			<meta name="dtb:depth" content="5"/>
			<meta name="dtb:totalPageCount" content="0"/>
			<meta name="dtb:maxPageNumber" content="0"/>
		</head>

		<docTitle><text>EspectroAutista.Info</text></docTitle>

		<navMap>
			<xsl:apply-templates select="opml/body/outline"/>

			<xsl:variable name="n" select="number(id('error')/@page)"/>

			<!-- index.html again -->
			<navPoint id="index.html2" playOrder="{$n}">
				<navLabel><text>Portada</text></navLabel>
				<content src="OPS/index.html"/>
			</navPoint>
			<navPoint id="ayuda.html2" playOrder="{$n + 1}">
				<navLabel><text>Ayuda</text></navLabel>
				<content src="OPS/ayuda.html"/>
			</navPoint>
			<navPoint id="etiquetas.html2" playOrder="{$n + 2}">
				<navLabel><text>Etiquetas</text></navLabel>
				<content src="OPS/etiquetas.html"/>
			</navPoint>
			<navPoint id="mapa.html2" playOrder="{$n + 3}">
				<navLabel><text>Mapa</text></navLabel>
				<content src="OPS/mapa.html"/>
			</navPoint>

			<!-- listings for each year -->
			<xsl:variable name="feeds" select="document('../es/index.html')/h:html/h:body/h:div[@class = 'hfeed']"/>

			<xsl:variable name="years" select="set:distinct(dyn:map($feeds/@id, 'substring(., 2, 4)'))"/>

			<xsl:for-each select="$years">
				<xsl:sort select="."/>

				<xsl:variable name="sYear" select="."/>

				<navPoint id="F{$sYear}.html" playOrder="{$n + (number($sYear)-2008+4)}">
					<navLabel><text><xsl:value-of select="concat($sYear, ' — archivo de noticias')"/></text></navLabel>

					<content src="OPS/F{$sYear}.html"/>
				</navPoint>
			</xsl:for-each>

		</navMap>
	</ncx>
</xsl:template>

<!--
 !
 !-->
<xsl:template match="outline">
	<navPoint id="{@filename}" playOrder="{@page}">
		<navLabel><text><xsl:value-of select="@text"/></text></navLabel>

		<content src="OPS/{@filename}"/>

		<xsl:apply-templates select="outline[@id != 'error']"/>
	</navPoint>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
