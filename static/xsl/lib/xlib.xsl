<?xml version="1.0" encoding="UTF-8"?>
<!--
 * xlib.xsl - Librería XSLT de prop´sito general.
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY OTHER "-_/¿¡&quot;&amp;&ldquo;&lsquo;&rdquo;&rsquo;">
	<!ENTITY LETTER "áéíóúàèìòùäëïöüñçÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÑ">
	<!ENTITY ASCII  "aeiouaeiouaeiouncAEIOUAEIOUAEIOUN">
	<!ENTITY LOWER  "abcdefghijklmnopqrstuvwxyzáéíóúàèìòùäëïöüâêîôûñç">
	<!ENTITY UPPER  "ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÚÀÈÌÒÙÄËÏÖÜÂÊÎÔÛÑÇ">
	<!ENTITY UPPER_ASCII  "ABCDEFGHIJKLMNOPQRSTUVWXYZAEIOUAEIOUAEIOUAEIOUNC">
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
]>

<xsl:transform
	version="1.0"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:x="http://espectroautista.info/ns/xlib"
	xmlns:str="http://exslt.org/strings"
	xmlns:func="http://exslt.org/functions"
  extension-element-prefixes="func str"
	exclude-result-prefixes="h x"
>

<!--
 ! 
 !-->
<xsl:variable name="x:Alphabet"
	select="str:split('A B C D E F G H I J K L M N O P Q R S T U V W X Y Z')"/>

<xsl:template name="x:alpha-menu">
	<xsl:param name="current-letter"/>
	<xsl:param name="url"/>
	<xsl:param name="initials"/>

	<div class="AlphaMenu">
		<xsl:for-each select="$x:Alphabet">
			<xsl:variable name="letter" select="."/>

			<xsl:choose>
				<xsl:when test="$letter = $current-letter">
					<span class="CurrentLetter"><xsl:value-of select="."/></span>
				</xsl:when>
				<!-- initials is a node-set -->
				<xsl:when test="$letter != $current-letter and $letter = $initials">
					<a class="AlphaMenu" href="{$url}/{$letter}"><xsl:value-of select="."/></a>
				</xsl:when>
				<xsl:otherwise>
					<span class="MenuLinkPadded"><xsl:value-of select="."/></span>
				</xsl:otherwise>
			</xsl:choose>

			<!--
			<xsl:if test="position() &lt; last()">
				<xsl:text> </xsl:text>
			</xsl:if>
			-->
		</xsl:for-each>
	</div>
</xsl:template>

<!--
 ! 
 !-->
<func:function name="x:upper">
	<xsl:param name="s"/>
	<func:result select="translate($s, '&LOWER;', '&UPPER;')"/>
</func:function>

<func:function name="x:lower">
	<xsl:param name="s"/>
	<func:result select="translate($s, '&UPPER;', '&LOWER;')"/>
</func:function>

<!--
 ! 
 !-->
<func:function name="x:makeID">
	<xsl:param name="s"/>
	<func:result select="translate(translate($s, '&#9;&#10;&#13;&#32;&OTHER;', ''), '&LOWER;', '&UPPER_ASCII;')"/>
</func:function>

<!--
 ! 
 !-->
<func:function name="x:same">
	<xsl:param name="n1"/>
	<xsl:param name="n2"/>

	<func:result select="generate-id($n1) = generate-id($n2)"/>
</func:function>

<!--
 ! 
 !-->
<func:function name="x:if">
	<xsl:param name="c"/>
	<xsl:param name="t"/>
	<xsl:param name="e"/>

	<xsl:choose>
		<xsl:when test="$c"><func:result select="$t"/></xsl:when>
		<xsl:otherwise><func:result select="$e"/></xsl:otherwise>
	</xsl:choose>
</func:function>

<!--
 ! 
 !-->
<func:function name="x:month">
	<xsl:param name="n"/>

	<xsl:choose>
		<xsl:when test="$n = '01'"><func:result select="'enero'"/></xsl:when>
		<xsl:when test="$n = '02'"><func:result select="'febrero'"/></xsl:when>
		<xsl:when test="$n = '03'"><func:result select="'marzo'"/></xsl:when>
		<xsl:when test="$n = '04'"><func:result select="'abril'"/></xsl:when>
		<xsl:when test="$n = '05'"><func:result select="'mayo'"/></xsl:when>
		<xsl:when test="$n = '06'"><func:result select="'junio'"/></xsl:when>
		<xsl:when test="$n = '07'"><func:result select="'julio'"/></xsl:when>
		<xsl:when test="$n = '08'"><func:result select="'agosto'"/></xsl:when>
		<xsl:when test="$n = '09'"><func:result select="'septiembre'"/></xsl:when>
		<xsl:when test="$n = '10'"><func:result select="'octubre'"/></xsl:when>
		<xsl:when test="$n = '11'"><func:result select="'noviembre'"/></xsl:when>
		<xsl:when test="$n = '12'"><func:result select="'diciembre'"/></xsl:when>
		<xsl:otherwise><func:result select="$n"/></xsl:otherwise>
	</xsl:choose>
</func:function>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
