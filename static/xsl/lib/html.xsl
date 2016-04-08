<?xml version="1.0" encoding="UTF-8"?>
<!--
 * html.xsl - Gestión de elementos HTML.
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
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h x tables"
>

<xsl:import href="xlib.xsl"/>
<xsl:import href="error.xsl"/>

<!--
 ! Verbatim HTML elements
 !-->
<xsl:template match="h:br">
	<br/>
</xsl:template>

<xsl:template match="h:acronym">
	<abbr>
    <xsl:copy-of select="@*"/>
		<xsl:apply-templates/>
	</abbr>
</xsl:template>

<xsl:template match="
	h:abbr|h:cite|h:code|h:dfn|h:em|h:span|h:kbd|h:samp|h:var|h:strong|h:var|
	h:address|h:blockquote|h:div|h:p|h:pre|
	h:tr|h:td|h:th|h:caption|h:thead|h:tbody|h:tfoot|h:col|h:colgroup|
	h:dl|h:dt|h:dd|h:ol|h:ul|h:li|h:quote|
	h:hr|h:b|h:i|h:img|h:sub|h:sup|h:q|h:del|h:ins
">
  <xsl:element name="{local-name()}">
    <xsl:copy-of select="@*"/>
		<xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:h1|h:h2|h:h3|h:h4|h:h5|h:h6">
  <xsl:element name="{local-name()}">
		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:attribute name="id">
			<xsl:value-of select="$id"/>
		</xsl:attribute>

    <xsl:copy-of select="@*[local-name() != 'id']"/>

		<xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<!--
 ! Tables
 !-->
<xsl:template match="h:table">
	<table style="width:{@width}">
		<xsl:call-template name="error.assert">
			<xsl:with-param name="test" select="boolean(h:caption)"/>
			<xsl:with-param name="text">expected &lt;caption&gt;</xsl:with-param>
		</xsl:call-template>

		<xsl:if test="@id">
			<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="h:tbody"><xsl:apply-templates/></xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="h:caption"/>

				<tbody>
					<xsl:apply-templates select="h:tr"/>
				</tbody>
			</xsl:otherwise>
		</xsl:choose>
	</table>
</xsl:template>

<!--
 ! Anchors
 !-->
