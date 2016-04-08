<?xml version="1.0" encoding="UTF-8"?>
<!--
 * node.xsl - Parte básica y común a todos los nodos
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
	<!ENTITY SEARCH_PAGE "http://www.google.com/coop/cse?cx=004940659091512830446:qk8kuueav5m">
	<!ENTITY OPINAR "http://spreadsheets.google.com/viewform?key=p84EkxTOTjQmREslsbQsELw">
	<!ENTITY FORO "http://groups.google.com/group/foro-tea?hl=es">
	<!ENTITY BASELANG "es">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	xmlns:p="urn:uuid:ba1eb3c4-62b3-11dd-81b8-001fc6576244"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns:dyn="http://exslt.org/dynamic"
	xmlns:str="http://exslt.org/strings"
  extension-element-prefixes="dyn str"
	exclude-result-prefixes="h p tables x"
>

<xsl:import href="analytics.xsl"/>
<xsl:import href="html.xsl"/>
<xsl:import href="object.xsl"/>

<!--
	method="html"
	doctype-system="about:legacy-compat"

	method="xml"
	doctype-system="about:legacy-compat"

	method="html"
	doctype-public="-//W3C//DTD HTML 4.01//EN"
	doctype-system="http://www.w3.org/TR/html4/strict.dtd"
	version="4.01"

	method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
-->

<xsl:output
	method="xml"
	version="1.0"
	omit-xml-declaration="yes"
	doctype-system="about:legacy-compat"
	encoding="UTF-8"
	media-type="text/html"
	indent="yes"
/>

<xsl:strip-space elements="*"/>

<xsl:param name="Language" select="'es'"/>

<!--
 ! root node
 !-->
<xsl:template match="/">
	<xsl:apply-templates select="h:html">
		<xsl:with-param name="node" select="tables:outline(h:html/@id)"/>
		<xsl:with-param name="parent" select="tables:outline(h:html/@id)/parent::outline"/>
		<xsl:with-param name="sFeedID" select="''"/>	<!-- set in blog.xsl -->
		<xsl:with-param name="sTitle">
			<xsl:choose>
				<xsl:when test="not(tables:outline(h:html/@id)/parent::outline)">
					<xsl:value-of select="tables:text('sitename')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="h:html/h:head/h:title/text()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<!--
 ! h:html
 !-->
