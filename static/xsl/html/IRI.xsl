<?xml version="1.0" encoding="UTF-8"?>
<!--
 * IRI.xsl - templates específicas del test IRI.
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
	xmlns:p="urn:uuid:455f2162-e1d9-11de-afd3-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>


<xsl:import href="../lib/likert.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/IRI">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	iriS1: '<xsl:value-of select="tables:text('iriS1')"/>',
	iriS2: '<xsl:value-of select="tables:text('iriS2')"/>',
	iriS3: '<xsl:value-of select="tables:text('iriS3')"/>',
	iriS4: '<xsl:value-of select="tables:text('iriS4')"/>',
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
	<th class="OptionLabel" colspan="5">
		<span style="float: left;"><xsl:value-of select="tables:text('iri0')"/></span>
		<span style="float: right;"><xsl:value-of select="tables:text('iri4')"/></span>
	</th>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-buttons">
	<xsl:param name="sClass"/>
	<xsl:param name="sR"/>

	<td class="{$sClass}Text"><xsl:value-of select="self::sentencia"/></td>
	<xsl:choose>
		<xsl:when test="
			$sR = 'R3'  or $sR = 'R4'  or $sR = 'R7' or
			$sR = 'R12' or $sR = 'R13' or $sR = 'R14' or
			$sR = 'R15' or $sR = 'R18' or $sR = 'R19'
		">
			<!-- reversed questions -->
			<td class="{$sClass}Radio"><input type="radio" id="{$sR}a" name="{$sR}" value="4"/></td>
			<td class="{$sClass}Radio"><input type="radio" id="{$sR}b" name="{$sR}" value="3"/></td>
			<td class="{$sClass}Radio"><input type="radio" id="{$sR}c" name="{$sR}" value="2"/></td>
			<td class="{$sClass}Radio"><input type="radio" id="{$sR}d" name="{$sR}" value="1"/></td>
			<td class="{$sClass}Radio"><input type="radio" id="{$sR}e" name="{$sR}" value="0"/></td>
		</xsl:when>
		<xsl:otherwise>
			<td class="{$sClass}Radio"><input type="radio" id="{$sR}a" name="{$sR}" value="0"/></td>
			<td class="{$sClass}Radio"><input type="radio" id="{$sR}b" name="{$sR}" value="1"/></td>
			<td class="{$sClass}Radio"><input type="radio" id="{$sR}c" name="{$sR}" value="2"/></td>
			<td class="{$sClass}Radio"><input type="radio" id="{$sR}d" name="{$sR}" value="3"/></td>
			<td class="{$sClass}Radio"><input type="radio" id="{$sR}e" name="{$sR}" value="4"/></td>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('iriS1')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('iriS2')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('iriS3')"/>:</td>
		<td id="OUTPUT3">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('iriS4')"/>:</td>
		<td id="OUTPUT4">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
