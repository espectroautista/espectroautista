<?xml version="1.0" encoding="UTF-8"?>
<!--
 * ERQ.xsl - templates específicas del test ERQ.
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
	xmlns:p="urn:uuid:686db3e4-a7f1-11dd-a04e-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="../lib/likert.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/ERQ">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	erqS1: '<xsl:value-of select="tables:text('erqS1')"/>',
	erqS2: '<xsl:value-of select="tables:text('erqS2')"/>',
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:body" mode="test.colgroup">
	<colgroup>
		<col style="width: 5%"/>
		<col style="width: 67%"/>
		<col style="width: 4%"/>
		<col style="width: 4%"/>
		<col style="width: 4%"/>
		<col style="width: 4%"/>
		<col style="width: 4%"/>
		<col style="width: 4%"/>
		<col style="width: 4%"/>
	</colgroup>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-headers">
	<th class="OptionLabel" colspan="7">
		<span style="float: left;"><xsl:value-of select="tables:text('erq1')"/></span>
		<span style="float: right;"><xsl:value-of select="tables:text('erq3')"/></span>
		<span><xsl:value-of select="tables:text('erq2')"/></span>
	</th>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-buttons">
	<xsl:param name="sClass"/>
	<xsl:param name="sR"/>

	<td class="{$sClass}Text"><xsl:value-of select="self::sentencia"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}a" name="{$sR}" value="1"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}b" name="{$sR}" value="2"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}c" name="{$sR}" value="3"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}d" name="{$sR}" value="4"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}e" name="{$sR}" value="5"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}f" name="{$sR}" value="6"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}g" name="{$sR}" value="7"/></td>
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('erqS1')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('erqS2')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
