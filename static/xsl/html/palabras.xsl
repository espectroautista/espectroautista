<?xml version="1.0" encoding="UTF-8"?>
<!--
 * palabras.xsl - lista de ref. bib.
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
	<!ENTITY NKEYWORDS "3">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:bib="http://espectroautista.info/ns/bib"
	xmlns:dyn="http://exslt.org/dynamic"
  xmlns:set="http://exslt.org/sets"
	extension-element-prefixes="dyn set"
	exclude-result-prefixes="h bib tables x"
>

<xsl:import href="../lib/node.xsl"/>

<!--
 !
 !-->
<xsl:template match="h:html" mode="node.styles">
	<link media="all" rel="stylesheet" type="text/css" href="/styles/palabras"/>
</xsl:template>

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
			<xsl:for-each select="$node/ancestor::outline | tables:outline('palabras')">
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
		<a	class="TreeNav"
				href="{$parent/@url}" title="{$parent/@text}">
			<span class="Symbol">&UP;</span>

			<xsl:value-of select="tables:text('subir')"/>
		</a>
	</div>

	<xsl:variable name="node" select="tables:outline('palabras')"/>

	<xsl:call-template name="children-or-siblings">
		<xsl:with-param name="node" select="$node"/>
		<xsl:with-param name="parent"  select="$node/parent::outline"/>
	</xsl:call-template>
</xsl:template>

<!--
 !	
 -->
<xsl:key name="Keywords" match="bib:keyword" use="."/>

<xsl:template match="h:body[starts-with(../@id, 'palabras')]">
	<xsl:variable name="initials"
		select="set:distinct(dyn:map($tables:Bibliography/*/bib:keywords/bib:keyword,
														'x:makeID(substring(., 1, 1))'))"/>

	<xsl:choose>
		<xsl:when test="not($LETTER)">
			<xsl:apply-templates select="*"/>

			<xsl:call-template name="x:alpha-menu">
				<!-- 'null' letter -->
				<xsl:with-param name="current-letter" select="'_1'"/>
				<xsl:with-param name="url" select="tables:outline('palabras')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>

			<xsl:for-each select="$tables:Bibliography">
				<!-- cloud -->
				<xsl:call-template name="keywords-cloud">
				</xsl:call-template>
			</xsl:for-each>

			<xsl:call-template name="x:alpha-menu">
				<!-- 'null' letter -->
				<xsl:with-param name="current-letter" select="'_2'"/>
				<xsl:with-param name="url" select="tables:outline('palabras')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<!-- LETTER is defined as parameter -->
			<xsl:apply-templates select="h:h1"/>

			<xsl:call-template name="x:alpha-menu">
				<xsl:with-param name="current-letter" select="$LETTER"/>
				<xsl:with-param name="url" select="tables:outline('palabras')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>

			<xsl:for-each select="$tables:Bibliography">
				<!-- index -->
				<xsl:call-template name="keywords-index">
					<xsl:with-param name="keywords"
						select="*/bib:keywords/bib:keyword
												[count(.|key('Keywords', .)[1])=1]
												[$LETTER = x:makeID(substring(., 1 ,1))]
						"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:call-template name="x:alpha-menu">
				<xsl:with-param name="current-letter" select="$LETTER"/>
				<xsl:with-param name="url" select="tables:outline('palabras')/@url"/>
				<xsl:with-param name="initials" select="$initials"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<!--
 !
 !-->
<xsl:template name="keywords-cloud">
	<!-- cloud -->
	<div id="TagCloud">
		<xsl:variable name="top-keywords"
			select="*/bib:keywords/bib:keyword
							[count(key('Keywords', .)) &gt;= &NKEYWORDS;]
							[count(.|key('Keywords', .)[1])=1]"/>

		<xsl:for-each select="$top-keywords">
			<xsl:sort select="x:makeID(.)"/>

			<xsl:variable name="current-key" select="."/>

			<xsl:variable name="current-id" select="x:makeID(.)" />

			<xsl:variable name="current-count">
				<xsl:for-each select="$tables:Bibliography">
					<xsl:value-of
						select="count(key('Keywords', $current-key))"/>
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
			<xsl:variable name="s" select="round(($m + $t * $q) div 2.5)"/>

			<xsl:variable name="url" select="tables:outline('palabras')/@url"/>

			<a class="{$c}" style="font-size: {$s}px;"
				href="{$url}/{x:makeID(substring($current-key, 1 ,1))}#{$current-id}">
				<xsl:value-of select="."/>
			</a>

			<xsl:text> </xsl:text>
		</xsl:for-each>
	</div>
</xsl:template>

<!--
 !
 !-->
<xsl:template name="keywords-index">
	<xsl:param name="keywords"/>

	<xsl:for-each select="$keywords">
		<xsl:sort select="x:makeID(.)"/>

		<xsl:variable name="keyword" select="."/>

		<h2 class="IndexLabel">
			<a id="{x:makeID(.)}" class="Symbol" href="#" title="{tables:text('palabras')}">&UP;</a>

			<span style="width: 1em;">&#160;</span>

			<xsl:value-of select="."/>
		</h2>

		<xsl:variable name="url" select="tables:outline('palabras')/@url"/>

		<div class="KeywordList">
			<xsl:for-each select="key('Keywords', .)">
				<xsl:sort select="x:makeID(parent::bib:keywords/parent::*/bib:title)"/>

				<xsl:variable name="pub" select="parent::bib:keywords/parent::*"/>

				<div class="KeywordItem clearfix" xml:lang="{$pub/bib:lang}" lang="{$pub/bib:lang}">
					<div class="KeywordBibRef">
						<xsl:apply-templates select="tables:bibliography($pub/@id)"/>
					</div>

					<div class="KeywordKeywords" xml:lang="{$Language}" lang="{$Language}">
						<xsl:for-each select="parent::bib:keywords/*">
							<xsl:variable name="current-id" select="x:makeID(.)" />
	
							<xsl:variable name="c">
								<xsl:choose>
									<xsl:when test="(position() mod 2) != 0">EvenKeyword</xsl:when>
									<xsl:otherwise>OddKeyword</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>

							<xsl:choose>
								<xsl:when test="$keyword != .">
									<a	class="{$c}"
											href="{$url}/{x:makeID(substring(., 1 ,1))}#{$current-id}">
										<xsl:value-of select="."/>
									</a>
								</xsl:when>
								<xsl:otherwise>
									<span class="{$c}"><xsl:value-of select="."/></span>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:if test="position() &lt; last()">
								<xsl:text> </xsl:text>
							</xsl:if>
						</xsl:for-each>
					</div>

				</div>
			</xsl:for-each>
		</div>

	</xsl:for-each>
</xsl:template>

</xsl:transform>
<!--
	vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
