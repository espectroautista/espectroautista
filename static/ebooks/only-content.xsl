<?xml version="1.0" encoding="UTF-8"?>
<!--
 * only-content.xsl
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY XHTMLNS "http://www.w3.org/1999/xhtml">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	exclude-result-prefixes="h"
>

<xsl:import href="xhtml-to-OPS.xsl"/>

<!--
 ! output only contents
 !-->
<xsl:template match="h:body">
		<body>
			<xsl:apply-templates select="@*"/>

			<div style="text-align: center;">
				<a href="index.html" style="border: none;">
					<img src="{id('Logo')/h:img/@src}" style="border: none; width: 150px; height: 100px;" alt="Logo"/>
				</a>
				<br/>
				<a href="index.html" style="font-weight: bold; font-size: xx-large; text-decoration: none;">
					<xsl:copy-of select="id('Title')/text()"/>
				</a>
			</div>

			<div id="Content">
				<xsl:apply-templates select="id('PrinterButtons')/following-sibling::node()"/>
			</div>

			<!-- off-line notice -->
			<hr/>

			<xsl:apply-templates select="h:p"/>
		</body>
</xsl:template>

<!--
 ! TODO: match head, add stylesheet amb apply-imports
 !-->

<!--
 ! ignore some stylesheets, favicon, videos, etc.
 !-->
<xsl:template match="h:link[@media = 'print']"/>
<xsl:template match="h:link[@title = 'Printer']"/>
<xsl:template match="h:link[contains(@rel, 'stylesheet') and
	(   @href != 'styles/content.css'
	and @href != 'styles/blog.css'
	and @href != 'styles/choice.css'
	and @href != 'styles/glosario.css'
	and @href != 'styles/likert.css'
	and @href != 'styles/mapa.css'
	and @href != 'styles/palabras.css'
	and @href != 'styles/pub.css')]
	"/>


<xsl:template match="h:div[@class = 'Video']"/>
<xsl:template match="h:link[@rel = 'shortcut icon']"/>

<!--
 ! ignore comments & PIs
 !-->
<xsl:template match="comment() | processing-instruction()"/>

<!--
 ! ignore external links
 !-->
 <xsl:template match="h:a[starts-with(@href, 'http://')]">
	 <span>
			<xsl:apply-templates select="node()"/>
	 </span>
 </xsl:template>
 <xsl:template match="h:a/@hreflang"/>
 <xsl:template match="h:a/@type"/>

<!--
 !  tests
 !-->
 <!--<xsl:template match="h:div[@class = 'NavigationArrows']"/>-->
<xsl:template match="id('TestButtons')">
	<div id="TestButtons" style="visibility:hidden;"/>
</xsl:template>
<xsl:template match="id('TestTotal')"/>
<xsl:template match="id('TestFooter')"/>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
