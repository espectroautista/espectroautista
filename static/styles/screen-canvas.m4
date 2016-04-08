
html {
	overflow-y: scroll;
}

html,
body,
div#Container {
	height: 100%;
}

div#Container {	/* the only <body> child */
	position: relative;
	margin: 0 auto;
	height: auto !important;
	min-height: 100%;
	max-width: Canvas_MAX_WIDTH; 
	min-width: Canvas_MIN_WIDTH;
	}
	div#Header {
		position: relative;
		}
	div#Body {
		padding-bottom: Canvas_FOOTER_RESERVED;
		}
		div#Content {
			float: Canvas_CONTENT_FLOAT;
			margin: 0 Canvas_GUTTER_SIZE%;
			width: Canvas_CONTENT_SIZE%;
			}
			div#Content > div.oi {
				}
		div#Sidebar {
			float: Canvas_SIDEBAR_FLOAT;
			margin-Canvas_SIDEBAR_FLOAT: Canvas_GUTTER_SIZE%;
			width: Canvas_SIDEBAR_SIZE%;
			}
			div#Sidebar > div.oi {
				margin-top: 5px;
				}
	div#Footer {
		position: absolute;
		bottom: 0;
		margin-bottom: 8px;
		width: 100%;
		}
		div#Footer > div.oi {
			margin: 0 Canvas_GUTTER_SIZE%;
		}

/*
vim:sw=4:ts=4:ai:fileencoding=utf8:syntax=css
*/
