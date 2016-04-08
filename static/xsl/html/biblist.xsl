<?xml version="1.0" encoding="UTF-8"?>
<!--
 * biblist.xsl - lista de ref. bib.
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
	<!ENTITY NYEARS	"4">
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
	xmlns:date="http://exslt.org/dates-and-times"
  xmlns:set="http://exslt.org/sets"
	extension-element-prefixes="date exsl set"
	exclude-result-prefixes="h bib tables x"
>

<xsl:import href="generic.xsl"/>

<!-- bibliografía: últimos hallazgos -->
<xsl:template match="h:object[@class = 'BIB-LAST']">
	<xsl:variable name="ids" select="document('../../etc/biblast.xml')/ids/id"/>

	<ol class="biblist">
		<xsl:for-each select="$ids">
			<xsl:variable name="pub" select="tables:bibliography(.)"/>

			<li id="{.}" xml:lang="{$pub/bib:lang}" lang="{$pub/bib:lang}">
				<xsl:apply-templates select="$pub"/>
			</li>
		</xsl:for-each>
	</ol>
</xsl:template>

<!-- bibliografía completa -->
<xsl:template match="h:object[@class = 'BIB-ALL']">
	<xsl:call-template name="biblist">
		<xsl:with-param name="biblist" select="$tables:Bibliography/*[bib:url]"/>
		<xsl:with-param name="list" select="'ol'"/>
	</xsl:call-template>
</xsl:template>

<!-- publicaciones en español -->
<xsl:template match="h:object[@class = 'BIB-PONENCIAS']">
	<xsl:variable name="ponencias"
		select="$tables:Bibliography/*[bib:url and bib:lang = 'es']"/>

	<xsl:call-template name="biblist">
		<xsl:with-param name="biblist" select="$ponencias"/>
		<xsl:with-param name="list" select="'ol'"/>
	</xsl:call-template>
</xsl:template>

<!-- bibliografía reciente -->
<xsl:template match="h:object[@class = 'BIB-RECENT']">
	<xsl:variable name="sYear" select="string(date:year() - &NYEARS;)"/>

	<xsl:variable name="years"
		select="set:distinct($tables:Bibliography/*/bib:year[. &gt; $sYear])"/>

	<xsl:for-each select="$years">
		<xsl:sort select="." order="descending"/>

		<xsl:variable name="year" select="."/>

		<h2 class="IndexLabel">
			<a href="#" class="Symbol" title="{tables:text('subir')}">&UP;</a>

			<span style="width: 1em;">&#160;</span>

			<xsl:value-of select="$year"/>
		</h2>

		<xsl:variable name="biblist" select="$tables:Bibliography/*[bib:url and bib:year = $year]"/>

		<xsl:call-template name="biblist">
			<xsl:with-param name="biblist" select="$biblist"/>
		</xsl:call-template>
	</xsl:for-each>
</xsl:template>

<!--
 ! Genera un listado bibliográfico
 !-->
<xsl:template name="biblist">
	<xsl:param name="biblist"/>
	<xsl:param name="list" select="'ul'"/>

	<xsl:element name="{$list}">
		<xsl:attribute name="class">biblist</xsl:attribute>

		<xsl:for-each select="$biblist">
			<xsl:sort select="x:makeID(bib:title)"/>

			<li id="x{@id}" lang="{bib:lang}">
				<xsl:apply-templates select="tables:bibliography(@id)"/>
			</li>
		</xsl:for-each>
	</xsl:element>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
