<?xml version="1.0" encoding="UTF-8"?>
<!--
 * MCHAT.xsl - templates específicas del test MCHAT.
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
	xmlns:p="urn:uuid:686f26f2-a7f1-11dd-89e2-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="../lib/likert.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/MCHAT">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	mchat0: '<xsl:value-of select="tables:text('mchat0')"/>',
	mchat1: '<xsl:value-of select="tables:text('mchat1')"/>',
	mchat2: '<xsl:value-of select="tables:text('mchat2')"/>',
	mchat3: '<xsl:value-of select="tables:text('mchat3')"/>',
	mchat4: '<xsl:value-of select="tables:text('mchat4')"/>',
	mchat5: '<xsl:value-of select="tables:text('mchat5')"/>',
	mchat6: '<xsl:value-of select="tables:text('mchat6')"/>',
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
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}a" name="{$sR}" value="{@si}"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}b" name="{$sR}" value="{@no}"/></td>
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
