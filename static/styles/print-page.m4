
/*
 * Screen disabled boxes
 */

/* screen-header.m4 */
/*=html > body > div#Container > */
div#Header		{ display: none; }

/* screen-footer.m4 */
/*=html > body > div#Container > */
div#Footer		{ display: none; }

/* screen-body.m4 */
/*=html > body > div#Container > div#Body > */
div#Sidebar		{ display: none; }

/* screen-menu.m4 */
/*=html > body > div#Container > div#Body > div#Content > div.oi > */
ul#TopMenu	 { display: none; }

/*
 * Content enabled boxes
 */

/* content-link.m4 */
span.External {
	display: inline !important;
	font: url_FONT_SIZE% url_FACE;
}

/*
 * Content disabled boxes
 */

/* test.m4 */
/*=html > body > div#Container > div#Body > div#Content > div#oi > form#Test > */
div#TestButtons {
	display: none;
}

/* content-index.html */
h2.IndexLabel > a {
	display: none;
}

/* likert.m4 */
/*=html > body > div#Container > div#Body > div#Content > div#oi > 
	form#Test > table#TestQuestions > td#NavigationCell */
div.NavigationArrows {
	display: none;
}

/*
 * Content styles
 */

/*=html > body > div#Container > div#Body > */
div#Content {
	font: 12pt Body_FACE;
	color: Black;
	background-color: White;
}

/*=html > body > div#Container > div#Body > div#Content > div.oi >*/

a,
a:link,
a:visited,
a:hover {
	background-color: inherit !important;
	color: inherit !important;
	text-decoration: none !important;
	/*cursor: text !important;*/
}

abbr {
	border-bottom: none !important;
	/*cursor: text !important;*/
}

a[href^="http://"] {
	border-bottom: 1px dotted Gray;
	/*cursor: pointer !important;*/
}

/* content-index.html */
span.CurrentLetter {
	color: inherit !important;
}

/*
vim:sw=4:ts=4:ai:fileencoding=utf8:syntax=css
*/
