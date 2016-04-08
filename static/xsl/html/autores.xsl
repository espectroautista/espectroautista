<?xml version="1.0" encoding="UTF-8"?>
<!--
 * autores.xsl - lista de ref. bib.
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
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:bib="http://espectroautista.info/ns/bib"
	xmlns:exsl="http://exslt.org/common"
	xmlns:dyn="http://exslt.org/dynamic"
  xmlns:set="http://exslt.org/sets"
	extension-element-prefixes="dyn exsl set"
	exclude-result-prefixes="h bib tables x"
>

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
			<xsl:for-each select="$node/ancestor::outline | tables:outline('bibautores')">
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

	<xsl:variable name="node" select="tables:outline('bibautores')"/>

	<xsl:call-template name="children-or-siblings">
		<xsl:with-param name="node" select="$node"/>
		<xsl:with-param name="parent" select="$node/parent::outline"/>
	</xsl:call-template>
</xsl:template>

<!--
 !	
 -->
<xsl:key name="Authors" match="bib:author" use="string(.)"/>

<xsl:template match="h:body[starts-with(../@id, 'bibautores')]">
	<xsl:variable name="initials"
		select="set:distinct(dyn:map($tables:Bibliography/*/bib:authors/bib:author,
																	'substring(bib:last, 1, 1)'))"/>

	<xsl:choose>
		<!-- general index, with tag cloud -->
		<xsl:when test="not($LETTER)">
			<xsl:apply-templates select="*"/>

			<xsl:call-template name="x:alpha-menu">
				<!-- 'null' letter -->
				<xsl:with-param name="current-letter" select="'_1'"/>
				<xsl:with-param name="url" select="tables:outline('bibautores')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>

			<xsl:for-each select="$tables:Bibliography">
				<!-- cloud -->
				<xsl:call-template name="authors-cloud">
				</xsl:call-template>
			</xsl:for-each>

			<xsl:call-template name="x:alpha-menu">
				<!-- 'null' letter -->
				<xsl:with-param name="current-letter" select="'_2'"/>
				<xsl:with-param name="url" select="tables:outline('bibautores')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<!-- LETTER is defined as parameter: one page for each letter -->
			<xsl:apply-templates select="h:h1"/>

			<xsl:call-template name="x:alpha-menu">
				<xsl:with-param name="current-letter" select="$LETTER"/>
				<xsl:with-param name="url" select="tables:outline('bibautores')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>

			<xsl:for-each select="$tables:Bibliography">
				<!-- index -->
				<xsl:call-template name="authors-index">
					<xsl:with-param name="authors"
						select="*/bib:authors/bib:author
												[count(.|key('Authors', string(.))[1])=1]
												[$LETTER = x:makeID(substring(bib:last, 1 ,1))]
						"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:call-template name="x:alpha-menu">
				<xsl:with-param name="current-letter" select="$LETTER"/>
				<xsl:with-param name="url" select="tables:outline('bibautores')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<!--
 !
 !-->
<!-- BUG <xsl:key name="Authors1" match="bib:author[1]" use="string(.)"/> -->

<xsl:template name="authors-cloud">
	<!-- cloud -->

	<div id="TagCloud">
		<xsl:variable name="rTopAuthors">
			<!--BUG <xsl:for-each select="*/bib:authors/bib:author[1][count(.|key('Authors1', .)[1])=1]">-->
			<xsl:for-each select="set:distinct(*/bib:authors/bib:author[1])">
				<xsl:copy-of select="self::bib:author"/>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="top-authors" select="exsl:node-set($rTopAuthors)/bib:author"/>

		<xsl:for-each select="$top-authors">
			<xsl:sort select="x:makeID(bib:last)"/>

			<xsl:variable name="current-key" select="string(.)"/>

			<xsl:variable name="current-id">
				<xsl:for-each select="$tables:Bibliography">
					<xsl:value-of select="key('Authors', $current-key)[1]/@node"/>
				</xsl:for-each>
			</xsl:variable>

			<xsl:variable name="current-count">
				<xsl:for-each select="$tables:Bibliography">
					<xsl:value-of select="count(key('Authors', $current-key))"/>
				</xsl:for-each>
			</xsl:variable>

			<xsl:variable name="c">
				<xsl:choose>
					<xsl:when test="(position() mod 2) != 0">EvenTag</xsl:when>
					<xsl:otherwise>OddTag</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="m" select="9*2"/>
			<xsl:variable name="q" select="1*3"/>
			<xsl:variable name="t" select="ceiling($current-count div $q)"/>
			<xsl:variable name="s" select="round(($m + $t * $q) div 2)"/>

			<xsl:variable name="url" select="tables:outline('bibautores')/@url"/>

			<a class="{$c}" style="font-size: {$s}px;"
				 href="{$url}/{x:makeID(substring(bib:last, 1 ,1))}#{$current-id}">
				<xsl:value-of select="concat(bib:first, ' ', bib:last)"/>
			</a>

			<xsl:text> </xsl:text>
		</xsl:for-each>
	</div>
</xsl:template>

<!--
 !
 !-->
<xsl:template name="authors-index">
	<xsl:param name="authors"/>

	<xsl:for-each select="$authors">
		<xsl:sort select="x:makeID(bib:last)"/>

		<xsl:variable name="current-key" select="string(.)"/>

		<h2 class="IndexLabel">
			<a	class="Symbol"
					id="{key('Authors', $current-key)[1]/@node}"
					href="#" title="{tables:text('autores')}">&UP;</a>

			<span style="width: 1em;">&#160;</span>

			<xsl:value-of select="concat(bib:last, ', ', bib:first)"/>
		</h2>

		<ul>
			<xsl:for-each select="key('Authors', $current-key)">
				<xsl:sort select="x:makeID(parent::bib:authors/parent::*/bib:title)"/>

				<xsl:variable name="pub" select="parent::bib:authors/parent::*"/>

				<li xml:lang="{$pub/bib:lang}" lang="{$pub/bib:lang}">
					<xsl:apply-templates select="tables:bibliography($pub/@id)">
						<xsl:with-param name="linked" select="true()"/>
					</xsl:apply-templates>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:for-each>
</xsl:template>

</xsl:transform>
<!--
	vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
