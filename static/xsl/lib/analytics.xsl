<?xml version="1.0" encoding="UTF-8"?>
<!--
 * analytics.xsl - Google analytics.
 *
-->
<!DOCTYPE xsl:transform [
	<!ENTITY % ENTITIES SYSTEM "../../dtd/entities.dtd"> %ENTITIES;
]>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="&XHTMLNS;"
>

<!--
 ! Google analytics scripts
 !-->
<xsl:template name="analytics.scripts">
	<script type="text/javascript"><xsl:text disable-output-escaping="yes">//&lt;![CDATA[</xsl:text>
		if (online()) {
			var _gaq = _gaq || [];
			_gaq.push(['_setAccount', 'UA-8673551-2']);
			_gaq.push(['_trackPageview']);
			(function() {
				var ga = document.createElement('script');
				ga.type = 'text/javascript';
				ga.async = true;
				ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
				var s = document.getElementsByTagName('script')[0];
				s.parentNode.insertBefore(ga, s);
			})();
		}
		<xsl:text disable-output-escaping="yes">//]]&gt;</xsl:text>
	</script>
</xsl:template>

</xsl:transform>
<!--
	vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
