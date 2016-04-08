<?xml version="1.0" encoding="UTF-8"?>
<!--
 * object.xsl - Proceso del elemento 'object'
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:h="&XHTMLNS;"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns="&XHTMLNS;"
	exclude-result-prefixes="h tables"
>

<xsl:import href="biblio.xsl"/>
<xsl:import href="tables.xsl"/>

<!--
 ! 
 !-->
<xsl:template match="h:object[not(@class)]">
	<xsl:copy-of select="."/>
</xsl:template>

<!--
 ! 
 !-->

<xsl:template match="h:object[@class = 'youtube']">
	<div class="Video">
		<object width="640" height="385">
			<param name="movie" value="http://www.youtube.com/v/{@data}?fs=1&amp;hl=en_US"></param>
			<param name="allowFullScreen" value="true"></param>
			<param name="allowscriptaccess" value="always"></param>
			<embed src="http://www.youtube.com/v/{@data}?fs=1&amp;hl=en"
				type="application/x-shockwave-flash"
				allowscriptaccess="always" allowfullscreen="true"
				width="640" height="385"/>
		</object>
	</div>
</xsl:template>

<xsl:template match="h:object[@class = 'youtube_OLD']">
	<div class="Video">
		<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" type="application/x-shockwave-flash" width="425" height="344">
			<param name="movie" value="http://www.youtube.com/v/{@data}&amp;hl=en&amp;fs=1&amp;"></param>
			<param name="wmode" value="transparent"></param>
			<param name="menu" value="false"></param>
			<param name="quality" value="best"></param>
			<!--[if !IE]>-->
			<xsl:comment>[if !IE]&gt;</xsl:comment>
			<object width="425" height="344" type="application/x-shockwave-flash" data="http://www.youtube.com/swf/l.swf?video_id={@data}&amp;rel=1">
				<param name="wmode" value="transparent"></param>
				<param name="menu" value="false"></param>
				<param name="quality" value="best"></param>
			<!--<![endif]-->
			<xsl:comment>&lt;![endif]></xsl:comment>
				<img src="/images/logo-espectro-autista" alt="EspectroAutista.Info"/>
			<!--[if !IE]>-->
			<xsl:comment>[if !IE]&gt;</xsl:comment>
			</object>
			<!--<![endif]-->
			<xsl:comment>&lt;![endif]</xsl:comment>
		</object>
	</div>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:object[@class = 'bibref']">
	<xsl:apply-templates select="tables:bibliography(@data)"/>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:object[@class = 'stext']">
	<xsl:apply-templates select="tables:stext(@data)"/>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:object[@class = 'glossary']">
	<xsl:variable name="sKey" select="string(@data)"/>

	<xsl:for-each select="document(concat('../../', $Language, '/glosario.html'))">
		<xsl:call-template name="error.assert">
			<xsl:with-param name="test" select="boolean(id($sKey))"/>
			<xsl:with-param name="text">
				<xsl:text>object.xsl; unexpected glossary key: </xsl:text>
				<xsl:value-of select="$sKey"/>
			</xsl:with-param>
		</xsl:call-template>

		<abbr>
			<xsl:attribute name="title">
				<xsl:variable name="t"
					select="h:html/h:body/h:dl/h:dt[@id = $sKey]/following-sibling::h:dd[1]"/>
				<xsl:value-of
					select="translate($t, '.', '')"/>
			</xsl:attribute>
			<xsl:value-of select="$sKey"/>
		</abbr>
	</xsl:for-each>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:object">
	<xsl:call-template name="error.terminate">
		<xsl:with-param name="text">
			<xsl:text>object.xsl; unexpected object class: </xsl:text>
			<xsl:value-of select="@class"/>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!--
 ! TOC for publicaciones
 !-->
<xsl:template match="h:object[@class = 'PUBTOC']">
	<ol class="TOC">
		<xsl:for-each select="/h:html/h:body/h:dl/h:dt/h:a[@id] | /h:html/h:body/h:dl/h:dt/h:span[@id]">
			<li>
				<a href="#{@id}">
					<xsl:value-of select="."/>
				</a>
			</li>
		</xsl:for-each>
	</ol>
</xsl:template>

<!--
 !  TOC for textos
 !-->
<xsl:template match="h:object[@class = 'TOC']">
	<ul class="TOC">
		<xsl:apply-templates mode="toc" select="/h:html/h:body/h:h2"/>
	</ul>
</xsl:template>

<xsl:template mode="toc" match="h:h2">
	<xsl:variable name="next" select="
		following-sibling::h:h3[
			generate-id(preceding-sibling::h:h2[1]) = generate-id(current())]
	"/>

	<li>
		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="@id">
					<xsl:value-of select="@id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="generate-id()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<a href="#{$id}"><xsl:value-of select="."/></a>

		<xsl:if test="$next">
			<ul class="TOC">
				<xsl:apply-templates mode="toc" select="$next"/>
			</ul>
		</xsl:if>
	</li>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template mode="toc" match="h:h3">
	<xsl:variable name="next" select="
		following-sibling::h:h4[
			generate-id(preceding-sibling::h:h3[1]) = generate-id(current())]
	"/>

	<li>
		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<a href="#{$id}"><xsl:value-of select="."/></a>

		<xsl:if test="$next">
			<ul class="TOC">
				<xsl:apply-templates mode="toc" select="$next"/>
			</ul>
		</xsl:if>
	</li>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template mode="toc" match="h:h4">
	<xsl:variable name="next" select="
		following-sibling::h:h5[
			generate-id(preceding-sibling::h:h4[1]) = generate-id(current())]
	"/>

	<li>
		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<a href="#{$id}"><xsl:value-of select="."/></a>

		<xsl:if test="$next">
			<ul class="TOC">
				<xsl:for-each select="$next">
					<xsl:variable name="id2">
						<xsl:choose>
							<xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<li><a href="#{$id2}"><xsl:value-of select="."/></a></li>
				</xsl:for-each>
			</ul>
		</xsl:if>
	</li>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
