<?xml version="1.0" encoding="UTF-8"?>
<!--
 * choice.xsl - especialiación para tests de tipo choice.
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
	xmlns:p="urn:uuid:3082f726-62b6-11dd-bb4f-001fc6576244"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	xmlns:func="http://exslt.org/functions"
  extension-element-prefixes="func"
	exclude-result-prefixes="h p tables"
>

<xsl:import href="test.xsl"/>

<!--
 ! 
 !-->
<xsl:template match="h:body" mode="test.colgroup">
	<colgroup>
		<col style="width:100%"/>
	</colgroup>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="preguntas">
	<tr>
		<td>
			<ol>
				<xsl:if test="position() = 1">
					<xsl:attribute name="id">B0</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="pregunta"/>
			</ol>
		</td>
	</tr>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="pregunta">
	<xsl:variable name="rClass">
		<xsl:choose>
			<xsl:when test="(position() mod 2) = 0">EvenQuestion</xsl:when>
			<xsl:otherwise>OddQuestion</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<li class="{$rClass}" id="P{@n}">
		<div class="clearfix">
			<strong class="Question"><xsl:copy-of select="h:texto/node()"/></strong>

			<div class="NavigationArrows">
				<a	title="{tables:text('final')}" href="#TestButtons" class="Arrow">&DOWN;</a>

				<a	title="{tables:text('inicio')}" href="#B0" class="Arrow">&UP;</a>
			</div>
		</div>

		<xsl:if test="@t = '3'">
			<p class="instrucciones">
					<xsl:copy-of select="following-sibling::instrucciones/h:instruccion[@n = current()/@n]/node()"/>
			</p>
		</xsl:if>

		<ol class="Choices">
			<xsl:apply-templates select="opcion">
				<xsl:with-param name="nP" select="position()"/>
				<xsl:with-param name="sR" select="concat('R', string(position()))"/>
				<xsl:with-param name="sT" select="string(@t)"/>
			</xsl:apply-templates>
		</ol>
	</li>
</xsl:template>

<!--
 ! 
 !-->
<xsl:template match="opcion">
	<xsl:param name="nP"/>
	<xsl:param name="sR"/>
	<xsl:param name="sT"/>

	<xsl:variable name="sOpt" select="p:toletter(position())"/>

	<li class="QuestionOption">
		<xsl:choose>
			<!-- para FQ -->
			<xsl:when test="$sT = '3'">
				<!-- El texto de la opcion antes de los radio buttons -->
				<xsl:value-of select="self::opcion"/>
				<br/>
				0<input checked="checked" type="radio" id="{$sR}{$sOpt}0" name="{$sR}{$sOpt}" value="0"/>
				1<input type="radio" id="{$sR}{$sOpt}1" name="{$sR}{$sOpt}" value="1"/>
				2<input type="radio" id="{$sR}{$sOpt}2" name="{$sR}{$sOpt}" value="2"/>
				3<input type="radio" id="{$sR}{$sOpt}3" name="{$sR}{$sOpt}" value="3"/>
				<xsl:if test="$nP = 34 or $nP = 35">
					4<input type="radio" id="{$sR}{$sOpt}4" name="{$sR}{$sOpt}" value="4"/>
					5<input type="radio" id="{$sR}{$sOpt}5" name="{$sR}{$sOpt}" value="5"/>
					6<input type="radio" id="{$sR}{$sOpt}6" name="{$sR}{$sOpt}" value="6"/>
					7<input type="radio" id="{$sR}{$sOpt}7" name="{$sR}{$sOpt}" value="7"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<input type="radio" id="{$sR}{$sOpt}" name="{$sR}" value="{@v}" />
				<!-- El texto de la opcion despues del radio button -->
				<xsl:value-of select="self::opcion"/>
			</xsl:otherwise>
		</xsl:choose>
	</li>
</xsl:template>

<!--
 ! 
 !-->
<func:function name="p:toletter">
	<xsl:param name="nP"/>

	<xsl:call-template name="error.assert">
		<xsl:with-param name="test" select="$nP &gt;= 1 and $nP &lt;= 9"/>
		<xsl:with-param name="text">
			<xsl:text>choice.xsl; internal error calling toletter</xsl:text>
		</xsl:with-param>
	</xsl:call-template>

	<func:result select="substring('abcdefghi', $nP, 1)"/>
</func:function>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
