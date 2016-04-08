<?xml version="1.0" encoding="UTF-8"?>
<!--
 * blog.xsl - Índice del portal, en estilo blog.
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
	<!ENTITY MONTHS "6">
	<!ENTITY FEED "feed.atom">
	<!ENTITY NEWS "blog">
	<!ENTITY NTAGS "30">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	xmlns:p="urn:uuid:686d133a-a7f1-11dd-a3ab-001fc6576244"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns:exsl="http://exslt.org/common"
	xmlns:dyn="http://exslt.org/dynamic"
  xmlns:set="http://exslt.org/sets"
	extension-element-prefixes="date dyn exsl set"
	exclude-result-prefixes="p tables h x"
>

<xsl:import href="../lib/cloud.xsl"/>
<xsl:import href="../lib/node.xsl"/>

<xsl:template match="h:html" mode="node.styles">
	<link media="all" rel="stylesheet" type="text/css" href="/styles/blog"/>
</xsl:template>

<xsl:template match="h:html" mode="node.breadcrumb">
	<xsl:param name="node"/>
	<xsl:param name="sFeedID"/>

	<xsl:choose>
		<xsl:when test="$sFeedID = ''">
			<xsl:apply-imports/>
		</xsl:when>
		<xsl:otherwise> <!-- generating F<YYYY>-<MM>.html and F<YYYY>.html -->
			<xsl:choose>
				<xsl:when test="contains($sFeedID, '-')">	<!-- generating one month -->
					<a class="Breadcrumb" href="/"><xsl:value-of select="$node/@text"/></a>

					<span class="BreadcrumbArrow">&ARROW;</span>

					<!-- link to year -->
					<a class="Breadcrumb" href="/blog/{substring($sFeedID, 2, 4)}">
						<xsl:value-of select="substring($sFeedID, 2, 4)"/>
					</a>

					<span class="BreadcrumbArrow">&ARROW;</span>

					<!-- month -->
					<strong class="BreadcrumbHere"><xsl:value-of select="substring($sFeedID, 7, 2)"/></strong>
				</xsl:when>
				<xsl:otherwise>
					<!-- year -->
					<a class="Breadcrumb" href="/"><xsl:value-of select="$node/@text"/></a>

					<span class="BreadcrumbArrow">&ARROW;</span>

					<strong class="BreadcrumbHere"><xsl:value-of select="substring($sFeedID, 2)"/></strong>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="h:object[@class = 'TAGS']">
	<xsl:call-template name="cloud.tags">
		<xsl:with-param name="ntags" select="&NTAGS;"/>
		<xsl:with-param name="first-letter" select="true()"/>
	</xsl:call-template>
</xsl:template>

<xsl:template match="h:h2[@class='entry-title']">
		<h2 class="IndexLabel">
			<a	class="Symbol" href="#">&UP;</a>
			<span style="width: 1em;">&#160;</span>

			<xsl:apply-templates/>
		</h2>
</xsl:template>

