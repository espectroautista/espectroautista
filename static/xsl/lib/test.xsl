<?xml version="1.0" encoding="UTF-8"?>
<!--
 * test.xsl - Parte básica y común a todos los test
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:p="urn:uuid:5c1ec6e0-a8ba-11dd-8549-001fc6576244"
	xmlns="&XHTMLNS;"
	xmlns:h="&XHTMLNS;"
	xmlns:tables="urn:uuid:109dfc92-62cc-11dd-82f6-001fc6576244"
	exclude-result-prefixes="p h tables"
>

<xsl:import href="node.xsl"/>

<!--
 ! node.scripts
 !-->
 <xsl:template mode="node.scripts" match="h:html">
	<xsl:variable name="id" select="/h:html/@id"/>
	<xsl:variable name="data"
		select="document(concat('../../', $Language, '/data/', $id, '.xml'))"/>

	<script type="text/javascript" src="/scripts/test">;</script>

	<xsl:apply-templates select="self::h:html" mode="test.includes"/>

	<script type="text/javascript"><xsl:text disable-output-escaping="yes">//&lt;![CDATA[</xsl:text>
			var test = new Test<xsl:value-of select="$id"/>(
			'<xsl:value-of select="$id"/>',
			<xsl:value-of select="count($data/sentencias/sentencia|
																	$data/preguntas/pregunta|
																	$data/secciones/seccion/sintoma)"/>,
			{
				<xsl:apply-templates select="self::h:html" mode="test.messages"/>
				coeficiente: '<xsl:value-of select="tables:text('coeficiente')"/>',
				pregunta: '<xsl:value-of select="tables:text('pregunta')"/>',
				preguntaX: '<xsl:value-of select="tables:text('preguntaX')"/>',
				ocultar: '<xsl:value-of select="tables:text('ocultar')"/>',
				mostrar: '<xsl:value-of select="tables:text('mostrar')"/>',
				borrar: '<xsl:value-of select="tables:text('borrar')"/>'
			}
		);
		<xsl:text disable-output-escaping="yes">//]]&gt;</xsl:text>
	</script>
</xsl:template>

<!--
 ! node.styles
 !-->
<xsl:template mode="node.styles" match="h:html">
	<xsl:param name="node"/>

	<!-- likert.css or choice.css -->
	<link media="all" rel="stylesheet" type="text/css" href="/styles/{$node/@kind}"/>
</xsl:template>

<!--
 ! node.menus
 !-->
 <xsl:template mode="node.menus" match="h:html">
	<li>
		<xsl:call-template name="html.anchor">
			<xsl:with-param name="sClass" select="'TopMenu'"/>
			<xsl:with-param name="sText" select="string(tables:text('ocultar'))"/>
			<xsl:with-param name="sHref" select="'#'"/>
			<xsl:with-param name="sId" select="'MenuHide'"/>
			<xsl:with-param name="sOnClick" select="'return menu_description();'"/>
		</xsl:call-template>
	</li>
</xsl:template>

<!--
 ! h:body
 !-->
 <xsl:template match="h:body">
	<xsl:variable name="id" select="/h:html/@id"/>
	<xsl:variable name="data"
		select="document(concat('../../', $Language, '/data/', $id, '.xml'))"/>

	<xsl:apply-templates select="h:h1"/>

	<div id="TestText">
		<xsl:apply-templates select="h:h1/following-sibling::*"/>
	</div>

	<form id="Test"
		action=""
		onsubmit="return test.submit();"
	>
		<table id="TestQuestions">
			<xsl:apply-templates select="self::h:body" mode="test.colgroup"/>

			<tbody>
				<!--
				! Only one of the nex apply-templates "wins"
				-->
				<!-- Likert tests... -->
				<xsl:apply-templates select="$data/sentencias/sentencia"/>
				<!-- ... or Choice tests -->
				<xsl:apply-templates select="$data/preguntas"/>
				<!-- ... or AAA test -->
				<xsl:apply-templates select="$data/secciones"/>
			</tbody>
		</table>

		<div id="TestButtons">
			<p><xsl:value-of select="tables:text('disclaimer')"/></p>

			<input type="submit" value="{tables:text('submit')}"/>
			<input type="reset" value="{tables:text('reset')}" onclick="return test.reset();" />
			<input type="button" value="{tables:text('imprimir')}" onclick="return menu_print();"/>
		</div>

		<div id="TestTotal">
			<p><xsl:value-of select="tables:text('resultado')"/> (<a id="LINK" href="#"><xsl:value-of select="tables:text('enlace')"/></a>)</p>

			<table>
				<colgroup>
					<col style="width:50%"/>
					<col style="width:50%"/>
				</colgroup>

				<tbody>
					<xsl:apply-templates select="self::h:body" mode="test.show-output"/>
				</tbody>
			</table>
		</div>
	</form>

	<address id="TestFooter">
		<xsl:variable name="rLink" select="substring(tables:outline($id)/@url, 2)"/>
		<xsl:variable name="rTitle" select="concat(tables:text('site'), substring(tables:outline($id)/@utf, 2))"/>

		<xsl:value-of select="tables:text('original')"/>
		<br/>

		<xsl:call-template name="html.anchor">
			<xsl:with-param name="sText" select="string($rTitle)"/>
			<xsl:with-param name="sHref" select="concat(tables:text('site'), string($rLink))"/>
			<xsl:with-param name="sClass" select="'url'"/>
			<xsl:with-param name="sTarget" select="'_self'"/>
		</xsl:call-template>
	</address>

</xsl:template>

<!--
 !	default methods
 -->
<xsl:template match="h:html" mode="test.messages"/>

<xsl:template match="h:body" mode="test.colgroup">
	<xsl:call-template name="error.terminate">
		<xsl:with-param name="text">
			<xsl:text>test.xsl; TBD: test.colgroup</xsl:text>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="h:html" mode="test.includes">
	<xsl:call-template name="error.terminate">
		<xsl:with-param name="text">
			<xsl:text>test.xsl; TBD: test.includes</xsl:text>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="h:body" mode="test.show-output">
	<xsl:call-template name="error.terminate">
		<xsl:with-param name="text">
			<xsl:text>test.xsl; TBD: test.show-output</xsl:text>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

</xsl:transform>
<!--
 vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
