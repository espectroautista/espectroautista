<?xml version="1.0" encoding="UTF-8"?>
<!--
 * BAPQ.xsl - templates específicas del test BAPQ.
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
	xmlns:p="urn:uuid:bfc04c34-e1d8-11de-bc8c-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>


<xsl:import href="../lib/likert.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/BAPQ">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	bapqS1: '<xsl:value-of select="tables:text('bapqS1')"/>',
	bapqS2: '<xsl:value-of select="tables:text('bapqS2')"/>',
	bapqS3: '<xsl:value-of select="tables:text('bapqS3')"/>',
	bapqTotal: '<xsl:value-of select="tables:text('bapqTotal')"/>',
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="h:body" mode="test.colgroup">
	<colgroup>
		<col style="width: 5%"/>
		<col style="width: 65%"/>
		<col style="width: 5%"/>
		<col style="width: 5%"/>
		<col style="width: 5%"/>
		<col style="width: 5%"/>
		<col style="width: 5%"/>
		<col style="width: 5%"/>
	</colgroup>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-headers">
	<th class="OptionLabel" colspan="6">
		<span style="float: left;"><xsl:value-of select="tables:text('bapq1')"/></span>
		<span style="float: right;"><xsl:value-of select="tables:text('bapq6')"/></span>
	</th>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-buttons">
	<xsl:param name="sClass"/>
	<xsl:param name="sR"/>

	<td class="{$sClass}Text"><xsl:value-of select="self::sentencia"/></td>
	<xsl:choose>
		<xsl:when test="
			$sR = 'R1'  or $sR = 'R3'  or $sR = 'R7' or
			$sR = 'R9'  or $sR = 'R12'  or $sR = 'R15' or
			$sR = 'R16'  or $sR = 'R19'  or $sR = 'R21' or
			$sR = 'R23'  or $sR = 'R25'  or $sR = 'R28' or
			$sR = 'R30'  or $sR = 'R34'  or $sR = 'R36'
		">
			<!-- reversed questions -->
			<td class="{$sClass}Radio">1<br/><input type="radio" id="{$sR}a" name="{$sR}" value="6"/></td>
			<td class="{$sClass}Radio">2<br/><input type="radio" id="{$sR}b" name="{$sR}" value="5"/></td>
			<td class="{$sClass}Radio">3<br/><input type="radio" id="{$sR}c" name="{$sR}" value="4"/></td>
			<td class="{$sClass}Radio">4<br/><input type="radio" id="{$sR}d" name="{$sR}" value="3"/></td>
			<td class="{$sClass}Radio">5<br/><input type="radio" id="{$sR}e" name="{$sR}" value="2"/></td>
			<td class="{$sClass}Radio">6<br/><input type="radio" id="{$sR}f" name="{$sR}" value="1"/></td>
		</xsl:when>
		<xsl:otherwise>
			<td class="{$sClass}Radio">1<br/><input type="radio" id="{$sR}a" name="{$sR}" value="1"/></td>
			<td class="{$sClass}Radio">2<br/><input type="radio" id="{$sR}b" name="{$sR}" value="2"/></td>
			<td class="{$sClass}Radio">3<br/><input type="radio" id="{$sR}c" name="{$sR}" value="3"/></td>
			<td class="{$sClass}Radio">4<br/><input type="radio" id="{$sR}d" name="{$sR}" value="4"/></td>
			<td class="{$sClass}Radio">5<br/><input type="radio" id="{$sR}e" name="{$sR}" value="5"/></td>
			<td class="{$sClass}Radio">6<br/><input type="radio" id="{$sR}f" name="{$sR}" value="6"/></td>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('bapqS1')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('bapqS2')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('bapqS3')"/>:</td>
		<td id="OUTPUT3">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('bapqTotal')"/>:</td>
		<td id="OUTPUT4">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
