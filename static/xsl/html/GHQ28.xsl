<?xml version="1.0" encoding="UTF-8"?>
<!--
 * GHCQ28.xsl - templates específicas del test GHCQ28.
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
	xmlns:p="urn:uuid:686ea074-a7f1-11dd-8e3e-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="../lib/choice.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/GHQ28">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	ghq28S1: '<xsl:value-of select="tables:text('ghq28S1')"/>',
	ghq28S2: '<xsl:value-of select="tables:text('ghq28S2')"/>',
	ghq28S3: '<xsl:value-of select="tables:text('ghq28S3')"/>',
	ghq28S4: '<xsl:value-of select="tables:text('ghq28S4')"/>',
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('ghq28S1')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('ghq28S2')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('ghq28S3')"/>:</td>
		<td id="OUTPUT3">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('ghq28S4')"/>:</td>
		<td id="OUTPUT4">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
