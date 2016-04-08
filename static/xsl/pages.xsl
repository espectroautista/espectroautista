<?xml version="1.0" encoding="UTF-8"?>
<!--
 * pages.xsl - Genera <lang>-pages.mak
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY NL "&#10;">
	<!ENTITY TB "&#9;">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:output
	method="text"
	encoding="UTF-8"
/>

<xsl:param name="sLang"/>

<!--
 !
 !-->
<xsl:template match="/">
	<xsl:text>PAGES_</xsl:text>
	<xsl:value-of select="$sLang"/>
	<xsl:text>=\&NL;</xsl:text>

	<xsl:apply-templates select="/descendant::outline">
		<xsl:sort select="@id"/>
	</xsl:apply-templates>
</xsl:template>

<!--
 !
 !-->
<xsl:template match="outline">
	<xsl:text>&TB;</xsl:text>
	<xsl:value-of select="@filename"/>
	<xsl:text>\&NL;</xsl:text>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