<xsl:template match="h:html">
	<xsl:param name="node"/>
	<xsl:param name="parent"/>
	<xsl:param name="sFeedID"/>
	<xsl:param name="sTitle"/>

	<xsl:call-template name="error.assert">
		<xsl:with-param name="test" select="$parent or @id = 'index'"/>
		<xsl:with-param name="text">$parent or @id = 'index'</xsl:with-param>
	</xsl:call-template>

	<!--
	<xsl:comment>
		<xsl:value-of select="concat(
			'xsl:vendor(', system-property('xsl:vendor'), ') ',
			'xsl:version(', system-property('xsl:version'), ')')"/>
	</xsl:comment>
	-->

	<html id="{@id}" xmlns="&XHTMLNS;" xml:lang="{$Language}" lang="{$Language}">
		<head>
			<!-- HTTP headers -->
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
			<!--<meta charset="UTF-8"/>-->

			<!-- the page title -->
			<title>
				<xsl:choose>
					<xsl:when test="@id = 'index' and $sFeedID = ''">
						<xsl:value-of select="tables:text('sitename')"/>
						<xsl:text> &ndash; </xsl:text>
						<xsl:value-of select="tables:text('siteTitle')"/>
					</xsl:when>
					<xsl:when test="@id = 'index'">
						<xsl:value-of select="$sTitle"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tables:text('sitename')"/>
						<xsl:text> &ndash; </xsl:text>
						<xsl:apply-templates select="h:head/h:title/node()"/>
					</xsl:otherwise>
				</xsl:choose>
			</title>

			<!-- author -->
			<meta name="author" content="Kleine Professoren"/>
			<link rel="author" href="mailto:webmaster@espectroautista.info"/>

			<!-- copy meta robots -->
			<xsl:for-each select="h:head/h:meta[@name = 'robots']">
				<xsl:copy-of select="."/>
			</xsl:for-each>
			<!-- copy meta keywords -->
			<xsl:for-each select="h:head/h:meta[@name = 'keywords']">
				<xsl:copy-of select="."/>
			</xsl:for-each>
			<!-- copy meta description -->
			<xsl:choose>
				<xsl:when test="$sFeedID = ''">
					<xsl:for-each select="h:head/h:meta[@name = 'description']">
						<xsl:copy-of select="."/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>	<!-- for F<YYYY>-<MM>.html and F<YYYY>.html -->
					<meta name="description" content="{$sTitle} ({tables:text('archivo')})"/>
				</xsl:otherwise>
			</xsl:choose>

			<!-- favicon -->
			<link rel="shortcut icon" href="/favicon.ico"/>

			<!-- for index.html (not for F<YYYY>-<MM>.html) -->
			<xsl:if test="@id = 'index' and $sFeedID = ''">
				<link rel="alternate" href="&SITE;feed.atom" type="application/atom+xml" title="{tables:text('navAtom')}"/>
				<link rel="alternate" href="&SITE;feed.rss" type="application/rss+xml" title="{tables:text('navRSS')}"/>
			</xsl:if>

			<!-- 'link' navigation  -->
			<link rel="start" href="{tables:outline('index')/@url}" title="{tables:text('navStart')}"/>
			<xsl:if test="@id != 'etiquetas'">
				<link rel="index" href="{tables:outline('etiquetas')/@url}" title="{tables:text('navIndex')}"/>
			</xsl:if>
			<xsl:if test="@id != 'mapa'">
				<link rel="contents" href="{tables:outline('mapa')/@url}" title="{tables:text('navContents')}"/>
			</xsl:if>
			<xsl:if test="@id != 'glosario'">
				<link rel="glossary" href="{tables:outline('glosario')/@url}" title="{tables:text('navGlossary')}"/>
			</xsl:if>
			<xsl:if test="@id != 'ayuda'">
				<link rel="help" href="{tables:outline('ayuda')/@url}" title="{tables:text('navHelp')}"/>
			</xsl:if>
			<link rel="search" href="&SEARCH_PAGE;" title="{tables:text('navSearch')}"/>

			<xsl:choose>
				<xsl:when test="$sFeedID = ''"> 	<!-- all pages except feeds -->
					<!-- alphabetical subsection A-Z ? -->
					<xsl:variable name="bIsAlpha"
						select="substring(@id, string-length(@id) - 1, 1) = '_'"/>

					<xsl:choose>
						<xsl:when test="$bIsAlpha">
							<xsl:variable name="id" select="substring-before(@id, '_')"/>
							<xsl:variable name="parent" select="tables:outline($id)"/>

							<link rel="up" href="{$parent/@url}" title="{$parent/@text}"/>
							<link rel="section" href="{$parent/@url}" title="{$parent/@text}"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="$parent">
								<!-- has parent -->
								<link rel="up" href="{@url}" title="{@text}"/>
								<link rel="section" href="{@url}" title="{@text}"/>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>

					<xsl:for-each select="$node/outline[@tree = 'yes']">
						<!-- has children in the tree -->
						<link rel="subsection" href="{@url}" title="{@text}"/>
					</xsl:for-each>

					<!-- siblings -->
					<xsl:variable name="preceding"
						select="$node/preceding-sibling::outline[$node/@tree = 'yes' and @tree = 'yes']"/>
					<xsl:if test="$preceding">
						<link rel="first" href="{$preceding[1]/@url}" title="{$preceding[1]/@text}"/>
						<link rel="prev" href="{$preceding[last()]/@url}" title="{$preceding[last()]/@text}"/>
					</xsl:if>
					<xsl:variable name="following"
						select="$node/following-sibling::outline[$node/@tree = 'yes' and @tree = 'yes']"/>
					<xsl:if test="$following">
						<link rel="last" href="{$following[last()]/@url}" title="{$following[last()]/@text}"/>
						<link rel="next" href="{$following[1]/@url}" title="{$following[1]/@text}"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise> 	<!-- for index and feeds -->
					<xsl:call-template name="error.assert">
						<xsl:with-param name="test" select="@id = 'index'"/>
						<xsl:with-param name="text">@id = 'index'</xsl:with-param>
					</xsl:call-template>

					<xsl:apply-templates select="self::h:html" mode="blog.navigation-link">
						<xsl:with-param name="sFeedID" select="$sFeedID"/>
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>

			<!-- preferred; media screen, Screen mode -->
			<link media="screen" rel="stylesheet" type="text/css" href="/styles/screen" title="Screen"/>
			<!-- alternate; media screen, Printer mode -->
			<link media="screen" rel="alternate stylesheet" type="text/css" href="/styles/print" title="Printer"/>
			<!-- persistent; media print, disjoint with media screen (Screen and Printer modes) -->
			<link media="print" rel="stylesheet" type="text/css" href="/styles/print"/>
			<!-- persistent; media all -->
			<link media="all" rel="stylesheet" type="text/css" href="/styles/content"/>
			<xsl:apply-templates select="self::h:html" mode="node.styles">
					<xsl:with-param name="node" select="$node"/>
			</xsl:apply-templates>

			<!-- scripts -->
			<script type="text/javascript">if(top!=self){top.location.replace(self.location.href);}</script>
			<script type="text/javascript" src="/scripts/library">;</script>
			<xsl:apply-templates select="self::h:html" mode="node.scripts"/>

			<!-- analytics -->
			<xsl:call-template name="analytics.scripts"/>
		</head>

		<!--
		 ! body
		 !-->
		 <body>
			<div id="Container">
				<div id="Header">
					<xsl:apply-templates select="self::h:html" mode="p:page-header">
							<xsl:with-param name="node" select="$node"/>
							<xsl:with-param name="parent" select="$parent"/>
							<xsl:with-param name="sFeedID" select="$sFeedID"/>
					</xsl:apply-templates>
				</div>

				<div id="Body" class="clearfix">
					<div id="Content">
						<div class="oi">
							<ul id="TopMenu">
								<li>
									<xsl:call-template name="html.anchor">
										<xsl:with-param name="sClass" select="'TopMenu'"/>
										<xsl:with-param name="sText" select="string(tables:text('Vimprimir'))"/>
										<xsl:with-param name="sHref" select="'#'"/>
										<xsl:with-param name="sOnClick" select="'return menu_print();'"/>
									</xsl:call-template>
								</li>

								<xsl:apply-templates select="self::h:html" mode="node.menus"/>

								<xsl:if test="contains($sFeedID, '-')">	<!-- for months -->
									<xsl:apply-templates select="self::h:html" mode="blog.navigation-menu">
										<xsl:with-param name="sFeedID" select="$sFeedID"/>
									</xsl:apply-templates>
								</xsl:if>

							</ul>

							<xsl:apply-templates select="h:body">
								<xsl:with-param name="node" select="$node"/>
								<xsl:with-param name="sFeedID" select="$sFeedID"/>
							</xsl:apply-templates>
						</div>
					</div>	<!-- close Content -->

					<div id="Sidebar">
						<div class="oi">
							<xsl:apply-templates select="self::h:html" mode="p:page-sidebar">
								<xsl:with-param name="node" select="$node"/>
								<xsl:with-param name="parent" select="$parent"/>
								<xsl:with-param name="sFeedID" select="$sFeedID"/>
							</xsl:apply-templates>
						</div>
					</div>	<!-- close Sidebar -->
				</div>	<!-- close Body -->

				<div id="Footer">
					<div class="oi clearfix">
						<xsl:apply-templates select="self::h:html" mode="p:page-footer"/>
					</div>
				</div>	<!-- close Footer -->
			</div>	<!-- close Container -->

			<!-- page after scripts -->
			<xsl:apply-templates select="self::h:html" mode="node.after-scripts"/>
		</body>
	</html>