<xsl:template match="h:body[../@id = 'index']">
	<xsl:param name="node"/>
	<xsl:param name="sFeedID"/>

	<xsl:choose>
		<xsl:when test="$sFeedID = ''">	<!-- generating index.html -->
			<xsl:call-template name="make-secondary-files">
				<xsl:with-param name="node" select="$node"/>
			</xsl:call-template>

			<!-- before the first feed -->
			<xsl:apply-templates select="h:div[@class = 'hfeed'][1]/preceding-sibling::*"/>

			<!-- feeds -->
			<div class="hfeed">
				<xsl:for-each select="h:div[@class = 'hfeed'][position() &lt;= &MONTHS;]
																		/h:div[@class = 'hentry']">
					<div class="hentry">
						<!-- TODO: cal aquest <a> ???
						<a id="{@id}"></a> -->

						<xsl:apply-templates select="*"/>
					</div>
				</xsl:for-each>
			</div>

			<!-- after the last feed -->
			<xsl:apply-templates select="h:div[@class = 'hfeed'][last()]/following-sibling::*"/>

		</xsl:when>
		<xsl:otherwise>	<!-- generating blog -->
			<xsl:choose>
				<xsl:when test="contains($sFeedID, '-')">	<!-- generating one month -->
					<h1>
						<xsl:variable name="id" select="h:div[@id = $sFeedID]/@id"/>

						<xsl:value-of select="substring($id, 2, 4)"/>
						<xsl:text> &mdash; </xsl:text>

						<span class="Month"><xsl:value-of select="x:month(substring($id, 7))"/></span>
					</h1>

					<div class="hfeed">
						<xsl:for-each select="h:div[@id = $sFeedID]/h:div[@class = 'hentry']">
							<xsl:sort select="h:a/h:abbr/@title" order="ascending"/>

							<div class="hentry">
								<a id="{@id}"/><xsl:apply-templates select="*"/></div>
						</xsl:for-each>
					</div>
				</xsl:when>
				<xsl:otherwise>	<!-- generating one year listing -->
					<h1>
						<xsl:value-of select="substring($sFeedID, 2)"/>
						<xsl:text> &mdash; </xsl:text>
						<span><xsl:value-of select="tables:text('archivo')"/></span>
					</h1>

					<xsl:variable name="sYear" select="substring($sFeedID, 2)"/>

					<dl>
						<xsl:for-each select="h:div[@class = 'hfeed']
											[substring(@id, 2, 4) = $sYear]/h:div[@class = 'hentry']">
							<xsl:sort select="h:a[@rel = 'bookmark']/h:abbr/@title" order="ascending"/>

							<!-- TODO: group by days (for > 1 fedds for day) -->
							<dt class="bookmark">
									<xsl:value-of select="h:a[@rel = 'bookmark']/h:abbr"/>
							</dt>

							<dd>
								<a href="{h:a[@rel = 'bookmark']/@href}">
									<xsl:value-of select="h:h2[@class = 'entry-title']"/>
								</a>
							</dd>
						</xsl:for-each>
					</dl>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
! Secondary files
!-->
<xsl:template name="make-secondary-files">
	<xsl:param name="node"/>

	<!-- for Atom feed -->
	<exsl:document
		href="&FEED;"
		method="xml"
		version="1.0"
		encoding="UTF-8"
		omit-xml-declaration="no"
		standalone="yes"
		indent="yes"
		media-type="application/atom+xml"
	>
		<xsl:call-template name="make-atom"/>
	</exsl:document>

	<xsl:variable name="index" select="/h:html"/>

	<!-- for permalinks -->
	<xsl:for-each select="h:div[@class = 'hfeed']">
		<exsl:document
			method="xml"
			doctype-system="about:legacy-compat"
			href="{@id}.html"
			encoding="UTF-8"
			indent="no"
			media-type="text/html"
			omit-xml-declaration="yes"
			version="1.0"
		>
			<!-- recurse -->
			<xsl:apply-templates select="$index">
				<xsl:with-param name="node" select="$node"/>
				<xsl:with-param name="parent" select="$node"/>
				<xsl:with-param name="sFeedID" select="string(@id)"/>
				<xsl:with-param name="sTitle"
					select="concat(tables:text('sitename'), ': ', substring(@id, 2))"/>
			</xsl:apply-templates>
		</exsl:document>
	</xsl:for-each>

	<!-- listings for each year -->
	<xsl:variable name="years" select="
		set:distinct(dyn:map(h:div[@class = 'hfeed']/@id, 'substring(., 2, 4)'))
		"/>

	<xsl:for-each select="$years">
		<xsl:variable name="sYear" select="."/>
		<exsl:document
			method="xml"
			doctype-system="about:legacy-compat"
			href="F{$sYear}.html"
			encoding="UTF-8"
			indent="no"
			media-type="text/html"
			omit-xml-declaration="yes"
			version="1.0"
		>
			<!-- one year -->
			<xsl:apply-templates select="$index">
				<xsl:with-param name="node" select="$node"/>
				<xsl:with-param name="parent" select="$node"/>
				<xsl:with-param name="sFeedID" select="concat('F', $sYear)"/>
				<xsl:with-param name="sTitle"
					select="concat(tables:text('sitename'), ': ', $sYear)"/>
			</xsl:apply-templates>
		</exsl:document>
	</xsl:for-each>
</xsl:template>

