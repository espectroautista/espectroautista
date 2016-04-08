<?xml version="1.0" encoding="UTF-8"?>
<!--
 * error.xsl - Gestión de errores
 *
-->
<!DOCTYPE xsl:transform [
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<!--
 ! 
 !-->
<xsl:template name="error.assert">
	<xsl:param name="test"/>
	<xsl:param name="text"/>

	<xsl:if test="not($test)">
		<xsl:message terminate="yes">
			<xsl:text>assertion failed(/</xsl:text>
			<xsl:value-of select="name(/*)"/>
			<xsl:text>/@id='</xsl:text>
			<xsl:value-of select="/*/@id"/>
			<xsl:text>'): </xsl:text>
			<xsl:value-of select="$text"/>
			<xsl:text>&#10;</xsl:text>
		</xsl:message>
	</xsl:if>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template name="error.terminate">
	<xsl:param name="text"/>

	<xsl:message terminate="yes">
		<xsl:text>error(/</xsl:text>
		<xsl:value-of select="name(/*)"/>
		<xsl:text>/@id='</xsl:text>
		<xsl:value-of select="/*/@id"/>
		<xsl:text>'): </xsl:text>
		<xsl:value-of select="$text"/>
		<xsl:text>&#10;</xsl:text>
	</xsl:message>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
