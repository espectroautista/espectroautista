<?xml version="1.0" encoding="UTF-8"?>
<!--
 * glosario.xsl - Glosario con selector de acrónimos
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
	<!ENTITY nCols "7">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns:h="&XHTMLNS;"
	xmlns:p="urn:uuid:686ebfdc-a7f1-11dd-86ca-001fc6576244"
	xmlns:exsl="http://exslt.org/common"
	extension-element-prefixes="exsl"
	exclude-result-prefixes="p h tables"
>

<xsl:import href="../lib/node.xsl"/>

<!--
 !
 !-->
<xsl:template match="h:html" mode="node.styles">
	<link media="all" rel="stylesheet" type="text/css" href="/styles/glosario"/>
</xsl:template>

<!-- selection box -->
<xsl:variable name="anchors" select="id('glossary')/h:dt"/>

<xsl:template match="h:body[../@id = 'glosario']">
	<!-- text preceding list of acronyms -->
	<xsl:apply-templates select="id('glossary')/preceding-sibling::*"/>

	<table class="Abbr">
		<caption><xsl:value-of select="tables:text('acronimos')"/></caption>

		<colgroup span="&nCols;" style="width: 10%"/>

		<tbody>
			<!-- selection boxes (ordered by columns) -->
			<xsl:variable name="nRows" select="ceiling(count($anchors) div &nCols;)"/>
			<xsl:for-each select="$anchors[position() &lt;= $nRows]">
				<xsl:variable name="nRow" select="position()"/>

				<tr>
					<xsl:for-each select="$anchors[position() &lt;= &nCols;]">
						<xsl:variable name="nCol" select="position()"/>
						<xsl:variable name="nI" select="$nRow + ($nRows * ($nCol - 1))"/>
						<xsl:variable name="anchor" select="$anchors[$nI]"/>

						<td>
							<xsl:choose>
								<xsl:when test="$anchor">
									<a title="{substring-before($anchor/following-sibling::h:dd[1], '.')}"
										href="#{$anchor/@id}">
										<xsl:value-of select="$anchor/@id"/>
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

	<!-- list of acronyms -->
	<dl id="glossary">
		<xsl:for-each select="id('glossary')/h:dt">
			<xsl:variable name="dt" select="."/>

			<dt>
				<span id="{@id}">
					<xsl:copy-of select="h:span[1]/text()"/>

					<xsl:if test="h:span[2]">
						<span class="Equivalencia">&hArr;</span>

						<span>
							<a	href="#{h:span[2]}"
									title="{substring-before(id(h:span[2]/text())/following-sibling::h:dd, '.')}">
								<xsl:value-of select="h:span[2]/text()"/>
							</a>
						</span>
					</xsl:if>
				</span>
			</dt>

			<xsl:for-each select="following-sibling::h:dd[
						generate-id(preceding-sibling::h:dt[1]) = generate-id($dt)]">
				<dd>
					<xsl:if test="@lang">
						<xsl:attribute name="lang"><xsl:value-of select="@lang"/></xsl:attribute>
						<xsl:attribute name="xml:lang"><xsl:value-of select="@lang"/></xsl:attribute>
					</xsl:if>

					<xsl:copy-of select="node()"/>
				</dd>
			</xsl:for-each>
		</xsl:for-each>
	</dl>

</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