</xsl:template>

<!--
 ! header
 !-->
<xsl:template match="h:html" mode="p:page-header">
	<xsl:param name="node"/>
	<xsl:param name="parent"/>
	<xsl:param name="sFeedID"/>

	<!-- left logo -->
	<a href="/" id="Logo">
		<img alt="{tables:text('sitename')}" src="/images/logo-espectro-autista"/>
		<!--width="247" height="141"/>-->
	</a>

	<!-- midle title -->
	<div id="Title"><xsl:value-of select="tables:text('sitename')"/></div>

	<!-- rigth-top search form and links -->
	<form id="Search" action="http://www.google.com/cse">
		<xsl:variable name="ayuda" select="tables:outline('ayuda')"/>
		<xsl:variable name="etiquetas" select="tables:outline('etiquetas')"/>
		<xsl:variable name="mapa" select="tables:outline('mapa')"/>

		<ul>
			<li>
				<a class="Search ayuda" rel="nofollow">
					<xsl:choose>
						<xsl:when test="@id != 'ayuda'">
							<xsl:attribute name="href">
								<xsl:value-of select="$ayuda/@url"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<!-- nothing -->
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="tables:text('ayuda')"/>
				</a>
			</li>

			<li>
				<a class="Search etiquetas" rel="nofollow">
					<xsl:choose>
						<xsl:when test="@id != 'etiquetas'">
							<xsl:attribute name="href">
								<xsl:value-of select="$etiquetas/@url"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<!-- nothing -->
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="tables:text('etiquetas')"/>
				</a>
			</li>

			<li>
				<xsl:variable name="bIsAlpha"
					select="substring(@id, string-length(@id) - 1, 1) = '_'"/>

				<xsl:variable name="page">
					<xsl:choose>
						<xsl:when test="$bIsAlpha">
							<xsl:text>#P</xsl:text>
							<xsl:value-of select="$node/parent::outline/@page"/>
						</xsl:when>
						<xsl:when test=" @id = 'index' or @id = 'error'"/> <!-- nothing -->
						<xsl:otherwise>
							<xsl:text>#P</xsl:text>
							<xsl:value-of select="$node/@page"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<a class="Search mapa" rel="nofollow">
					<xsl:choose>
						<xsl:when test="@id != 'mapa'">
							<xsl:attribute name="href">
								<xsl:value-of select="concat($mapa/@url, $page)"/>
							</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<!-- nothing -->
						</xsl:otherwise>
					</xsl:choose>
					<xsl:value-of select="tables:text('mapa')"/>
				</a>
			</li>
		</ul>

		<div>
			<input type="text" id="SearchInputField" name="q" size="15"/>
			<label for="SearchInputField" class="hiddenStructure"><xsl:value-of select="tables:text('buscar')"/></label>
			<input type="submit" name="sa" value="{tables:text('buscar')}"/>
			<input type="hidden" name="cx" value="004940659091512830446:qk8kuueav5m"/>
			<input type="hidden" name="cof" value="FORID:"/>
		</div>
	</form>

	<!-- breadcrumb -->
	<div id="PathBar">
		<div id="Breadcrumb">
			<span id="BreadcrumbTitle"><xsl:value-of select="tables:text('actual')"/>:</span>

			<xsl:apply-templates select="self::h:html" mode="node.breadcrumb">
				<xsl:with-param name="node" select="$node"/>
				<xsl:with-param name="sFeedID" select="$sFeedID"/>
			</xsl:apply-templates>
		</div>
	</div>
