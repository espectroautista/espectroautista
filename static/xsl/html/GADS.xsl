<?xml version="1.0" encoding="UTF-8"?>
<!--
 * GADS.xsl - templates específicas del test GADS.
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
	xmlns:p="urn:uuid:686e6078-a7f1-11dd-9cdd-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="../lib/likert.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/GADS">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	gadsS1: '<xsl:value-of select="tables:text('gadsS1')"/>',
	gadsS2: '<xsl:value-of select="tables:text('gadsS2')"/>',
	gadsM1: '<xsl:value-of select="tables:text('gadsM1')"/>',
	gadsM2: '<xsl:value-of select="tables:text('gadsM2')"/>',
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:body" mode="test.colgroup">
	<colgroup>
		<col style="width: 5%"/>
		<col style="width: 75%"/>
		<col style="width: 10%"/>
		<col style="width: 10%"/>
	</colgroup>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-headers">
	<th class="OptionLabel"><xsl:value-of select="tables:text('si')"/></th>
	<th class="OptionLabel"><xsl:value-of select="tables:text('no')"/></th>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-buttons">
	<xsl:param name="sClass"/>
	<xsl:param name="sR"/>

	<td class="{$sClass}Text"><xsl:value-of select="self::sentencia"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}a" name="{$sR}" value="1"/></td>
	<td class="{$sClass}Radio"><input type="radio" checked="checked" id="{$sR}b" name="{$sR}" value="0"/></td>
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('gadsS1')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('gadsS2')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
