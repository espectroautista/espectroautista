<?xml version="1.0" encoding="UTF-8"?>
<!--
 * bib.xsl - Proceso de citas y referencias bibliograficas
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:h="&XHTMLNS;"
	xmlns:p="urn:uuid:977fd852-638a-11dd-b47d-001fc6576244"
	xmlns:bib="http://espectroautista.info/ns/bib"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns="&XHTMLNS;"
	exclude-result-prefixes="h p bib x"
>

<xsl:import href="error.xsl"/>

<!--
 ! 
 !-->
<xsl:template match="bib:article">
	<xsl:param name="linked" select="false()"/>

	<xsl:call-template name="error.assert">
		<xsl:with-param name="test" select="
				bib:authors/bib:author and
				bib:title and
				bib:journal and
				bib:year"/>
		<xsl:with-param name="text">
			<xsl:text>biblio.xsl: missing article fields: </xsl:text>
			<xsl:value-of select="@id"/>
		</xsl:with-param>
	</xsl:call-template>

	<xsl:apply-templates select="bib:authors">
			<xsl:with-param name="linked" select="$linked"/>
	</xsl:apply-templates>
	<xsl:text>: </xsl:text>
	<xsl:apply-templates select="bib:title"/>
	<xsl:apply-templates select="bib:journal"/><xsl:text> </xsl:text>
	<xsl:apply-templates select="bib:year"/>
	<xsl:apply-templates select="self::bib:article" mode="p:vol-num-pag"/>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="bib:inproceedings">
	<xsl:param name="linked" select="false()"/>

	<xsl:call-template name="error.assert">
		<xsl:with-param name="test" select="
				bib:authors/bib:author and
				bib:editors/bib:editor and
				bib:title and
				bib:booktitle and
				bib:year and
				bib:address and
				bib:publisher"/>
		<xsl:with-param name="text">
			<xsl:text>biblio.xsl: missing inproceedings fields: </xsl:text>
			<xsl:value-of select="@id"/>
		</xsl:with-param>
	</xsl:call-template>

	<xsl:apply-templates select="bib:authors">
			<xsl:with-param name="linked" select="$linked"/>
	</xsl:apply-templates>
	<xsl:text>: </xsl:text>
	<xsl:apply-templates select="bib:title"/>
	<xsl:apply-templates select="bib:editors"/><xsl:text> (Ed.) </xsl:text>
	<xsl:apply-templates select="bib:booktitle"/><xsl:text> </xsl:text>
	<xsl:apply-templates select="bib:year"/><xsl:text>, </xsl:text>
	<xsl:apply-templates select="bib:address"/><xsl:text>: </xsl:text>
	<xsl:apply-templates select="bib:publisher"/>
	<xsl:apply-templates select="self::bib:inproceedings" mode="p:vol-num-pag"/>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="bib:article | bib:inproceedings" mode="p:vol-num-pag">
	<xsl:if test="bib:volume or bib:number or bib:pages">
		<xsl:text>; </xsl:text>
	</xsl:if>

	<xsl:if test="bib:volume">
		<xsl:value-of select="bib:volume"/>
	</xsl:if>

	<xsl:if test="bib:number">
		<xsl:text>(</xsl:text>
		<xsl:value-of select="bib:number"/>
		<xsl:text>)</xsl:text>
	</xsl:if>

	<xsl:if test="(bib:volume or bib:number) and bib:pages">
		<xsl:text>:</xsl:text>
	</xsl:if>

	<xsl:if test="bib:pages">
		<xsl:value-of select="bib:pages"/>
	</xsl:if>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="bib:book">
	<xsl:param name="linked" select="false()"/>

	<xsl:call-template name="error.assert">
		<xsl:with-param name="test" select="
				bib:authors/bib:author and
				bib:title and
				bib:publisher and
				bib:year"/>
		<xsl:with-param name="text">
			<xsl:text>biblio.xsl: missing book fields: </xsl:text>
			<xsl:value-of select="@id"/>
		</xsl:with-param>
	</xsl:call-template>

	<xsl:apply-templates select="bib:authors">
			<xsl:with-param name="linked" select="$linked"/>
	</xsl:apply-templates>
	<xsl:text>: </xsl:text>
	<xsl:apply-templates select="bib:title"/>

	<xsl:if test="bib:address">
		<xsl:apply-templates select="bib:address"/>
		<xsl:text>: </xsl:text>
	</xsl:if>

	<xsl:apply-templates select="bib:publisher"/>
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="bib:year"/>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="bib:inbook">
	<xsl:param name="linked" select="false()"/>

	<xsl:call-template name="error.assert">
		<xsl:with-param name="test" select="
				bib:authors/bib:author and
				bib:chapter and
				bib:title and
				bib:publisher and
				bib:year"/>
		<xsl:with-param name="text">
			<xsl:text>biblio.xsl: missing inbook fields: </xsl:text>
			<xsl:value-of select="@id"/>
		</xsl:with-param>
	</xsl:call-template>

	<xsl:apply-templates select="bib:authors">
		<xsl:with-param name="linked" select="$linked"/>
	</xsl:apply-templates>
	<xsl:text>: </xsl:text>
	<xsl:apply-templates select="bib:chapter"/><xsl:text>. </xsl:text>
	<i><xsl:apply-templates select="bib:title"/></i>

	<xsl:if test="bib:address">
		<xsl:apply-templates select="bib:address"/>
		<xsl:text>: </xsl:text>
	</xsl:if>

	<xsl:apply-templates select="bib:publisher"/>
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="bib:year"/>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="bib:authors">
	<xsl:param name="linked" select="false()"/>

	<xsl:apply-templates select="bib:author">
		<xsl:with-param name="linked" select="$linked"/>
	</xsl:apply-templates>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="bib:editors">
	<xsl:apply-templates select="bib:editor"/>