</xsl:template>

<!--
 ! sidebar
 !-->
<xsl:template match="h:html" mode="p:page-sidebar">
	<xsl:param name="node"/>
	<xsl:param name="parent"/>
	<xsl:param name="sFeedID"/>

		<div class="Panel">
			<div class="PanelTitle">
				Aviso importante
			</div>

			<p>
				<b>La edición y mantenimiento de <strong class="title">EspectroAutista.Info</strong> se ha descontinuado.
					Para conocer todos los detalles lea <a href="/blog/2016/04#E216">la última noticia</a>.</b>
			</p>
		</div>
	<!-- navigation -->
	<div class="Panel">
		<div class="PanelTitle"><xsl:value-of select="tables:text('navega')"/></div>

		<xsl:choose>
			<xsl:when test="$node/@tree = 'yes'">
				<!-- up one level... -->
				<xsl:if test="$parent">
					<xsl:choose>
						<xsl:when test="contains($sFeedID, '-')">
							<div class="TreeNav">
								<xsl:if test="not('no' = $node/ancestor-or-self::outline/@siblings)">
									<xsl:apply-templates select="$node" mode="node.immediate-siblings"/>
								</xsl:if>

								<a class="TreeNav" href="/blog/{substring($sFeedID, 2, 4)}" title="{$parent/@text}">
									<span class="Symbol"><xsl:text>&UP;</xsl:text></span>
									<xsl:text>&nbsp;</xsl:text>
									<xsl:value-of select="tables:text('subir')"/>
								</a>
							</div>
						</xsl:when>
						<xsl:otherwise>
							<div class="TreeNav">
								<xsl:if test="not('no' = $node/ancestor-or-self::outline/@siblings)">
									<xsl:apply-templates select="$node" mode="node.immediate-siblings"/>
								</xsl:if>

								<a class="TreeNav" href="{$parent/@url}" title="{$parent/@text}">
									<span class="Symbol"><xsl:text>&UP;</xsl:text></span>
									<xsl:text>&nbsp;</xsl:text>
									<xsl:value-of select="tables:text('subir')"/>
								</a>
							</div>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>

				<xsl:call-template name="children-or-siblings">
					<xsl:with-param name="node" select="$node"/>
					<xsl:with-param name="parent" select="$parent"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- nodes no in the tree -->
				<xsl:apply-templates select="self::h:html" mode="node.panel-navigation">
					<xsl:with-param name="parent" select="$parent"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</div>

	<!-- tags -->
	<xsl:variable name="keywords" select="h:head/h:meta[@name = 'keywords']"/>

	<xsl:if test="$node/@tags = 'yes' and $keywords">
		<xsl:variable name="tokens"
			select="dyn:map(str:split($keywords/@content, ','), 'normalize-space()')"/>
		<xsl:variable name="tags-file" select="tables:outline('etiquetas')/@url"/>

		<div class="Panel" id="TagLinks">
			<div class="PanelTitle"><xsl:value-of select="tables:text('etiquetas')"/></div>

			<!-- more tags... -->
			<div class="TreeNav">
				<a href="{$tags-file}" class="TreeNav" rel="nofollow">
					<span>&raquo;&nbsp;</span>
					<xsl:value-of select="tables:text('etiquetas2')"/>
				</a>
			</div>

			<!-- list of tags -->
			<ul id="PanelTags">
				<xsl:for-each select="$tokens">
					<xsl:sort select="x:lower(.)"/>

					<xsl:variable name="c">
						<xsl:choose>
							<xsl:when test="(position() mod 2) != 0">EvenTag</xsl:when>
							<xsl:otherwise>OddTag</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<li>
						<a	href="{$tags-file}/{x:upper(substring(., 1, 1))}#{x:makeID(.)}"
								class="{$c}" rel="nofollow">
							<xsl:value-of select="."/>
						</a>

						<xsl:text>&nbsp;</xsl:text>
						<xsl:text>(</xsl:text>
						<xsl:value-of select="$tables:Tags[@term = current()]/@count"/>
						<xsl:text>)</xsl:text>

						<xsl:text> </xsl:text>	<!-- allows breaking !!! -->
					</li>
				</xsl:for-each>
			</ul>
		</div>
	</xsl:if>

	<!-- blog archives -->
	<xsl:if test="@id = 'index'">
		<div class="Panel">
			<div class="PanelTitle">
				<xsl:value-of select="tables:text('archivo')"/>
			</div>

			<ul class="PanelMenu">
				<xsl:apply-templates select="self::h:html" mode="blog.panel-archives">
					<xsl:with-param name="sFeedID" select="$sFeedID"/>
				</xsl:apply-templates>
			</ul>
		</div>
	</xsl:if>

	<!-- related - only if not generating F2xxx-xx.html -->
	<!--
	<xsl:if test="$node/@related and $sFeedID = ''">
		<div class="Panel">
			<div class="PanelTitle">
				<xsl:value-of
					select="tables:text('cambios')[not($parent)] |
									tables:text('relacion')[$parent]"/>
			</div>

			<ul class="PanelMenu">
				<xsl:for-each select="$tables:Outline">
					<xsl:apply-templates select="id($node/@related)" mode="p:panel-menu">
						<xsl:sort select="x:makeID(@text)"/>
						<xsl:with-param name="node" select="$node"/>
					</xsl:apply-templates>
				</xsl:for-each>
			</ul>
		</div>
	</xsl:if>
	-->

