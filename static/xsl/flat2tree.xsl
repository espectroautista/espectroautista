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

<xsl:template match="/">
	<!-- DirectoryIndex -->
	<xsl:text>/index.html&TB;/&NL;</xsl:text>
	<!-- files -->
	<xsl:for-each select="/descendant::outline[@xid != '/']">
		<xsl:text>/</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:if test="@suffix = 'lang'">
			<xsl:text>-</xsl:text>
			<xsl:value-of select="$sLang"/>
		</xsl:if>
		<xsl:text>.html&TB;</xsl:text>
		<xsl:call-template name="build-path">
			<xsl:with-param name="step" select="."/>
		</xsl:call-template>
		<xsl:text>&NL;</xsl:text>
	</xsl:for-each>
</xsl:template>

<xsl:template name="build-path">
		<xsl:param name="step"/>
		<xsl:choose>
			<xsl:when test="$step/parent::outline[@xid = '/']">
				<xsl:text>/</xsl:text>
				<xsl:value-of select="$step/@xid"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="build-path">
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
