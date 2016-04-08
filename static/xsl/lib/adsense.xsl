<?xml version="1.0" encoding="UTF-8"?>
<!--
 * adsense.xsl - Google AdSense.
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
 ! Google adsense scripts
 !-->
<xsl:template name="adsense.scripts">

	<script type="text/javascript"><xsl:text disable-output-escaping="yes">//&lt;![CDATA[</xsl:text>
		google_ad_client = "pub-0441781071479374";
		/* 728x90, created 5/19/09 */
		google_ad_slot = "2259149992";
		google_ad_width = 728;
		google_ad_height = 90;
		<xsl:text disable-output-escaping="yes">//]]&gt;</xsl:text>
	</script>

	<script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js" />
</xsl:template>

</xsl:transform>
<!--
	vim:sw=2:ts=2:ai:fileencoding=utf8:nowrap
-->