</xsl:template>

<!--
 ! 
 !-->
<xsl:key name="Authors" match="bib:author" use="concat(bib:last, bib:first)"/>

<xsl:template match="bib:author | bib:editor">
	<xsl:param name="linked" select="false()"/>

	<xsl:variable name="node"
		select="key('Authors', concat(bib:last, bib:first))[1]/@node"/>

	<xsl:variable name="first-letter" select="substring(bib:last,1 ,1)"/>
	<xsl:choose>
		<xsl:when test="$linked">
			<a class="Author"
					href="/bibliograf%C3%ADa/autores/{x:makeID($first-letter)}#{$node}">
				<xsl:if test="bib:last != 'others'">
					<xsl:if test="bib:von">
						<xsl:value-of select="concat(bib:von, ' ')"/>
					</xsl:if>
					<xsl:value-of select="bib:last"/>
				</xsl:if>

				<xsl:if test="bib:first">
					<xsl:text>, </xsl:text>
				</xsl:if>

				<xsl:value-of select="bib:first"/>
			</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="bib:last != 'others'">
				<xsl:if test="bib:von">
					<xsl:value-of select="concat(bib:von, ' ')"/>
				</xsl:if>
				<xsl:value-of select="bib:last"/>
			</xsl:if>

			<xsl:if test="bib:first">
				<xsl:text>, </xsl:text>
			</xsl:if>

			<xsl:value-of select="bib:first"/>
		</xsl:otherwise>
	</xsl:choose>

	<xsl:if test="position() &lt; last()">
		<xsl:choose>
			<xsl:when test="following-sibling::bib:author[1]/bib:last = 'others'">
				<xsl:text> et al.</xsl:text>
			</xsl:when>
			<xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="bib:title">
	<xsl:variable name="url"
		select="preceding-sibling::bib:url | following-sibling::bib:url"/>

	<xsl:choose>
		<xsl:when test="$url">
				<xsl:call-template name="html.anchor">
					<xsl:with-param name="sText" select="string(self::bib:title)"/>
					<!--<xsl:with-param name="sTitle" select="string($url)"/>-->
					<xsl:with-param name="sHref" select="string($url)"/>
					<xsl:with-param name="sHreflang" select="string(parent::*/bib:lang)"/>
				</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="self::bib:title"/>
		</xsl:otherwise>
	</xsl:choose>

	<xsl:variable name="nLen" select="string-length(self::bib:title)"/>
	<xsl:variable name="sLast" select="substring(., $nLen, 1)"/>

	<xsl:choose>
		<xsl:when test="$sLast = '?' or $sLast = '!'">
			<xsl:text> </xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>. </xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="bib:journal | bib:booktitle">
	<i><xsl:value-of select="self::*"/></i>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="bib:address | bib:publisher | bib:year | bib:chapter">
	<xsl:value-of select="self::*"/>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
