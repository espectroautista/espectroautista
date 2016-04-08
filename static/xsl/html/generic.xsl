<?xml version="1.0" encoding="UTF-8"?>
<!--
 * generic.xsl - templates para páginas simples.
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
	exclude-result-prefixes="h"
>

<xsl:import href="../lib/node.xsl"/>

<xsl:template match="h:body">
	<xsl:apply-templates select="*"/>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