</xsl:template>

<!-- children or siblings -->
<xsl:template name="children-or-siblings">
	<xsl:param name="node"/>
	<xsl:param name="parent"/>

	<xsl:variable name="bHasChildren"
			select="boolean($node/child::outline[@tree = 'yes'])"/>
	<xsl:variable name="n"
			select="($node/outline[$bHasChildren] |
								$parent/outline[not($bHasChildren)])[@tree = 'yes']"/>

	<xsl:if test="$n">
		<ul class="PanelMenu">
			<xsl:apply-templates select="$n[@id != 'ayuda']" mode="p:panel-menu">
					<xsl:with-param name="node" select="$node"/>
				</xsl:apply-templates>
		</ul>
	</xsl:if>
</xsl:template>

<!-- an outline node -->
<xsl:template match="outline[outline[@tree = 'yes']]" mode="p:panel-menu">
	<li class="PanelMenuNode">
		<a class="PanelMenu" href="{@url}">
			<xsl:value-of select="@text"/>
		</a>
	</li>
</xsl:template>

<!-- an outline leave -->
<xsl:template match="outline[not(outline[@tree = 'yes'])]" mode="p:panel-menu">
	<xsl:param name="node"/>

	<xsl:choose>
			<xsl:when test="self::outline/@id = $node/@id">
			<li class="PanelMenuCurrent">
					<xsl:value-of select="@text"/>
			</li>
		</xsl:when>
		<xsl:otherwise>
			<li class="PanelMenuLeave">
				<a class="PanelMenu" href="{@url}">
					<xsl:value-of select="@text"/>
				</a>
			</li>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
 ! footer
 !-->
