<?xml version="1.0" encoding="UTF-8"?>
<!--
 * error.xsl - 
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
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h tables"
>

<xsl:import href="../lib/node.xsl"/>

<!--
 !	
 -->
<xsl:template match="h:html" mode="node.breadcrumb">
	<xsl:param name="node"/>

	<xsl:for-each select="$node/ancestor::outline">
		<a class="Breadcrumb" href="{@url}"><xsl:value-of select="@text"/></a>
		<span class="BreadcrumbArrow">&ARROW;</span>
	</xsl:for-each>

	<strong class="BreadcrumbHere">
		<xsl:value-of select="h:head/h:title/text()"/>
		<xsl:text> </xsl:text>
		<xsl:comment>#echo var="REDIRECT_STATUS" </xsl:comment>
	</strong>
</xsl:template>

<!--
 !	
 -->
<xsl:template match="h:html" mode="node.panel-navigation">
	<xsl:apply-imports/>

	<ul class="PanelMenu">
		<li class="PanelMenuLeave">
			<a class="PanelMenu" href="/">
				<xsl:value-of select="tables:text('navStart')"/>
			</a>
		</li>
		<li class="PanelMenuLeave">
			<a class="PanelMenu" href="{tables:outline('ayuda')/@url}">
				<xsl:value-of select="tables:text('navHelp')"/>
			</a>
		</li>
	</ul>
</xsl:template>
<!--
 !	
 -->
<xsl:template match="h:body">
	<xsl:apply-templates select="node()"/>
</xsl:template>

<!--
 !	
 -->
<xsl:template match="comment()">
	<xsl:if test="starts-with(., '#')">
		<xsl:copy/>
	</xsl:if>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
