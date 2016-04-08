
/*=html > body > div#Container > */
div#Footer {
	border-top: 1px solid Footer_COLOR;
	border-bottom: 1px solid Footer_COLOR;
	color: Footer_COLOR;
	background-color: Footer_BACKGROUND;
	}
	div#Footer > div.oi {
		padding: 2px;
		font: Footer_FONT_SIZE% Footer_FACE;
		}
		ul#FooterLinks {
			float: left;
			list-style-type: none;
			margin: 0;
			padding: 0;
			line-height: 1;
			}
			ul#FooterLinks > li {
				display: inline;
				margin: 0 1em 0 0;
				padding: 0;
				}
				a_MENU_LINK(FooterLink,
					Footer_LINK_COLOR, Footer_BACKGROUND
					)
					img.RSSIcon {
						vertical-align: text-top;
						}
		a_MENU_LINK(FooterGoTop,
			Footer_LINK_COLOR, Footer_BACKGROUND,
			float: right
			)

/*
vim:sw=4:ts=4:ai:fileencoding=utf8:syntax=css
*/
