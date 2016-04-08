<?xml version="1.0" encoding="UTF-8"?>
<!--
 * EQC_SQC.xsl - templates específicas del test EQC_SQC.
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
	xmlns:p="urn:uuid:5eb84ca0-494a-11df-b32f-90e6bab72f52"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="AQ.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/EQC_SQC">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	eqcsqcS1: '<xsl:value-of select="tables:text('eqcsqcS1')"/>',
	eqcsqcS2: '<xsl:value-of select="tables:text('eqcsqcS2')"/>',
	eqcsqcS3: '<xsl:value-of select="tables:text('eqcsqcS3')"/>',
	eqcsqcS4: '<xsl:value-of select="tables:text('eqcsqcS4')"/>',
	eqcsqcS5: '<xsl:value-of select="tables:text('eqcsqcS5')"/>',
	eqcsqcS6: '<xsl:value-of select="tables:text('eqcsqcS6')"/>',
	eqcsqcS7: '<xsl:value-of select="tables:text('eqcsqcS7')"/>',
	eqcsqcS8: '<xsl:value-of select="tables:text('eqcsqcS8')"/>',
	eqcsqcS9: '<xsl:value-of select="tables:text('eqcsqcS9')"/>',
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('eqcsqcS1')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('eqcsqcS2')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('eqcsqcS4')"/>:</td>
		<td id="OUTPUT3">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