<xsl:template match="h:a[not(@href)]">
	<xsl:call-template name="error.terminate">
		<xsl:with-param name="text">
			<xsl:text>html.xsl: unexpected attribute a without href: </xsl:text>
			<xsl:value-of select="/@id"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:a[h:img]" priority="2">
	<a href="{@href}"><xsl:if test="substring(x:lower(@href), string-length(@href) - 3) = '.pdf'">
			<xsl:attribute name="type">application/pdf</xsl:attribute>
			<xsl:attribute name="target">_blank</xsl:attribute>
		</xsl:if><xsl:apply-templates/></a>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:a[@href]">
	<xsl:variable name="rContent">
		<xsl:apply-templates/>
	</xsl:variable>

	<xsl:call-template name="html.anchor">
		<xsl:with-param name="sText" select="string($rContent)"/>
		<xsl:with-param name="sTitle" select="string(@title)"/>
		<xsl:with-param name="sName" select="string(@name|@id)"/>
		<xsl:with-param name="sHref" select="string(@href)"/>
		<xsl:with-param name="sClass" select="string(@class)"/>
		<xsl:with-param name="sHreflang" select="string(@hreflang)"/>
	</xsl:call-template>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template name="html.anchor">
	<xsl:param name="sId"/>
	<xsl:param name="sName"/>
	<xsl:param name="sClass"/>
	<xsl:param name="sHref"/>
	<xsl:param name="sTitle"/>
	<xsl:param name="sText"/>
	<xsl:param name="sOnClick"/>
	<xsl:param name="sHreflang" select="''"/>
	<xsl:param name="sTarget"/>

	<xsl:variable name="rTitle">
		<xsl:choose>
			<xsl:when test="not($sTitle) or starts-with($sHref, tables:text('site'))">
				<!-- NONE -->
			</xsl:when>
			<xsl:when test="starts-with($sHref, 'http://')">
				<xsl:value-of select="tables:text('xlink')"/>	
			</xsl:when>
			<xsl:when test="starts-with($sHref, 'mailto:')">
				<xsl:value-of select="tables:text('xmail')"/>	
			</xsl:when>
			<xsl:when test="not($sTitle) or $sTitle = $sText">
				<!-- NONE <xsl:value-of select="$sHref"/> -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$sTitle"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:element name="a">

		<xsl:if test="$sClass">
			<xsl:attribute name="class">
				<xsl:value-of select="$sClass"/>
			</xsl:attribute>
		</xsl:if>

		<xsl:if test="starts-with($sHref, 'http://')">
					<xsl:attribute name="target">_blank</xsl:attribute>
		</xsl:if>
		<xsl:if test="starts-with($sHref, 'https://')">
					<xsl:attribute name="target">_blank</xsl:attribute>
		</xsl:if>
		<xsl:if test="$sTarget">
			<xsl:attribute name="target">
				<xsl:value-of select="$sTarget"/>
			</xsl:attribute>
		</xsl:if>


		<xsl:attribute name="href">
			<xsl:choose>
				<xsl:when test="starts-with($sHref, 'http://')">
					<xsl:value-of select="$sHref"/>	<!-- leave untouched -->
				</xsl:when>
				<xsl:when test="starts-with($sHref, 'mailto:')">
					<xsl:value-of select="$sHref"/>	<!-- leave untouched -->
				</xsl:when>
				<xsl:when test="starts-with($sHref, '#')">
					<xsl:value-of select="$sHref"/>	<!-- leave untouched -->
				</xsl:when>
				<xsl:when test="starts-with($sHref, '?')">
					<xsl:value-of select="$sHref"/>	<!-- leave untouched -->
				</xsl:when>
				<xsl:when test="starts-with($sHref, '/')">
					<!-- absolute internal URL -->
					<xsl:value-of select="$sHref"/>
				</xsl:when>
				<xsl:when test="not(contains($sHref, '/'))">
					<!-- a flat filename (internal URL) -->
					<xsl:value-of select="tables:route($sHref)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="error.terminate">
						<xsl:with-param name="text">
							<xsl:text>html.xsl; unexpected URL: </xsl:text>
							<xsl:value-of select="$sHref"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

		<xsl:if test="$rTitle != ''">
			<xsl:attribute name="title"><xsl:value-of select="$rTitle"/></xsl:attribute>
		</xsl:if>

		<xsl:if test="$sId">
			<xsl:attribute name="id"><xsl:value-of select="$sId"/></xsl:attribute>
		</xsl:if>

		<xsl:if test="$sName">
			<xsl:attribute name="id"><xsl:value-of select="$sName"/></xsl:attribute>
		</xsl:if>

		<!-- relationships -->
		<xsl:if test="@rel">
			<xsl:attribute name="rel"><xsl:value-of select="@rel"/></xsl:attribute>
		</xsl:if>

		<xsl:if test="@rev">
			<xsl:attribute name="rev"><xsl:value-of select="@rev"/></xsl:attribute>
		</xsl:if>

		<!-- @hreflang -->
		<xsl:if test="$sHreflang">
			<xsl:attribute name="hreflang">
				<xsl:value-of select="$sHreflang"/>
			</xsl:attribute>
		</xsl:if>

		<!-- @type -->
		<xsl:choose>
			<xsl:when test="@type">
				<xsl:attribute name="type">
					<xsl:value-of select="@type"/>
				</xsl:attribute>
			</xsl:when>
			<!-- add 'type' attribute if possible (TODO: extend with more types)-->
			<xsl:otherwise>
				<xsl:variable name="sA" select="x:lower($sHref)"/>
				<xsl:variable name="nN" select="string-length($sA)"/>
				<xsl:choose>
					<xsl:when test="substring($sA, $nN - 4) = '.html'">
						<xsl:attribute name="type">text/html</xsl:attribute>
					</xsl:when>
					<xsl:when test="substring($sA, $nN - 3) = '.htm'">
						<xsl:attribute name="type">text/html</xsl:attribute>
					</xsl:when>
					<xsl:when test="substring($sA, $nN - 3) = '.pdf'">
						<xsl:attribute name="type">application/pdf</xsl:attribute>
						<xsl:attribute name="target">_blank</xsl:attribute>
					</xsl:when>
					<xsl:when test="substring($sA, $nN - 3) = '.txt'">
						<xsl:attribute name="type">text/plain</xsl:attribute>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

		<!-- events (menus, tests) -->
		<xsl:if test="$sOnClick">
			<xsl:attribute name="onclick">
				<xsl:value-of select="$sOnClick"/>
			</xsl:attribute>
		</xsl:if>

		<!-- the anchor content -->
		<xsl:value-of select="$sText"/>

	</xsl:element>

	<!-- the URL after external links for media of type print -->
	<xsl:if test="starts-with($sHref, 'http:')and not(starts-with($sHref, 'http://EspectroAutista.Info'))">
		<span class="External">
			<xsl:text/> (<xsl:value-of select="$sHref"/>)<xsl:text/>
		</span>
	</xsl:if>
</xsl:template>

<!--
 ! Unexpected elements or attributes in ANY namespace
 !-->
<xsl:template match="*">
	<xsl:call-template name="error.terminate">
		<xsl:with-param name="text">
			<xsl:text>html.xsl; unexpected element in source document: </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="@*">
	<xsl:call-template name="error.terminate">
		<xsl:with-param name="text">
			<xsl:text>html.xsl: unexpected attribute in source document: </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
