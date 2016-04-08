<?xml version="1.0" encoding="UTF-8"?>
<!--
 * likert.xsl - especialiación para tests de tipo likert.
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:h="&XHTMLNS;"
	xmlns:p="urn:uuid:834f4552-8b26-11dd-855a-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns="&XHTMLNS;"
	exclude-result-prefixes="h tables p"
>

<xsl:import href="test.xsl"/>

<!--
 ! 
 !-->
<xsl:attribute-set name="p:arrow">
  <xsl:attribute name="class">NavigationCell</xsl:attribute>
  <xsl:attribute name="colspan">2</xsl:attribute>
</xsl:attribute-set>

<!--
 ! 
 !-->
<xsl:template match="sentencia">
	<xsl:variable name="nP" select="position() - 1"/>

	<xsl:choose>
		<xsl:when test="$nP = 0">
			<!-- first -->
			<xsl:variable name="nFinal" select="floor((last()-1) div 10)"/>

			<tr id="B0">
				<td xsl:use-attribute-sets="p:arrow">
					<xsl:if test="last() &gt; 10">
						<div class="NavigationArrows">
							<span class="DisabledArrow">&LEFT;&nbsp;</span>
							<span class="DisabledArrow">&UP;</span>
							<a title="{tables:text('avanzar')}" href="#B1" class="Arrow">&DOWN;</a>
							<a title="{tables:text('final')}" href="#B{$nFinal}" class="Arrow">&nbsp;&RIGHT;</a>
						</div>
					</xsl:if>
				</td>

				<xsl:apply-templates select="self::sentencia" mode="likert.question-headers"/>
			</tr>
		</xsl:when>
			<!-- last -->
		<xsl:when test="$nP mod 10 = 0 and ($nP + 11) &gt; last()">
			<xsl:variable name="nBloc" select="floor($nP div 10)"/>

			<tr id="B{$nBloc}">
				<td xsl:use-attribute-sets="p:arrow">
					<div class="NavigationArrows">
						<a title="{tables:text('inicio')}" href="#B0" class="Arrow">&LEFT;&nbsp;</a>
						<a title="{tables:text('retroceder')}" href="#B{$nBloc - 1}" class="Arrow">&UP;</a>
						<span class="DisabledArrow">&DOWN;</span>
						<span class="DisabledArrow">&nbsp;&RIGHT;</span>
					</div>
				</td>

				<xsl:apply-templates select="self::sentencia" mode="likert.question-headers"/>
			</tr>
		</xsl:when>
			<!-- middle -->
		<xsl:when test="$nP mod 10 = 0">
			<xsl:variable name="nBloc" select="floor($nP div 10)"/>
			<xsl:variable name="nFinal" select="floor((last()-1) div 10)"/>

			<tr id="B{$nBloc}">
				<td xsl:use-attribute-sets="p:arrow">
					<div class="NavigationArrows">
						<a title="{tables:text('inicio')}" href="#B0" class="Arrow">&LEFT;&nbsp;</a>
						<a title="{tables:text('retroceder')}" href="#B{$nBloc - 1}" class="Arrow">&UP;</a>
						<a title="{tables:text('avanzar')}" href="#B{$nBloc + 1}" class="Arrow">&DOWN;</a>
						<a title="{tables:text('final')}" href="#B{$nFinal}" class="Arrow">&nbsp;&RIGHT;</a>
					</div>
				</td>

				<xsl:apply-templates select="self::sentencia" mode="likert.question-headers"/>
			</tr>
		</xsl:when>
		<xsl:otherwise>
			<!-- do nothing -->
		</xsl:otherwise>
	</xsl:choose>

	<tr id="P{@n}">
		<xsl:variable name="rClass">
			<xsl:choose>
				<xsl:when test="(position() mod 2) = 0">EvenQuestion</xsl:when>
				<xsl:otherwise>OddQuestion</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="sR" select="concat('R', @n)"/>

		<td class="{$rClass}Number"><xsl:value-of select="@n"/></td>

		<xsl:apply-templates select="self::sentencia" mode="likert.question-buttons">
			<xsl:with-param name="sClass" select="string($rClass)"/>
			<xsl:with-param name="sR" select="$sR"/>
		</xsl:apply-templates>
	</tr>

</xsl:template>

<!--
 !	default methods
 -->
<xsl:template match="sentencia" mode="likert.question-headers">
	<xsl:call-template name="error.terminate">
		<xsl:with-param name="text">
			<xsl:text>likert.xsl: TBD: likert.question-headers</xsl:text>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="sentencia" mode="likert.question-buttons">
	<xsl:call-template name="error.terminate">
		<xsl:with-param name="text">
			<xsl:text>likert.xsl: TBD: likert.question-buttons</xsl:text>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
