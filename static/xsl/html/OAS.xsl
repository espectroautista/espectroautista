<?xml version="1.0" encoding="UTF-8"?>
<!--
 * OAS.xsl - templates específicas del test OAS.
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
	xmlns:p="urn:uuid:686f67a2-a7f1-11dd-9517-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="../lib/likert.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/OAS">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	oasTotal: '<xsl:value-of select="tables:text('oasTotal')"/>',
	oasS1: '<xsl:value-of select="tables:text('oasS1')"/>',
	oasS2: '<xsl:value-of select="tables:text('oasS2')"/>',
	oasS3: '<xsl:value-of select="tables:text('oasS3')"/>',
	oasS4: '<xsl:value-of select="tables:text('oasS4')"/>',
	oasS5: '<xsl:value-of select="tables:text('oasS5')"/>',
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:body" mode="test.colgroup">
	<colgroup>
		<col style="width: 5%"/>
		<col style="width: 55%"/>
		<col style="width: 10%"/>
		<col style="width: 10%"/>
		<col style="width: 10%"/>
		<col style="width: 10%"/>
	</colgroup>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-headers">
	<th class="OptionLabel"><xsl:value-of select="tables:text('oA')"/></th>
	<th class="OptionLabel"><xsl:value-of select="tables:text('oB')"/></th>
	<th class="OptionLabel"><xsl:value-of select="tables:text('oC')"/></th>
	<th class="OptionLabel"><xsl:value-of select="tables:text('oD')"/></th>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-buttons">
	<xsl:param name="sClass"/>
	<xsl:param name="sR"/>

	<td class="{$sClass}Text"><xsl:value-of select="self::sentencia"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}a" name="{$sR}" value="{@a}"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}b" name="{$sR}" value="{@b}"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}c" name="{$sR}" value="{@c}"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}d" name="{$sR}" value="{@d}"/></td>
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('oasTotal')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('oasS1')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('oasS2')"/>:</td>
		<td id="OUTPUT3">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('oasS3')"/>:</td>
		<td id="OUTPUT4">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('oasS4')"/>:</td>
		<td id="OUTPUT5">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('oasS5')"/>:</td>
		<td id="OUTPUT6">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