<!--
! Generates the feed
!-->
<xsl:template name="make-atom">
	<xsl:processing-instruction name="xml-stylesheet">
		<xsl:text>type="text/css" href="/styles/atom"</xsl:text>
	</xsl:processing-instruction>
	<xsl:text>&#10;</xsl:text>

	<feed
		xmlns="http://www.w3.org/2005/Atom"
		xml:lang="{$Language}"
		xml:base="{tables:text('site')}"
	>
	<id><xsl:value-of select="h:div[@class = 'hfeed'][1]/@title"/></id>
		<title><xsl:value-of select="tables:text('sitename')"/></title>
		<updated><xsl:value-of select="date:date-time()"/></updated>

		<link href="&SITE;&FEED;" rel="self"/>
		<link href="&SITE;&NEWS;" hreflang="{$Language}" rel="alternate"/>

		<author>
			<name>kleine Professoren</name>
		</author>

		<generator>XSLT stylesheet by JJOR</generator>
		<logo>&SITE;images/logo-espectro-autista.png</logo>
		<icon>&SITE;favicon.ico</icon>

		<xsl:for-each select="h:div[@class = 'hfeed'][position() &lt;= &MONTHS;]">
			<xsl:for-each select="h:div[@class = 'hentry']">
				<entry>

					<id><xsl:value-of select="@title"/></id>
					<title>
						<xsl:value-of select="h:h2[@class = 'entry-title']"/>
					</title>
					<published>
						<xsl:value-of select="descendant::h:abbr[@class = 'published']/@title"/>
					</published>
					<updated>
						<xsl:value-of select="descendant::h:abbr[@class = 'published']/@title"/>
					</updated>

					<link href="&SITE;{concat('blog/', substring(../@id, 2, 4), '/', substring(../@id, 7), '#', @id)}"
								hreflang="{$Language}" rel="alternate"/>
					<content type="xhtml" xml:lang="{$Language}">
						<div xmlns="&XHTMLNS;" lang="{$Language}">
							<xsl:apply-templates select="h:div[@class = 'entry-content']/node()"/>
						</div>
					</content>
				</entry>
			</xsl:for-each>
		</xsl:for-each>
	</feed>
</xsl:template>

<!--
 ! Links for site navigation
 !-->
<xsl:template match="h:html" mode="blog.navigation-link">
	<xsl:param name="sFeedID"/>

	<!-- parent  -->
	<xsl:choose>
		<xsl:when test="contains($sFeedID, '-')">	<!-- generating one month -->
			<xsl:variable name="year" select="substring($sFeedID, 2, 4)"/>
			<xsl:variable name="url" select="concat('/blog/', $year)"/>
			<xsl:variable name="title" select="concat($year, ' &mdash; ', tables:text('archivo'))"/>

			<link rel="Up" href="{$url}" title="{$title}"/>
			<link rel="Section" href="{$url}" title="{$title}"/>
		</xsl:when>

		<xsl:otherwise> <!-- year listing -->
			<link rel="Up" href="{tables:outline('index')/@url}" title="{tables:text('navStart')}"/>
			<link rel="Section" href="{tables:outline('index')/@url}" title="{tables:text('navStart')}"/>

			<!-- link subsections -->
			<xsl:variable name="months"
				select="h:body/h:div[@class = 'hfeed'][substring(@id, 1, 5) = $sFeedID]"/>
			<xsl:variable name="year" select="substring($sFeedID, 2)"/>

			<xsl:for-each select="$months">
				<xsl:sort select="@id" order="ascending"/>

				<xsl:variable name="month" select="substring(@id, 7, 2)"/>

				<link rel="Subsection" href="/blog/{$year}/{$month}" title="{$year}-{$month}"/>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>

	<!-- siblings (link with neighbourhood feeds) -->
	<xsl:choose>
		<xsl:when test="contains($sFeedID, '-')">	<!-- generating one month -->
			<xsl:variable name="feeds" select="h:body/h:div[@class = 'hfeed']"/>
			<xsl:variable name="sFirst" select="$feeds[last()]/@id"/>
			<xsl:variable name="sLast" select="$feeds[1]/@id"/>

			<xsl:choose>
				<xsl:when test="$sFeedID = $sFirst">
					<xsl:variable name="sNext" select="$feeds[last()-1]/@id"/>

					<link rel="Next" href="/blog/{substring($sNext, 2, 4)}/{substring($sNext, 7, 2)}" title="{substring($sNext, 2)}"/>
					<link rel="Last" href="/blog/{substring($sLast, 2, 4)}/{substring($sLast, 7, 2)}" title="{substring($sLast, 2)}"/>
				</xsl:when>

				<xsl:when test="$sFeedID = $sLast">
					<xsl:variable name="sPrev" select="$feeds[2]/@id"/>

					<link rel="First" href="/blog/{substring($sFirst, 2, 4)}/{substring($sFirst, 7, 2)}" title="{substring($sFirst, 2)}"/>
					<link rel="Prev" href="/blog/{substring($sPrev, 2, 4)}/{substring($sPrev, 7, 2)}" title="{substring($sPrev, 2)}"/>
				</xsl:when>

				<xsl:otherwise>
					<xsl:variable name="sPrev" select="$feeds[@id = $sFeedID]/following-sibling::*[1]/@id"/>
					<xsl:variable name="sNext" select="$feeds[@id = $sFeedID]/preceding-sibling::*[1]/@id"/>

					<link rel="First" href="/blog/{substring($sFirst, 2, 4)}/{substring($sFirst, 7, 2)}" title="{substring($sFirst, 2)}"/>
					<link rel="Prev" href="/blog/{substring($sPrev, 2, 4)}/{substring($sPrev, 7, 2)}" title="{substring($sPrev, 2)}"/>
					<link rel="Next" href="/blog/{substring($sNext, 2, 4)}/{substring($sNext, 7, 2)}" title="{substring($sNext, 2)}"/>
					<link rel="Last" href="/blog/{substring($sLast, 2, 4)}/{substring($sLast, 7, 2)}" title="{substring($sLast, 2)}"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>

		<xsl:otherwise>
				<!-- siblings for year listings -->
			<xsl:variable name="years" select="set:distinct(dyn:map(h:body/h:div[@class = 'hfeed']/@id, 'substring(., 2, 4)'))"/>
			<xsl:variable name="year" select="substring($sFeedID, 2)"/>

			<xsl:choose>
				<xsl:when test="$year = $years[last()]">
					<xsl:variable name="sNext" select="string(number($year) + 1 )"/>

					<link rel="Next" href="/blog/{$sNext}" title="{$sNext}"/>
					<link rel="Last" href="/blog/{$years[1]}" title="{$years[1]}"/>
				</xsl:when>

				<xsl:when test="$year = $years[1]">
					<xsl:variable name="sPrev" select="string(number($year) - 1)"/>

					<link rel="First" href="/blog/{$years[last()]}" title="{$years[last()]}"/>
					<link rel="Prev" href="/blog/{$sPrev}" title="{$sPrev}"/>
				</xsl:when>

				<xsl:otherwise>
					<xsl:variable name="sPrev" select="string(number($year) - 1)"/>
					<xsl:variable name="sNext" select="string(number($year) + 1 )"/>

					<link rel="First" href="/blog/{$years[last()]}" title="{$years[last()]}"/>
					<link rel="Prev" href="/blog/{$sPrev}" title="{$sPrev}"/>
					<link rel="Next" href="/blog/{$sNext}" title="{$sNext}"/>
					<link rel="Last" href="/blog/{$years[1]}" title="{$years[1]}"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
 ! Links for menu navigation
 !-->
