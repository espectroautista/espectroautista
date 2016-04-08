<?xml version="1.0" encoding="UTF-8"?>
<!--
 * pubs.xsl - templates para página con lista de publicaciones.
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h tables x"
>

<xsl:import href="generic.xsl"/>

<xsl:template match="h:object[@class = 'pubs']">
	<xsl:variable name="pubs" select="
		document('pubadultos.html', /)/h:html/h:body/h:dl/h:dt/h:a[@id] |
		document('pubeduc.html', /)/h:html/h:body/h:dl/h:dt/h:a[@id] |
		document('pubfamiliares.html', /)/h:html/h:body/h:dl/h:dt/h:a[@id] |
		document('pubgeneral.html', /)/h:html/h:body/h:dl/h:dt/h:a[@id] |
		document('pubincl.html', /)/h:html/h:body/h:dl/h:dt/h:a[@id] |
		document('pubnas.html', /)/h:html/h:body/h:dl/h:dt/h:a[@id] |
		document('pubprof.html', /)/h:html/h:body/h:dl/h:dt/h:a[@id]
	"/>

	<ol style="width: 40em;">
		<xsl:for-each select="$pubs">
			<xsl:sort select="x:makeID(.)"/>

			<xsl:variable name="root" select="ancestor::*[last()]"/>
			<xsl:variable name="url" select="tables:outline($root/@id)/@url"/>

			<li>
				<a href="{$url}#{@id}">
					<xsl:value-of select="normalize-space(.)"/>
				</a>
			</li>
		</xsl:for-each>
	</ol>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
