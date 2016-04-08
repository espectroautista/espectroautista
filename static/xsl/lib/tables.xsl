<?xml version="1.0" encoding="UTF-8"?>
<!--
 * tables.xsl - Diccionarios de uso general
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:p="urn:uuid:29e3f35e-62cd-11dd-b27b-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns:func="http://exslt.org/functions"
  extension-element-prefixes="func"
	exclude-result-prefixes="p tables"
>

<xsl:import href="error.xsl"/>

<!--
 ! 
 !-->
<xsl:variable name="tables:Bibliography" select="document('../../etc/biblio.xml')/*"/>

<func:function name="tables:bibliography">
	<xsl:param name="sKey"/>

	<xsl:for-each select="$tables:Bibliography">
		<xsl:variable name="result" select="id($sKey)"/>

		<xsl:call-template name="error.assert">
			<xsl:with-param name="test" select="boolean($result)"/>
			<xsl:with-param name="text">
				<xsl:text>tables.xsl; unexpected bibref id: </xsl:text>
				<xsl:value-of select="$sKey"/>
			</xsl:with-param>
		</xsl:call-template>

		<func:result select="$result"/>
	</xsl:for-each>
</func:function>

<!--
 ! 
 !-->
<xsl:variable name="tables:Outline"
	select="document(concat('../../', $Language, '/meta/outline.opml'))"/>

<func:function name="tables:outline">
	<xsl:param name="sKey"/>

	<xsl:for-each select="$tables:Outline">
		<xsl:variable name="result" select="id($sKey)"/>

		<xsl:call-template name="error.assert">
			<xsl:with-param name="test" select="boolean($result)"/>
			<xsl:with-param name="text">
				<xsl:text>tables.xsl; unexpected outline id: </xsl:text>
				<xsl:value-of select="$sKey"/>
			</xsl:with-param>
		</xsl:call-template>

		<func:result select="$result"/>
	</xsl:for-each>
</func:function>

<!--
 ! 
 !-->
<xsl:variable name="p:routes" select="document('../../etc/routes.xml')/*"/>

<func:function name="tables:route">
	<xsl:param name="sKey"/>

	<xsl:for-each select="$p:routes">
		<xsl:variable name="result" select="id($sKey)/text()"/>

		<xsl:call-template name="error.assert">
			<xsl:with-param name="test" select="boolean($result)"/>
			<xsl:with-param name="text">
				<xsl:text>tables.xsl; unexpected route id: </xsl:text>
				<xsl:value-of select="$sKey"/>
			</xsl:with-param>
		</xsl:call-template>

		<func:result select="$result"/>
	</xsl:for-each>
</func:function>

<!--
 ! 
 !-->
<xsl:variable name="tables:Tags"
	select="document(concat('../../', $Language, '/meta/tags.xml'))/tags/tag"/>

<!--
 ! 
 !-->
<xsl:variable name="p:text" select="document(concat('../../', $Language, '/T.html'))"/>

<func:function name="tables:text">
	<xsl:param name="sKey"/>

	<xsl:for-each select="$p:text">
		<xsl:variable name="result" select="id($sKey)/text()"/>

		<xsl:call-template name="error.assert">
			<xsl:with-param name="test" select="boolean($result)"/>
			<xsl:with-param name="text">
				<xsl:text>tables.xsl; unexpected text id: </xsl:text>
				<xsl:value-of select="$sKey"/>
			</xsl:with-param>
		</xsl:call-template>

		<func:result select="$result"/>
	</xsl:for-each>
</func:function>

<!--
 ! 
 !-->
<xsl:variable name="p:stext" select="document(concat('../../', $Language, '/S.html'))"/>

<func:function name="tables:stext">
	<xsl:param name="sKey"/>

	<xsl:for-each select="$p:stext">
		<xsl:variable name="result" select="id($sKey)/text()"/>

		<xsl:call-template name="error.assert">
			<xsl:with-param name="test" select="boolean($result)"/>
			<xsl:with-param name="text">
				<xsl:text>tables.xsl; unexpected text id: </xsl:text>
				<xsl:value-of select="$sKey"/>
				<xsl:value-of select="$sKey"/>
			</xsl:with-param>
		</xsl:call-template>

		<func:result select="$result"/>
	</xsl:for-each>
</func:function>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