<xsl:template match="h:html" mode="p:page-footer">
	<ul id="FooterLinks">
		<!--<li>§</li>-->

		<li>
			<a target="_blank" class="FooterLink" style="padding:0;background-color:transparent;" href="/feed.rss" title="{tables:text('subscribe-titulo')}">
				<img src="/images/rss" class="RSSIcon" width="29" height="16" alt="{tables:text('subscribe')}"/>
			</a>
		</li>

		<li>
			<a target="_blank" class="FooterLink" style="padding:0;background-color:transparent;" href="/feed.atom" title="{tables:text('subscribe-titulo')}">
				<img src="/images/atom" class="RSSIcon" width="32" height="16" alt="{tables:text('subscribe')}"/>
			</a>
		</li>

		<!--<li>§</li>-->

		<li>
			<a target="_blank" class="FooterLink" href="&OPINAR;" title="{tables:text('opinar-titulo')}">
				<xsl:value-of select="tables:text('opinar')"/>
			</a>
		</li>

		<li>
			<a target="_blank" class="FooterLink" href="&FORO;" title="{tables:text('foro-titulo')}">
				<xsl:value-of select="tables:text('foro')"/>
			</a>
		</li>

		<li>
			<a target="_blank" class="FooterLink" href="mailto:{tables:text('webmaster')}" title="{tables:text('xmail')}">
				<xsl:value-of select="tables:text('contacto')"/>
			</a>
		</li>

		<!--
		<li>§</li>

		<li>
			<a class="FooterLink" href="https://github.com/espectroautista/espectroautista.github.io/archive/master.zip" title="{tables:text('descargas')}">
				descarga
			</a>
		</li>
		-->

	</ul>

	<a class="FooterGoTop" href="#" title="{tables:text('arriba-titulo')}">
		<xsl:value-of select="tables:text('arriba')"/>
	</a>
