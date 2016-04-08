<?xml version="1.0" encoding="UTF-8"?>
<!--
 * LSAS.xsl - templates específicas del test LSAS.
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
	xmlns:p="urn:uuid:686ee016-a7f1-11dd-9e32-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<!-- no es un test de tipo likert, pero el módulo sirve -->
<xsl:import href="../lib/likert.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/LSAS">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	lsasTotal: '<xsl:value-of select="tables:text('lsasTotal')"/>',
	lsasFear: '<xsl:value-of select="tables:text('lsasFear')"/>',
	lsasAvoidance: '<xsl:value-of select="tables:text('lsasAvoidance')"/>',
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:body" mode="test.colgroup">
	<colgroup>
		<col style="width: 5%"/>
		<col style="width: 65%"/>
		<col style="width: 15%"/>
		<col style="width: 15%"/>
	</colgroup>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-headers">
	<th class="OptionLabel"><xsl:value-of select="tables:text('lsasFear')"/></th>
	<th class="OptionLabel"><xsl:value-of select="tables:text('lsasAvoidance')"/></th>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-buttons">
	<xsl:param name="sClass"/>
	<xsl:param name="sR"/>

	<td class="{$sClass}Text"><xsl:value-of select="self::sentencia"/></td>
	<!-- not a radio, but... -->
	<td class="{$sClass}Radio">
		<select id ="{$sR}F" name="{$sR}F" style="width: 12em; font-size: 80%;">
			<option selected="selected" value="-">---------</option>
			<option value="0"><xsl:value-of select="tables:text('lsasF0')"/></option>
			<option value="1"><xsl:value-of select="tables:text('lsasF1')"/></option>
			<option value="2"><xsl:value-of select="tables:text('lsasF2')"/></option>
			<option value="3"><xsl:value-of select="tables:text('lsasF3')"/></option>
		</select>
	</td>
	<!-- not a radio, but... -->
	<td class="{$sClass}Radio">
		<select id ="{$sR}A" name="{$sR}A" style="width: 12em; font-size: 80%;">
			<option selected="selected" value="-">---------</option>
			<option value="0"><xsl:value-of select="tables:text('lsasA0')"/></option>
			<option value="1"><xsl:value-of select="tables:text('lsasA1')"/></option>
			<option value="2"><xsl:value-of select="tables:text('lsasA2')"/></option>
			<option value="3"><xsl:value-of select="tables:text('lsasA3')"/></option>
		</select>
	</td>
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('lsasTotal')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('lsasFear')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('lsasAvoidance')"/>:</td>
		<td id="OUTPUT3">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