<xsl:template name="p:menu-item">
	<xsl:param name="sDate"/>
	<xsl:param name="sLabel"/>

	<xsl:variable name="year" select="substring($sDate, 2, 4)"/>
	<xsl:variable name="month" select="substring($sDate, 7, 2)"/>

	<xsl:call-template name="html.anchor">
		<xsl:with-param name="sClass" select="'TopMenu'"/>
		<xsl:with-param name="sText" select="$sLabel"/>
		<xsl:with-param name="sHref" select="concat('/blog/', $year, '/', $month)"/>
		<xsl:with-param name="sTitle" select="concat($year, '-', $month)"/>
	</xsl:call-template>
</xsl:template>

<xsl:template match="h:html" mode="blog.navigation-menu">
	<xsl:param name="sFeedID"/>

	<!-- siblings (link with neighbourhood feeds) -->
	<xsl:variable name="feeds" select="h:body/h:div[@class = 'hfeed']"/>
	<xsl:variable name="sFirst" select="$feeds[last()]/@id"/>
	<xsl:variable name="sLast" select="$feeds[1]/@id"/>

	<xsl:choose>
		<xsl:when test="$sFeedID = $sFirst">
			<xsl:variable name="sNext" select="$feeds[last()-1]/@id"/>

			<li><xsl:value-of select="tables:text('blogF')"/></li>
			<li><xsl:value-of select="tables:text('blogP')"/></li>
			<li><xsl:call-template name="p:menu-item">
						<xsl:with-param name="sDate" select="$sNext"/>
						<xsl:with-param name="sLabel" select="tables:text('blogN')"/>
					</xsl:call-template></li>
			<li><xsl:call-template name="p:menu-item">
						<xsl:with-param name="sDate" select="$sLast"/>
						<xsl:with-param name="sLabel" select="tables:text('blogL')"/>
					</xsl:call-template></li>
		</xsl:when>

		<xsl:when test="$sFeedID = $sLast">
			<xsl:variable name="sPrev" select="$feeds[2]/@id"/>

			<li><xsl:call-template name="p:menu-item">
						<xsl:with-param name="sDate" select="$sFirst"/>
						<xsl:with-param name="sLabel" select="tables:text('blogF')"/>
					</xsl:call-template></li>
			<li><xsl:call-template name="p:menu-item">
						<xsl:with-param name="sDate" select="$sPrev"/>
						<xsl:with-param name="sLabel" select="tables:text('blogP')"/>
					</xsl:call-template></li>
			<li><xsl:value-of select="tables:text('blogN')"/></li>
			<li><xsl:value-of select="tables:text('blogL')"/></li>
		</xsl:when>

		<xsl:otherwise>
			<xsl:variable name="sPrev" select="$feeds[@id = $sFeedID]/following-sibling::*[1]/@id"/>
			<xsl:variable name="sNext" select="$feeds[@id = $sFeedID]/preceding-sibling::*[1]/@id"/>

			<li><xsl:call-template name="p:menu-item">
						<xsl:with-param name="sDate" select="$sFirst"/>
						<xsl:with-param name="sLabel" select="tables:text('blogF')"/>
					</xsl:call-template></li>
			<li><xsl:call-template name="p:menu-item">
						<xsl:with-param name="sDate" select="$sPrev"/>
						<xsl:with-param name="sLabel" select="tables:text('blogP')"/>
					</xsl:call-template></li>
			<li><xsl:call-template name="p:menu-item">
						<xsl:with-param name="sDate" select="$sNext"/>
						<xsl:with-param name="sLabel" select="tables:text('blogN')"/>
					</xsl:call-template></li>
			<li><xsl:call-template name="p:menu-item">
						<xsl:with-param name="sDate" select="$sLast"/>
						<xsl:with-param name="sLabel" select="tables:text('blogL')"/>
					</xsl:call-template></li>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
 ! Links for panel links
 !-->
