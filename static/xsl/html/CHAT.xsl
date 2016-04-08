<?xml version="1.0" encoding="UTF-8"?>
<!--
 * CHAT.xsl - templates específicas del test CHAT.
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
	xmlns:p="urn:uuid:0a51412e-56c1-11df-b2e5-90e6bab72f52"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="../lib/likert.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/CHAT">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	chat0: '<xsl:value-of select="tables:text('resultado')"/>',
	chat1: '<xsl:value-of select="tables:text('chat1')"/>',
	chat2: '<xsl:value-of select="tables:text('chat2')"/>',
	chat3: '<xsl:value-of select="tables:text('chat3')"/>',
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
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}a" name="{$sR}" value="0"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}b" name="{$sR}" value="1"/></td>
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td colspan="2" class="Centrist" id="OUTPUT1">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
