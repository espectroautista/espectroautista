<?xml version="1.0" encoding="UTF-8"?>
<!--
 * LIPT60.xsl - templates específicas del test LIPT60.
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
	xmlns:p="urn:uuid:fbbc3e99-cbd1-4933-b33c-3b2e2b33fbb8"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="../lib/likert.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/LIPT60">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	liptNEAP: '<xsl:value-of select="tables:text('liptNEAP')"/>',
	liptIGAP: '<xsl:value-of select="tables:text('liptIGAP')"/>',
	liptIMAP: '<xsl:value-of select="tables:text('liptIMAP')"/>',
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:body" mode="test.colgroup">
	<colgroup>
		<col style="width: 5%"/>
		<col style="width: 75%"/>
		<col style="width: 4%"/>
		<col style="width: 4%"/>
		<col style="width: 4%"/>
		<col style="width: 4%"/>
		<col style="width: 4%"/>
	</colgroup>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-headers">
	<th class="OptionLabel Centrist" colspan="5">
		<xsl:value-of select="tables:text('lipt1')"/>
	</th>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-buttons">
	<xsl:param name="sClass"/>
	<xsl:param name="sR"/>

	<td class="{$sClass}Text"><xsl:value-of select="self::sentencia"/></td>
	<td class="{$sClass}Radio">0<br/><input type="radio" id="{$sR}a" name="{$sR}" value="0"/></td>
	<td class="{$sClass}Radio">1<br/><input type="radio" id="{$sR}b" name="{$sR}" value="1"/></td>
	<td class="{$sClass}Radio">2<br/><input type="radio" id="{$sR}c" name="{$sR}" value="2"/></td>
	<td class="{$sClass}Radio">3<br/><input type="radio" id="{$sR}d" name="{$sR}" value="3"/></td>
	<td class="{$sClass}Radio">4<br/><input type="radio" id="{$sR}e" name="{$sR}" value="4"/></td>
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('liptNEAP')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('liptIGAP')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('liptIMAP')"/>:</td>
		<td id="OUTPUT3">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
