<?xml version="1.0" encoding="UTF-8"?>
<!--
 * sorttags.xsl - Ordena tags
 *
-->
<!DOCTYPE xsl:transform [
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:x="http://espectroautista.info/ns/xlib"
	exclude-result-prefixes="x"
>

<xsl:import href="lib/xlib.xsl"/>

<xsl:output
	method="xml"
	encoding="UTF-8"
	indent="yes"
	version="1.0"
	omit-xml-declaration="no"
/>

<xsl:template match="/tags">
	<tags>
		<xsl:for-each select="tag">
			<xsl:sort select="x:lower(@term)"/>

			<tag>
				<xsl:copy-of select="@*"/>
					<xsl:for-each select="page">
						<xsl:sort select="@description"/>

						<page>
							<xsl:copy-of select="@*"/>

							<xsl:for-each select="tag">
								<xsl:sort select="x:lower(@term)"/>
								
								<tag>
									<xsl:copy-of select="@*"/>
								</tag>
							</xsl:for-each>
						</page>
					</xsl:for-each>
			</tag>
		</xsl:for-each>
	</tags>

	<xsl:text>&#10;</xsl:text>
	<xsl:comment>
		vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
	</xsl:comment>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
