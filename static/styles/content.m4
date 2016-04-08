/* INDEX {{{ autores, biblist, etiquetas, palabras, blog */
h2.IndexLabel,
h2.entry-title  {
	margin: 1em 0 0 0;
	border: none;
	padding: 0;
	background-color: Heading_BACKGROUND;
	font-size: 100%;
	text-align: left;
	}
	h2.IndexLabel > a {
		color: Title_COLOR;
	}

div.AlphaMenu {
	margin: 0;
	border: solid 1px Heading_COLOR;
	padding: 2px;
	font: bold AlphaMenu_FONT_SIZE% AlphaMenu_FACE;
	text-align: center;
	}
	a_MENU_LINK(AlphaMenu,
		Container_MENU_LINK_COLOR, Container_MENU_LINK_BACKGROUND
		)
	span.CurrentLetter {
		MENU_LINK_PADDING;
		color: Container_MENU_LINK_COLOR;
		text-decoration: underline;
		}
	span.MenuLinkPadded {
		MENU_LINK_PADDING;
		}

a_LINK(Author, inherit, inherit)
/*}}}*/

/*TAGS {{{ html > body > div#Container >*/
/*=div#Body > div#Content > div.oi >*/
div#TagCloud {
	margin: 1em;
	font: bold TagCloud_FONT_SIZE% TagCloud_FACE;
	text-indent: 0;
	text-align: center;
	}
	div#TagCloud a {
		margin: 0 7px;
		white-space: nowrap;
		}
/*=div#Body > div#Content > div.oi > div#TagCloud >*/
/*=div#Body > div#Sidebar > div.oi > div#TagLinks.Panel */
		a_LINK(EvenTag,
			EvenTag_COLOR, inherit,
			font-weight: bold
		)
		a_LINK(OddTag,
			OddTag_COLOR, inherit,
			font-weight: bold
		)

/*=div#Body > div#Sidebar > div.oi >*/
div#TagLinks.Panel {
	text-align: center;
	}
	div#TagLinks.Panel > ul {
		list-style-type: none;
		margin: 0;
		padding: 0;
		}
		div#TagLinks.Panel > ul > li {
			display: inline;
			margin: 0;
			padding: 0 5px 0 0;
			}
/*}}}*/

/*TOC {{{html > body > div#Container > div#Body > div#Content > div.oi >*/
div#TOC {
	margin: 1em auto;
	width: 60%;
	font: TOC_FONT_SIZE% TOC_FACE;
	}
	div#TOC > p {	/* the caption */
		margin: 0;
		padding: 0;
		text-align: center;
		text-indent: 0;
		font-weight: bold;
		}
	div#TOC a {
		text-decoration: none;
		font-weight: bold;
		}
	div#TOC a,
	div#TOC a:link,
	div#TOC a:visited {
		color: Content_INTERNAL_LINK_COLOR;
		background-color: inherit;
		}
	div#TOC a:hover {
		text-decoration: underline;
		}
	ol.TOC {	/* list dt in source */
		margin: 0;
		border: 1px solid Title_COLOR;
		padding: 1.5ex 1em 1.5ex 3em;
		background-color: Panel_BACKGROUND;
		}
	ul.TOC {	/* list h2, h3, h4 in source */
		margin: 0;
		border: 1px solid Title_COLOR;
		padding: 1.5ex 1em 1.5ex 3em;
		background-color: Panel_BACKGROUND;
		list-style-type: disc;
		}
		ul.TOC ul.TOC {
			padding: 0 0 0 2em;
			border: none;
			}
/*}}}*/

/*CUSTOM {{{ html > body > div#Container > div#Body > div#Content > div.oi >*/
/* tg_entrevista.html */
html#tg_entrevista div#Content p {
	text-indent: 0;
}

/* glosario.xsl  ⇔ <=> */
span.Equivalencia {
	margin: 0 0.5em;
	font: 150%/0.5 Symbol_FACE;
}

/* textos.xsl */
blockquote.TextFragment {
	margin-top: 0;
	margin-left: 2em;
	}
	blockquote.TextFragment p {
		margin: 0;
		}

/* listados bibliográficos */
ol.biblist li,
ul.biblist li {
	line-height: normal;
}
/*}}}*/

/* LINK {{{ html > body > div#Container > div#Body > div#Content > div.oi >*/
span.External {
	display: none;
}

a {
	text-decoration: none;
}

a,
a:link,
a:visited {
	color: Content_INTERNAL_LINK_COLOR;
	background-color: inherit;
}
a:hover {
	text-decoration: underline;
}

a[href^="http://"] {
	background: url(/images/external) center right no-repeat;
	padding-right: 13px;
}

a[href^="http://espectroautista"],
a[href^="http://EspectroAutista.Info"] {
	background: transparent !important;
	padding-right: 0 !important;
}
/*}}}*/

