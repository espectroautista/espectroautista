<?xml version="1.0" encoding="UTF-8"?>
<!--
 * AAA.xsl - especialiación para el test AAA.
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
	xmlns:p="urn:uuid:bdba5676-62bf-11dd-a96a-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="tables h p"
>

<xsl:import href="../lib/test.xsl"/>

<!--
 ! 
 !-->
<xsl:template match="h:body" mode="test.colgroup">
	<colgroup>
		<col style="width: 5%"/>
		<col style="width: 75%"/>
		<col style="width: 10%"/>
		<col style="width: 10%"/>
	</colgroup>
</xsl:template>

<xsl:attribute-set name="p:arrow">
  <xsl:attribute name="class">NavigationCell</xsl:attribute>
  <xsl:attribute name="colspan">2</xsl:attribute>
</xsl:attribute-set>

<xsl:template match="secciones">
	<xsl:apply-templates select="seccion"/>
</xsl:template>

<xsl:template match="seccion">
	<xsl:choose>
		<xsl:when test="@id = 'A'">
			<!-- first -->
			<tr id="B0">
				<td xsl:use-attribute-sets="p:arrow">
					<div class="NavigationArrows">
						<span class="DisabledArrow">&LEFT;&nbsp;</span>
						<span class="DisabledArrow">&UP;</span>
						<a title="{tables:text('avanzar')}" href="#B1" class="Arrow">&DOWN;</a>
						<a title="{tables:text('final')}" href="#B4" class="Arrow">&nbsp;&RIGHT;</a>
					</div>
				</td>

				<xsl:call-template name="p:question-headers"/>
			</tr>
		</xsl:when>
			<!-- last -->
		<xsl:when test="@id = 'E'">
			<tr id="B4">
				<td xsl:use-attribute-sets="p:arrow">
					<div class="NavigationArrows">
						<a title="{tables:text('inicio')}" href="#B0" class="Arrow">&LEFT;&nbsp;</a>
						<a title="{tables:text('retroceder')}" href="#B3" class="Arrow">&UP;</a>
						<span class="DisabledArrow">&DOWN;</span>
						<span class="DisabledArrow">&nbsp;&RIGHT;</span>
					</div>
				</td>

				<xsl:call-template name="p:question-headers"/>
			</tr>
		</xsl:when>
			<!-- middle -->
		<xsl:otherwise>
			<xsl:variable name="rN">
				<xsl:choose>
					<xsl:when test="@id = 'B'">1</xsl:when>
					<xsl:when test="@id = 'C'">2</xsl:when>
					<xsl:when test="@id = 'D'">3</xsl:when>
				</xsl:choose>
			</xsl:variable>

			<tr id="B{$rN}">
				<td xsl:use-attribute-sets="p:arrow">
					<div class="NavigationArrows">
						<a title="{tables:text('inicio')}" href="#B0" class="Arrow">&LEFT;&nbsp;</a>
						<a title="{tables:text('retroceder')}" href="#B{$rN - 1}" class="Arrow">&UP;</a>
						<a title="{tables:text('avanzar')}" href="#B{$rN + 1}" class="Arrow">&DOWN;</a>
						<a title="{tables:text('final')}" href="#B4" class="Arrow">&nbsp;&RIGHT;</a>
					</div>
				</td>

				<xsl:call-template name="p:question-headers"/>
			</tr>
		</xsl:otherwise>
	</xsl:choose>

	<tr>
		<th class="AAASection"><xsl:value-of select="@id"/></th>
		<th class="AAASection"><xsl:value-of select="@name"/></th>
	</tr>

	<xsl:for-each select="sintoma">
		<tr id="P{@m}">
			<xsl:variable name="rClass">
				<xsl:choose>
					<xsl:when test="(position() mod 2) = 0">EvenQuestion</xsl:when>
					<xsl:otherwise>OddQuestion</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="sR" select="concat('R', @m)"/>

			<td class="{$rClass}Number"><xsl:value-of select="@n"/></td>

			<xsl:call-template name="p:question-buttons">
				<xsl:with-param name="sClass" select="string($rClass)"/>
				<xsl:with-param name="sR" select="$sR"/>
			</xsl:call-template>
		</tr>
	</xsl:for-each>
</xsl:template>

<xsl:template name="p:question-headers">
	<th rowspan="2" class="OptionLabel"><xsl:value-of select="tables:text('si')"/></th>
	<th rowspan="2" class="OptionLabel"><xsl:value-of select="tables:text('no')"/></th>
</xsl:template>

<xsl:template name="p:question-buttons">
	<xsl:param name="sClass"/>
	<xsl:param name="sR"/>

	<td class="{$sClass}Text"><xsl:value-of select="self::sintoma"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}a" name="{$sR}" value="1"/></td>
	<td class="{$sClass}Radio"><input type="radio" id="{$sR}b" name="{$sR}" value="0"/></td>
</xsl:template>

<xsl:template match="h:html" mode="test.includes">
	<script type="text/javascript" src="/scripts/AAA">;</script>
</xsl:template>

<xsl:template match="h:html" mode="test.messages">
	aaaSA: '<xsl:value-of select="tables:text('aaaSA')"/>',
	aaaSB: '<xsl:value-of select="tables:text('aaaSB')"/>',
	aaaSC: '<xsl:value-of select="tables:text('aaaSC')"/>',
	aaaSD: '<xsl:value-of select="tables:text('aaaSD')"/>',
	aaaSE: '<xsl:value-of select="tables:text('aaaSE')"/>',
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('aaaSA')"/>:</td>
		<td id="OUTPUT1">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('aaaSB')"/>:</td>
		<td id="OUTPUT2">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('aaaSC')"/>:</td>
		<td id="OUTPUT3">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('aaaSD')"/>:</td>
		<td id="OUTPUT4">[OUTPUT]</td>
	</tr>
	<tr>
		<td class="TestScale"><xsl:value-of select="tables:text('aaaSE')"/>:</td>
		<td id="OUTPUT5">[OUTPUT]</td>
	</tr>
</xsl:template>

</xsl:transform>
<!--
	vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
