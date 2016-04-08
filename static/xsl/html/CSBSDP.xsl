<?xml version="1.0" encoding="UTF-8"?>
<!--
 * CSBSDP.xsl - templates específicas del test CSBSDP.
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
	xmlns:p="urn:uuid:98f7c89c-a1ff-11df-84ec-90e6bab72f52"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="../lib/choice.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/CSBSDP">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	csbsdpS1: '<xsl:value-of select="tables:text('csbsdpS1')"/>',
	csbsdpS2: '<xsl:value-of select="tables:text('csbsdpS2')"/>',
	csbsdpS3: '<xsl:value-of select="tables:text('csbsdpS3')"/>',
	csbsdpS4: '<xsl:value-of select="tables:text('csbsdpS4')"/>',
	csbsdpS5: '<xsl:value-of select="tables:text('csbsdpS5')"/>',
	csbsdpS6: '<xsl:value-of select="tables:text('csbsdpS6')"/>',
	csbsdpS7: '<xsl:value-of select="tables:text('csbsdpS7')"/>',
	csbsdpT1: '<xsl:value-of select="tables:text('csbsdpT1')"/>',
	csbsdpT2: '<xsl:value-of select="tables:text('csbsdpT2')"/>',
	csbsdpT3: '<xsl:value-of select="tables:text('csbsdpT3')"/>',
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('csbsdpS1')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('csbsdpS2')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('csbsdpS3')"/>:</td>
		<td id="OUTPUT3">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('csbsdpT1')"/>:</td>
		<td id="OUTPUT4">[OUTPUT]</td>
	</tr>

	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('csbsdpS4')"/>:</td>
		<td id="OUTPUT5">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('csbsdpS5')"/>:</td>
		<td id="OUTPUT6">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('csbsdpT2')"/>:</td>
		<td id="OUTPUT7">[OUTPUT]</td>
	</tr>

	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('csbsdpS6')"/>:</td>
		<td id="OUTPUT8">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('csbsdpS7')"/>:</td>
		<td id="OUTPUT9">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('csbsdpT3')"/>:</td>
		<td id="OUTPUT10">[OUTPUT]</td>
	</tr>

	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('coeficiente')"/>:</td>
		<td id="OUTPUT11">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