/* TABLES {{{ html > body > div#Container > div#Body > div#Content > div.oi >*/
table {
	border-collapse: collapse;
	caption-side: top;
	margin: 0 auto 0 auto;
	background-color: table_BACKGROUND;
	font: table_FONT_SIZE% table_FACE;
	text-align: left;
	}
	caption {
		margin-top: 1em;
		margin-bottom: 0.25em;
		font-weight: bold;
		text-align: center;
		}
	th, td {
		border: 1px solid Title_COLOR;
		padding: 4px;
		}
	th {
		font-weight: bold;
		text-align: center;
		}

/* glosario.xsl, tests.xsl */
table.Abbr {
	border-collapse: separate;
	border-spacing: 4px;
	background-color: Container_BACKGROUND;
	}
	table.Abbr td {
		border: none;
		padding: 2px;
		background-color: table_BACKGROUND;
		font-weight: bold;
		text-align: center;
		}
/*}}}*/

/* TEXT {{{ html > body > div#Container > div#Body > div#Content > div.oi >*/
/* Headings */
h1 {
	margin-bottom: .67em;
	border-top: 2px solid Heading_COLOR;
	border-bottom: 2px solid Heading_COLOR;
	padding: 0.1em;
	font: bold 1.8em Heading_FACE;
	color: Heading_COLOR;
	/*background-color: Heading_BACKGROUND;*/
	text-align: center;
}

h2 {
	margin: 1ex 0;
	border-bottom: 2px solid Heading_COLOR;
	padding: 0.1em;
	font: 1.4em Heading_FACE;
	color: Heading_COLOR;
	/*background-color: Heading_BACKGROUND;
	text-align: center;*/
}

h3 {
	margin: 1ex 0;
	border-bottom: 1px solid Heading_COLOR;
	padding: 0.1em;
	font: bold 1.17em Heading_FACE;
	/*text-align: center;*/
}

h4 {
	margin: 1ex 0;
	font: bold 1em Heading_FACE;
}

h5 {
	margin: 1ex 0;
	font: bold 0.83em Heading_FACE;
}

h6 {
	margin: 1ex 0;
	font: bold 0.67em Heading_FACE;
}

/* Block */
p {
	margin: 1ex 0;
	line-height: Text_LINE_HEIGTH%;
}

p + p {
	text-indent: 2em;
}

blockquote {
	margin: 1.5ex 3em;
	font-style: italic;
	font-size: 95%;
}

blockquote > p.cite {
	text-align: right;
}

dl {
	margin: 1em 0;
}

dt {
	margin-top: 0.5em;
	font-weight: bold;
}

dt + dt {
	margin-top: 0;
}

dd {
	margin-left: 3em;
}

ol, ul {
	margin: 1em 0;
	padding: 0 0 0 3em;
}
	li {
		margin: 0.5em 0;
		padding: 0;
		line-height: Text_LINE_HEIGTH%;
		}
ol ol, ul ul, ol ul, ul ol {
	margin: 0;
	}

div.img {
	text-indent: 0;
	text-align: center;
	margin: 1em auto;
}
div.img > p {	/* the caption */
	margin: 0;
	padding: 0;
	font-family: Heading_FACE;
	text-align: center;
	text-indent: 0;
	font-weight: bold;
	font-size: 90%;
}

div.Video {
	text-indent: 0;
	text-align: center;
	margin: 2em auto;
}

/* Inline */
q {
	/*quotes: '“' '”' '‘' '’';*/
	quotes: '“' '”' '«' '»';
}
q:before { content: open-quote; }
q:after  { content: close-quote; }

abbr {
	border-left: 1px dotted Title_COLOR;
	border-right: 1px dotted Title_COLOR;
	padding: 0 2px;
	letter-spacing: 0.05em;
	cursor: help;
}

strong {
	font-weight: bold;
}

cite, em {
	font-style: italic;
}

sub {
	vertical-align: -0.5em;
	font-size: 0.75em;
}

sup {
	vertical-align: 0.5em;
	font-size: 0.75em;
}

ins {
	text-decoration: none;
}

del {
	text-decoration: line-through;
}

/* Site title */
strong.title {
	color: Title_COLOR;
	font-family: Title_FACE;
}

/* */
.url {
	font: bold url_FONT_SIZE% url_FACE;
}

/* UNICODE character, with "safe" font type */
.Symbol {
	font-family: Symbol_FACE;
	text-decoration: none;
}

div.Article {
	margin: 0 auto;
	font-weight: bold;
	text-align: center;
	}
	div.Article p {
		line-height: normal;
		text-indent: 0;
		}

ul.Paper {
	list-style-type: square;
}

/* align */
.Leftist	{ text-align: left; }
.Centrist	{ text-align: center; }

/* forms */
input[type=reset],
input[type=submit], 
input[type=button] {
	cursor: pointer;
}

.HiddenText {
	color: Container_BACKGROUND;
	background-color: Container_BACKGROUND;
	visibility: hidden;
}

undefine(`HEADING_TEXT')

/*}}}*/

/*
vim:sw=4:ts=4:ai:fileencoding=utf8:syntax=css:foldmethod=marker
*/
