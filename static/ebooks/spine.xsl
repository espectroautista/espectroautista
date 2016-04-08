<?xml version="1.0" encoding="UTF-8"?>
<!--
* spine.xsl - 
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

<!--
 !
 !-->
<xsl:template match="/">
	<xsl:apply-templates select="/descendant::outline[@id != 'error']"/>
</xsl:template>

<!--
 !
 !-->
<xsl:template match="outline">
	<xsl:text>&TB;&TB;&lt;itemref idref="</xsl:text>
	<xsl:value-of select="@filename"/>
	<xsl:text>" linear="</xsl:text>
	<xsl:choose>
		<xsl:when test="starts-with(@filename, 'bibautores_')
			or starts-with(@filename, 'palabras_')
			or starts-with(@filename, 'etiquetas_')">no</xsl:when>
		<xsl:otherwise>yes</xsl:otherwise>
	</xsl:choose>
	<xsl:text>"/&gt;&NL;</xsl:text>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
