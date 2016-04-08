/******************************************************************
 * Logo, Title & Search
 ******************************************************************/

define(BUTTON_WIDTH, 60)

/*=html > body > div#Container > */
div#Header {
	}
	a#Logo {
		display: block;
		float: left;
		margin: 0 Canvas_GUTTER_SIZE%;
		width: Canvas_SIDEBAR_SIZE%;
		/* disable active/focus link decoration */
		color: Header_BACKGROUND;
		}
		a#Logo img {
			width: 100%;
			height: auto;
		}
	div#Title {
		padding-top: 1em;
		color: Title_COLOR;
		font: bold Title_FONT_SIZE% Title_FACE;
		}
	form#Search {
		position: absolute;
		top: 0.5em;
		right: 1em;
		font-family: Search_FACE;
		text-align: right;
		}
		a_MENU_LINK(Search,
			Search_LINK_COLOR, Search_LINK_BACKGROUND
			)
		html#ayuda a.ayuda,
		html#etiquetas a.etiquetas,
		html#mapa a.mapa {
			font-weight: bold;
		}

		form#Search > ul {
			list-style-type: none; 
			margin: 0 0 1em 0;
			padding: 0;
			font-size: Search_FONT_SIZE%;
			}
			form#Search > ul > li {
				display: inline;
				margin: 0 0 0 1em;
				padding: 0;
				}
		form#Search > div > input[type=submit] {
			width: BUTTON_WIDTH()px;
			font: bold eval(BUTTON_WIDTH / 6)px SearchButton_FACE;
			cursor: pointer;
			}
	div#PathBar {
		clear: both;
		border-top: 1px solid Title_COLOR;
		border-bottom: 1px solid Title_COLOR;
		padding: 0.1em 0;
		background-color: PathBar_BACKGROUND;
		}
		div#Breadcrumb {
			margin: 0 Canvas_GUTTER_SIZE%;
			font: PathBar_FONT_SIZE%/PathBar_LINE_HEIGHT PathBar_FACE;
			text-align: left;
			text-transform: lowercase;
			}
			a_MENU_LINK(Breadcrumb,
				Breadcrumb_LINK_COLOR, PathBar_BACKGROUND
			)
			span#BreadcrumbTitle {
				margin-right: 0.25em;
				color: Container_COLOR;
				}
			span.BreadcrumbArrow {
				margin: 0 0.25em;
				font-weight: bold;
				}
			strong.BreadcrumbHere {
				color: Title_COLOR;
				font-weight: normal;
				}
			strong.BreadcrumbHere.Letter {
				text-transform: uppercase;
			}

undefine(`BUTTON_WIDTH')

/*
vim:sw=4:ts=4:ai:fileencoding=utf8:syntax=css
*/
