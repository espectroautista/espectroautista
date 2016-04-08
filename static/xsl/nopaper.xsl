<?xml version="1.0" encoding="UTF-8"?>
<!--
 * nopaper.xsl - 
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY NL "&#10;">
	<!ENTITY TB "&#9;">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:bib="http://espectroautista.info/ns/bib"
>

<xsl:output
	method="text"
	encoding="UTF-8"
/>

<xsl:template match="/">
	<xsl:for-each select="bib:bib/*[not(bib:url)]">
		<xsl:value-of select="bib:title"/>
		<xsl:text>&NL;</xsl:text>
	</xsl:for-each>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
