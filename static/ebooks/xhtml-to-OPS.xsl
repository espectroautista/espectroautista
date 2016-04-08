<?xml version="1.0" encoding="UTF-8"?>
<!--
 * xhtml-to-OPS.xsl
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY XHTMLNS "http://www.w3.org/1999/xhtml">
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	exclude-result-prefixes="h"
>

<xsl:import href="xhtml1-to-xhtml11.xsl"/>

<xsl:param name="preserve-noscript" select="false()"/>

<!--
 ! server side maps
 !-->
<xsl:template match="h:img/@ismap">
	<!-- ignore -->
</xsl:template>

<!--
 ! forms
 !-->
<xsl:template match="h:form">
	<div class="old-form">
			<xsl:apply-templates select="node()"/>
	</div>
</xsl:template>

<xsl:template match="h:button | h:option | h:legend | h:label">
	<span class="old-form-inline">
			<xsl:apply-templates select="node()"/>
	</span>
</xsl:template>

<xsl:template match="h:textarea | h:fieldset">
	<div class="old-form-block">
			<xsl:apply-templates select="node()"/>
	</div>
</xsl:template>

<xsl:template match="h:input | h:select | h:optgroup">
	<!-- ignore -->
</xsl:template>

<!--
 ! scripts
 !-->
<xsl:template match="h:script">
	<!-- ignore -->
</xsl:template>

<xsl:template match="h:noscript">
	<xsl:if test="$preserve-noscript">
		<xsl:copy/>
	</xsl:if>
	<!-- else ignore -->
</xsl:template>

<!--
 ! events
 !-->
<xsl:template match="
		@onclick | @ondblclick |
		@onmousedown | @onmouseup |
		@onmouseover | @onmousemove | @onmouseout |
		@onkeypress | @onkeydown | @onkeyup">
	<!-- ignore -->
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
