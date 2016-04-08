<?xml version="1.0" encoding="UTF-8"?>
<!--
 * textos.xsl - templates para página con lista de textos.
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
	<!ENTITY NWORDS "30">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	xmlns:p="urn:uuid:6871515c-a7f1-11dd-924d-001fc6576244"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="p h x tables"
>

<xsl:import href="generic.xsl"/>

<xsl:template match="h:object[@class = 'textos']">
	<xsl:variable name="id" select="/h:html/@id"/>
	<xsl:variable name="texts"
		select="$tables:Outline/opml/body/outline
						/outline[@id = 'lecturas']
						/descendant::outline
						[not(outline)
							and @tree = 'yes'
							and $id = ancestor::outline/@id]
		"/>

	<ol>
		<xsl:for-each select="$texts">
			<xsl:sort select="x:lower(x:makeID(@text))"/>

			<li>
				<a id="{@id}" href="{@url}">
					<xsl:value-of select="@text"/>
				</a>

				<xsl:if test="$id != 'lecturas'">
					<blockquote class="TextFragment">
						<p><xsl:value-of select="@first-paragraph"/></p>
					</blockquote>
				</xsl:if>

			</li>
		</xsl:for-each>
	</ol>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
