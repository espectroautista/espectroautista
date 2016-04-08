<?xml version="1.0" encoding="UTF-8"?>
<!--
 * pub.xsl - templates para listados de publicaciones
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
	<!ENTITY NWORDS "30">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	exclude-result-prefixes="h"
>

<xsl:import href="generic.xsl"/>

<!--
 ! 
 !-->
<xsl:template match="h:html" mode="node.styles">
	<link media="all" rel="stylesheet" type="text/css" href="/styles/pub"/>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
