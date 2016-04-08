<?xml version="1.0" encoding="UTF-8"?>
<!--
 * CBS.xsl - templates específicas del test CBS.
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
	xmlns:p="urn:uuid:c73c673e-7351-11e0-85f5-d8d3850d64e8"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="AQ.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/CBS">;</script>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
