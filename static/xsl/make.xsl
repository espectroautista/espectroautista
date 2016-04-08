<?xml version="1.0" encoding="UTF-8"?>
<!--
 * make.xsl - Genera <lang>-rules.mak
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY XP			"xsltproc --nonet --nodtdattr">
	<!ENTITY xFORMAT 	"| xmllint --format - ">
	<!ENTITY FORMAT 	"| etc/minifyHTML ">
	<!ENTITY NL 		"&#10;">
	<!ENTITY HT 		"&#9;">
	<!ENTITY XSL_HTML	"xsl/html">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:param name="sLang"/>

<xsl:output
	method="text"
	encoding="UTF-8"
/>

<!--
 !	
 -->
<xsl:template match="/">
	<xsl:apply-templates select="opml/body/outline"/>

	<xsl:text># vim:nowrap&NL;</xsl:text>
</xsl:template>

<!--
 !	
 -->
<xsl:template match="outline">
	<xsl:apply-templates select="outline"/>	<!-- recurse -->

	<!-- command -->
	<xsl:value-of select="@filename"/><xsl:text>: </xsl:text>
	<xsl:value-of select="$sLang"/>/<xsl:value-of select="@id"/>
	<xsl:text>.html</xsl:text>

	<xsl:choose>
		<xsl:when test="@kind = 'likert' or @kind = 'choice'">
			<xsl:text>; &XP; &XSL_HTML;/$(basename $(notdir $&lt;)).xsl $&lt; </xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>; &XP; </xsl:text>
			<xsl:if test="substring(@id, string-length(@id) - 1, 1) = '_'">
				<xsl:text>--stringparam LETTER </xsl:text>
				<xsl:value-of select="substring(@id, string-length(@id))"/>
			</xsl:if>
			<xsl:text> &XSL_HTML;/</xsl:text>
			<xsl:value-of select="@kind"/>
			<xsl:text>.xsl </xsl:text>
			<xsl:text> $&lt; </xsl:text>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:text>&FORMAT;&gt; $@</xsl:text>
	<xsl:text>&NL;</xsl:text>

	<!-- more dependencies -->
	<xsl:value-of select="@filename"/><xsl:text>: </xsl:text>
	<!-- REMOVED
	<xsl:text>dtd/entities.dtd </xsl:text>
	<xsl:value-of select="$sLang"/><xsl:text>/S.html </xsl:text>
	<xsl:value-of select="$sLang"/><xsl:text>/T.html </xsl:text>
	-->

	<xsl:if test="@data = 'yes'">
		<xsl:value-of select="$sLang"/>/data/<xsl:value-of select="@id"/>
		<xsl:text>.xml </xsl:text>
	</xsl:if>

	<!-- all the xsl dependencies -->
	<xsl:variable name="transformation">
		<xsl:choose>
			<xsl:when test="@kind = 'likert' or @kind = 'choice'">
				<xsl:text>html/</xsl:text>
				<xsl:call-template name="basename">
					<xsl:with-param name="path" select="@source"/>
				</xsl:call-template>
				<xsl:text>.xsl</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('html/', @kind, '.xsl')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:text> xsl/</xsl:text>
	<xsl:value-of select="$transformation"/>

	<xsl:variable name="module" select="document($transformation)"/>

	<xsl:apply-templates select="$module/*/xsl:include | $module/*/xsl:import">
		<xsl:with-param name="dirname" select="'xsl/html/'"/>
	</xsl:apply-templates>

	<!-- hand coded dependencies -->
	<xsl:if test="@depend">
		<xsl:text> </xsl:text>
		<xsl:value-of select="@depend"/>
	</xsl:if>

	<xsl:text>&NL;</xsl:text>

</xsl:template>

<!--
 !	Process includes and imports
 -->
<xsl:template match="xsl:include | xsl:import">
	<xsl:param name="dirname"/>

	<xsl:text> </xsl:text>
	<xsl:value-of select="concat($dirname, @href)"/>

	<xsl:variable name="newdir">
			<xsl:call-template name="dirname">
				<xsl:with-param name="path" select="concat($dirname, @href)"/>
			</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="module" select="document(@href)"/>
	<xsl:apply-templates select="$module/*/xsl:include | $module/*/xsl:import">
		<xsl:with-param name="dirname" select="$newdir"/>
	</xsl:apply-templates>
</xsl:template>

<!--
 ! dirname & basename
 !-->
<xsl:template name="dirname">
	<xsl:param name="path"/>

	<xsl:if test="contains($path, '/')">
			<xsl:value-of select="substring-before($path, '/')"/>
			<xsl:text>/</xsl:text>

			<xsl:call-template name="dirname">
				<xsl:with-param name="path" select="substring-after($path, '/')"/>
			</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="basename">
	<xsl:param name="path"/>

	<xsl:choose>
		<xsl:when test="contains($path, '/')">
				<xsl:call-template name="basename">
					<xsl:with-param name="path" select="substring-after($path, '/')"/>
				</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="substring-before($path, '.')"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
