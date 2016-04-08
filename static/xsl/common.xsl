<?xml version="1.0" encoding="UTF-8"?>
<!--
 * common.xsl - Genera common.mak
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY NL "&#10;">
	<!ENTITY TB "&#9;">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:set="http://exslt.org/sets"
  extension-element-prefixes="set"
>

<xsl:output
	method="text"
	encoding="UTF-8"
/>

<xsl:template match="/">
	<xsl:text>TESTS=\&NL;</xsl:text>
	<xsl:apply-templates
				select="/descendant::outline[@data = 'yes']"
				mode="tests">
		<xsl:sort select="@id"/>
	</xsl:apply-templates>
	<xsl:text>&NL;</xsl:text>

	<xsl:text>STYLESHEETS=\&NL;</xsl:text>
	<xsl:apply-templates
			select="set:distinct(
				/descendant::outline[@kind != 'likert' and @kind != 'choice']/@kind
			)"
			mode="stylesheets">
		<xsl:sort select="."/>
	</xsl:apply-templates>
	<xsl:apply-templates
			select="descendant::outline[@kind = 'likert' or @kind = 'choice']/@id"
			mode="stylesheets">
		<xsl:sort select="."/>
	</xsl:apply-templates>
	<xsl:text>&NL;</xsl:text>
</xsl:template>

<xsl:template match="outline" mode="tests">
	<xsl:text>&TB;</xsl:text>
	<xsl:value-of select="substring-before(@filename, '-')"/>
	<xsl:text>\&NL;</xsl:text>
</xsl:template>

<xsl:template match="@kind|@id" mode="stylesheets">
	<xsl:text>&TB;</xsl:text>
	<xsl:value-of select="concat('xsl/html/', ., '.xsl')"/>
	<xsl:text>\&NL;</xsl:text>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
