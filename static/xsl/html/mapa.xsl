<?xml version="1.0" encoding="UTF-8"?>
<!--
 * mapa.xsl - templates para página con el site map.
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	xmlns:p="urn:uuid:686f0726-a7f1-11dd-9ce0-001fc6576244"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns:dyn="http://exslt.org/dynamic"
	xmlns:str="http://exslt.org/strings"
  extension-element-prefixes="dyn str"
	exclude-result-prefixes="p h tables x"
>

<xsl:import href="../lib/node.xsl"/>

<!--
 !
 !-->
<xsl:template match="h:html" mode="node.styles">
	<link media="all" rel="stylesheet" type="text/css" href="/styles/mapa"/>
</xsl:template>

<!--
 !
 !-->
<xsl:template match="h:html" mode="node.scripts">
	<script type="text/javascript" src="/scripts/related">;</script>

	<script type="text/javascript"><xsl:text disable-output-escaping="yes">//&lt;![CDATA[</xsl:text>
			var mapa = 
			{
				mostrar: '<xsl:value-of select="tables:text('mostrarR')"/>',
				ocultar: '<xsl:value-of select="tables:text('ocultarR')"/>'
			}
		<xsl:text disable-output-escaping="yes">//]]&gt;</xsl:text>
	</script>
</xsl:template>

<!--
 !
 !-->
<xsl:template match="h:html" mode="node.menus">
	<li>
		<xsl:call-template name="html.anchor">
			<xsl:with-param name="sClass" select="'TopMenu'"/>
			<xsl:with-param name="sText" select="string(tables:text('ocultarR'))"/>
			<xsl:with-param name="sHref" select="'#'"/>
			<xsl:with-param name="sId" select="'MenuRelated'"/>
			<xsl:with-param name="sOnClick" select="'return menu_related();'"/>
		</xsl:call-template>
	</li>
</xsl:template>

<!--
 !
 !-->
<xsl:template match="h:body[../@id = 'mapa']">
	<xsl:apply-templates select="*"/>

	<ul class="xoxo Section">
		<xsl:apply-templates select="$tables:Outline/opml/body/outline"/>
	</ul>
</xsl:template>

<!--
 !
 !-->
<xsl:template match="outline">
	<xsl:if test="@tree = 'yes'">
		<li>
			<xsl:choose>
				<xsl:when test="outline[@tree = 'yes']">
					<xsl:attribute name="class">Node</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">Leave</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>

			<a id="P{@page}" href="{@url}">
					<xsl:value-of select="@text"/>
			</a>

			<xsl:if test="@related and @id != 'index'">
				<ul class="Section RelatedNode"> <!-- value used in related.js -->
					<xsl:variable name="tokens"
						select="dyn:map(str:split(@related), 'normalize-space()')"/>

					<xsl:for-each select="$tokens">
						<li class="Related">
							<a href="{tables:outline(.)/@url}">
								<xsl:value-of select="tables:outline(.)/@text"/>
							</a>
						</li>
					</xsl:for-each>
				</ul>
			</xsl:if>

			<xsl:if test="outline[@tree = 'yes']">
				<ul class="Section">
					<xsl:apply-templates select="outline"/>
				</ul>
			</xsl:if>
		</li>
	</xsl:if>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
