<?xml version="1.0" encoding="UTF-8"?>
<!--
 * test.xsl - templates para página con lista de tests.
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
	<!ENTITY maxCols "9">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	xmlns:p="urn:uuid:687131a4-a7f1-11dd-8bca-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl"
	exclude-result-prefixes="p h tables x"
>

<xsl:import href="generic.xsl"/>

<!--
 !
 !-->
<xsl:template match="h:object[@class = 'tests']">
	<xsl:variable name="id" select="/h:html/@id"/>
	<xsl:variable name="all-tests"
		select="$tables:Outline/opml/body/descendant::outline
						[@kind = 'likert' or @kind = 'choice']
						[$id = ancestor::outline/@id]
		"/>

	<!-- box -->
	<xsl:call-template name="p:tests-box">
		<xsl:with-param name="tests" select="$all-tests"/>
	</xsl:call-template>

	<!-- list -->
	<xsl:call-template name="p:tests-list">
		<xsl:with-param name="tests" select="$all-tests"/>
	</xsl:call-template>
</xsl:template>

<xsl:template name="p:tests-list">
	<xsl:param name="tests"/>

	<ol>
		<xsl:for-each select="$tests">
			<xsl:sort select="x:makeID(@text)"/>

			<li>
				<a id="{@id}" href="{@url}">
					<xsl:value-of select="@text"/>
					(<xsl:value-of select="@id"/>)
				</a>
			</li>
		</xsl:for-each>
	</ol>
</xsl:template>

<!--
 !
 !-->
<xsl:template name="p:tests-box">
	<xsl:param name="tests"/>

	<!-- sorted by @id -->
	<xsl:variable name="rOutlines">
		<xsl:for-each select="$tests">
			<xsl:sort select="@id"/>
			<xsl:copy-of select="self::outline"/>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="outlines" select="exsl:node-set($rOutlines)/outline"/>

	<xsl:variable name="nRows" select="ceiling(count($outlines) div &maxCols;)"/>
	<xsl:variable name="nCols" select="ceiling(count($outlines) div $nRows)"/>

	<table class="Abbr">
		<caption><xsl:value-of select="tables:text('tests')"/></caption>

		<colgroup span="{$nCols}" style="width: 10%">
			<xsl:comment>Make HTML5 happy</xsl:comment>
		</colgroup>

		<tbody>
			<xsl:for-each select="$outlines[position() &lt;= $nRows]">
				<xsl:variable name="nRow" select="position()"/>

				<tr>
					<xsl:for-each select="$outlines[position() &lt;= $nCols]">
						<xsl:variable name="nCol" select="position()"/>
						<xsl:variable name="nI" select="$nRow + ($nRows * ($nCol - 1))"/>
						<xsl:variable name="outline" select="$outlines[$nI]"/>

						<td>
							<xsl:choose>
								<xsl:when test="$outline">
									<a href="{$outline/@url}" title="{$outline/@text}">
										<xsl:value-of select="$outline/@id"/>
									</a>
								</xsl:when>
								<xsl:otherwise>&nbsp;</xsl:otherwise>
							</xsl:choose>
						</td>
					</xsl:for-each>
				</tr>
			</xsl:for-each>
		</tbody>
	</table>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
