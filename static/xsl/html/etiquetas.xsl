<?xml version="1.0" encoding="UTF-8"?>
<!--
 * etiquetas.xsl - templates para página con las etiquetas.
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
	xmlns:p="urn:uuid:686dd752-a7f1-11dd-9f08-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:exsl="http://exslt.org/common"
	xmlns:dyn="http://exslt.org/dynamic"
  xmlns:set="http://exslt.org/sets"
	extension-element-prefixes="exsl dyn set"
	exclude-result-prefixes="p h tables x"
>

<xsl:import href="../lib/cloud.xsl"/>
<xsl:import href="../lib/node.xsl"/>

<!-- empty/false if making index -->
<xsl:param name="LETTER" select="false()"/>	<!-- or a letter -->

<!--
 !	
 -->
<xsl:template match="h:html" mode="node.breadcrumb">
	<xsl:param name="node"/>

	<xsl:choose>
		<xsl:when test="not($LETTER)">
			<xsl:apply-imports/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="$node/ancestor::outline | tables:outline('etiquetas')">
				<a class="Breadcrumb" href="{@url}"><xsl:value-of select="@text"/></a>
				<span class="BreadcrumbArrow">&ARROW;</span>
			</xsl:for-each>

			<strong class="BreadcrumbHere Letter">
				<xsl:value-of select="$LETTER"/>
			</strong>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
 !	
 -->
<xsl:template match="h:html" mode="node.panel-navigation">
	<xsl:param name="parent"/>

	<div id="TreeNav">
		<a class="TreeNav"
			href="{$parent/@url}" title="{$parent/@text}">
			<span class="Symbol"><xsl:text>&UP;</xsl:text></span>
			<xsl:value-of select="tables:text('subir')"/>
		</a>
	</div>

	<xsl:variable name="node" select="tables:outline('etiquetas')"/>

	<xsl:call-template name="children-or-siblings">
		<xsl:with-param name="node" select="$node"/>
		<xsl:with-param name="parent"  select="$node/parent::outline"/>
	</xsl:call-template>
</xsl:template>

<!--
 !	
 -->
<xsl:template match="h:body[starts-with(../@id, 'etiquetas')]">
	<xsl:variable name="initials"
		select="set:distinct(dyn:map($tables:Tags, 'x:upper(substring(@term, 1, 1))'))"/>

	<xsl:choose>
		<xsl:when test="not($LETTER)">
			<xsl:apply-templates select="*"/>

			<xsl:call-template name="x:alpha-menu">
				<!-- 'null' letter -->
				<xsl:with-param name="current-letter" select="'_1'"/>
				<xsl:with-param name="url" select="tables:outline('etiquetas')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>

			<xsl:call-template name="cloud.tags">
				<xsl:with-param name="first-letter" select="true()"/>
			</xsl:call-template>

			<xsl:call-template name="x:alpha-menu">
				<!-- 'null' letter -->
				<xsl:with-param name="current-letter" select="'_2'"/>
				<xsl:with-param name="url" select="tables:outline('etiquetas')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<!-- LETTER is defined as parameter -->
			<xsl:apply-templates select="h:h1"/>

			<xsl:call-template name="x:alpha-menu">
				<xsl:with-param name="current-letter" select="$LETTER"/>
				<xsl:with-param name="url" select="tables:outline('etiquetas')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>

			<xsl:apply-templates select="$tables:Tags[$LETTER = x:upper(substring(@term, 1 ,1))]"/>

			<xsl:call-template name="x:alpha-menu">
				<xsl:with-param name="current-letter" select="$LETTER"/>
				<xsl:with-param name="url" select="tables:outline('etiquetas')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
 !	Input comes from tags.xml
 -->
<xsl:template match="/tags/tag">
	<xsl:variable name="first" select="x:upper(substring(@term, 1, 1))"/>

	<h2 class="IndexLabel">
		<a id="{@id}" class="Symbol" href="#" title="{tables:text('etiquetas2')}">&UP;</a>

		<span style="width: 1em;">&#160;</span>

		<xsl:value-of select="@term"/>
	</h2>

	<ul>
		<xsl:for-each select="page">
			<xsl:sort select="x:makeID(@description)"/>
			<li>
				<a href="{@url}">
					<xsl:value-of select="@description"/>
				</a>
			</li>
		</xsl:for-each>
	</ul>
</xsl:template>

</xsl:transform>

<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
