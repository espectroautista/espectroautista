<?xml version="1.0" encoding="UTF-8"?>
<!--
 * ASSQ_GIRL.xsl - templates específicas del test ASSQ_GIRL.
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
	xmlns:p="urn:uuid:18f8b57e-ece6-11e0-a38c-d8d3850d64e8"
	exclude-result-prefixes="h p"
>

<xsl:include href="ASSQ.xsl"/>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/ASSQ_GIRL">;</script>
</xsl:template>

</xsl:transform>
<!--
vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
