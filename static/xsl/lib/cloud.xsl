<?xml version="1.0" encoding="UTF-8"?>
<!--
 * tags.xsl - Tag Cloud
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
	<!ENTITY BASELANG "es">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns="&XHTMLNS;"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl"
	exclude-result-prefixes="tables x"
>

<xsl:import href="xlib.xsl"/>

<!--
 ! 
 !-->
<xsl:template name="cloud.tags">
	<xsl:param name="first-letter" select="false()"/>
	<xsl:param name="ntags" select="1 div 0"/>

	<div id="TagCloud">
		<!-- sorted by @count -->
		<xsl:variable name="rTags">
			<xsl:for-each select="$tables:Tags">
				<xsl:sort select="@count" data-type="number" order="descending"/>

				<xsl:if test="position() &lt; $ntags">
					<!--<xsl:if test="@count &gt; 4">-->
					<xsl:copy-of select="self::tag"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="tags" select="exsl:node-set($rTags)/tag"/>

		<xsl:for-each select="$tags">
			<xsl:sort select="x:lower(@term)"/>

			<xsl:variable name="c">
				<xsl:choose>
					<xsl:when test="(position() mod 2) != 0">EvenTag</xsl:when>
					<xsl:otherwise>OddTag</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="m" select="9"/>
			<xsl:variable name="q" select="1"/>
			<xsl:variable name="t" select="ceiling(@count div $q)"/>
			<xsl:variable name="s" select="$m + $t * $q"/>

			<xsl:variable name="tags-file" select="tables:outline('etiquetas')/@url"/>

			<xsl:variable name="p">
				<xsl:if test="$first-letter">
					<xsl:text>/</xsl:text>
					<xsl:value-of select="x:upper(substring(@term, 1, 1))"/>
				</xsl:if>
			</xsl:variable>

			<a class="{$c}" style="font-size:{$s}px" href="{$tags-file}{$p}#{@id}">
				<xsl:value-of select="@term"/>
			</a>
			<xsl:text> </xsl:text>
		</xsl:for-each>
	</div>
</xsl:template>

</xsl:transform>
<!--
	vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