<xsl:template match="h:html" mode="blog.panel-archives">
	<xsl:param name="sFeedID"/>

	<xsl:variable name="body" select="h:body"/>
	<xsl:variable name="years" select="set:distinct(dyn:map(h:body/h:div[@class = 'hfeed']/@id, 'substring(., 2, 4)'))"/>
	<xsl:variable name="sYear">
		<xsl:choose>
			<xsl:when test="$sFeedID = ''">	<!-- index.html -->
				<xsl:value-of select="$years[1]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring($sFeedID, 2, 4)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:for-each select="$years">
		<!-- background inherit to disable :hover -->
		<li class="PanelMenuNode" style="background: inherit">
			<xsl:choose>
				<xsl:when test=". != $sYear">
					<a class="PanelMenu" href="/blog/{.}"><xsl:value-of select="."/></a>
				</xsl:when>

				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="contains($sFeedID, '-') or $sFeedID = ''">
							<a class="PanelMenu" href="/blog/{$sYear}"><xsl:value-of select="$sYear"/></a>
						</xsl:when>

						<xsl:otherwise>
							<b><xsl:value-of select="."/></b>
						</xsl:otherwise>
					</xsl:choose>

					<ul>
						<xsl:for-each select="$body/h:div[@class = 'hfeed'][substring(@id, 2, 4) = $sYear]">
							<xsl:sort select="@id" order="ascending"/>

							<!-- background inherit to disable :hover -->
							<li class="PanelMenuLeave"
								style="background: inherit; font-weight: normal;">
								<xsl:choose>
									<xsl:when test="@id = $sFeedID">
										<b><xsl:value-of select="x:month(substring(@id, 7))"/></b>
									</xsl:when>

									<xsl:otherwise>
										<xsl:variable name="path" select="concat('/blog/', substring(@id, 2, 4), '/', substring(@id, 7))"/>

										<a class="PanelMenu" href="{$path}"><xsl:value-of select="x:month(substring(@id, 7))"/></a>
									</xsl:otherwise>
								</xsl:choose>
							</li>
						</xsl:for-each>
					</ul>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:for-each>
</xsl:template>

<!--
 !	navigation: siblings (for not leaves)
 !-->
<xsl:template match="outline[outline[@tree = 'yes']]" mode="node.immediate-siblings">
	<!-- ignore -->
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