</xsl:template>

<!--
 !	navigation: siblings (for not leaves)
 !-->
<xsl:template match="outline[outline[@tree = 'yes']]" mode="node.immediate-siblings">
	<xsl:variable name="preceding"
		select="preceding-sibling::outline[@tree = 'yes' and @siblings = 'yes'][1]"/>

	<xsl:variable name="following"
		select="following-sibling::outline[@tree = 'yes'][1]"/>

	<xsl:choose>
		<xsl:when test="not($preceding)">
			<span class="SiblingPreceding">
				<span class="Symbol"><xsl:text>&LEFT;</xsl:text></span>
				<xsl:text>&nbsp;</xsl:text>
				<xsl:value-of select="tables:text('Panterior')"/>
			</span>
		</xsl:when>
		<xsl:otherwise>
			<a href="{$preceding/@url}" title="{$preceding/@text}" class="TreeNav SiblingPreceding">
				<span class="Symbol"><xsl:text>&LEFT;</xsl:text></span>
				<xsl:text>&nbsp;</xsl:text>
				<xsl:value-of select="tables:text('Panterior')"/>
			</a>
		</xsl:otherwise>
	</xsl:choose>

	<xsl:choose>
		<xsl:when test="not($following)">
			<span class="SiblingFollowing">
				<xsl:value-of select="tables:text('Psiguiente')"/>
				<xsl:text>&nbsp;</xsl:text>
				<span class="Symbol"><xsl:text>&RIGHT;</xsl:text></span>
			</span>
		</xsl:when>
		<xsl:otherwise>
			<a href="{$following/@url}" title="{$following/@text}" class="TreeNav SiblingFollowing">
				<xsl:value-of select="tables:text('Psiguiente')"/>
				<xsl:text>&nbsp;</xsl:text>
				<span class="Symbol"><xsl:text>&RIGHT;</xsl:text></span>
			</a>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<!--
 !	default methods
 !-->
<xsl:template match="h:html" mode="node.scripts"/>
<xsl:template match="h:html" mode="node.styles"/>
<xsl:template match="h:html" mode="node.menus"/>
<xsl:template match="h:html" mode="node.after-scripts"/>

<xsl:template match="h:html" mode="node.breadcrumb">
	<xsl:param name="node" select="tables:outline(@id)"/>

	<xsl:for-each select="$node/ancestor::outline">
		<a class="Breadcrumb" href="{@url}"><xsl:value-of select="@text"/></a>
		<span class="BreadcrumbArrow">&ARROW;</span>
	</xsl:for-each>

	<strong class="BreadcrumbHere"><xsl:value-of select="$node/@text"/></strong>
</xsl:template>

<!--
 ! for nodes not in the tree (SSI processed)
 !-->
<xsl:template match="h:html" mode="node.panel-navigation">
	<xsl:comment>#if expr='$HTTP_REFERER' </xsl:comment>

		<xsl:comment>#set var='html' value='&lt;a class="TreeNav" href="$HTTP_REFERER"&gt;' </xsl:comment>
		<xsl:comment>#echo encoding='none' var='html' </xsl:comment>
			<span class="Symbol"><xsl:text>&LEFT;</xsl:text></span>
			<xsl:value-of select="tables:text('anterior')"/>
		<xsl:comment>#set var='html' value='&lt;/a&gt;' </xsl:comment>
		<xsl:comment>#echo encoding='none' var='html' </xsl:comment>

	<xsl:comment>#else </xsl:comment>

		<div class="TreeNav">
			<a class="TreeNav" href="/" title="{tables:text('navStart')}">
				<span class="Symbol"><xsl:text>&UP;</xsl:text></span>
				<xsl:value-of select="tables:text('subir')"/>
			</a>
		</div>

	<xsl:comment>#endif </xsl:comment>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
