<?xml version="1.0" encoding="UTF-8"?>
<!--
 * ASDI.xsl - templates específicas del test ASDI.
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
	xmlns:p="urn:uuid:ad021d34-e1d8-11de-9bc0-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="../lib/likert.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/ASDI">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	asdiA1: '<xsl:value-of select="tables:text('asdiA1')"/>',
	asdiA2: '<xsl:value-of select="tables:text('asdiA2')"/>',
	asdiA3: '<xsl:value-of select="tables:text('asdiA3')"/>',
	asdiA4: '<xsl:value-of select="tables:text('asdiA4')"/>',
	asdiA5: '<xsl:value-of select="tables:text('asdiA5')"/>',
	asdiA6: '<xsl:value-of select="tables:text('asdiA6')"/>',
	asdiCriterio: '<xsl:value-of select="tables:text('asdiCriterio')"/>',
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
	<th class="OptionLabel"><xsl:value-of select="tables:text('no')"/></th>
	<th class="OptionLabel"><xsl:value-of select="tables:text('si')"/></th>
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
		<td class="TestScale"><xsl:value-of select="tables:text('asdiA1')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('asdiA2')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('asdiA3')"/>:</td>
		<td id="OUTPUT3">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('asdiA4')"/>:</td>
		<td id="OUTPUT4">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('asdiA5')"/>:</td>
		<td id="OUTPUT5">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('asdiA6')"/>:</td>
		<td id="OUTPUT6">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
