
/*=html > body > div#Container > div#Body > */
div#Content {
	font: Content_FONT_SIZE% Content_FACE;
	}

div#Sidebar {
	font: Sidebar_FONT_SIZE% Sidebar_FACE;
	}
	div#Sidebar > div.oi {
		}
		div.Panel {
			margin: 0 auto 1em auto;	
			padding: 0.5em;
			border: 2px outset Panel_COLOR;
			background-color: Panel_BACKGROUND;
			font-size: Panel_FONT_SIZE%;
			}
			div.PanelTitle {
				margin-bottom: 0.5em;
				border: 1px solid Heading_COLOR;
				color: Heading_COLOR;
				background-color: Heading_BACKGROUND;
				font-weight: bold;
				font-size: 120%;
				text-align: center;
				}
			div.TreeNav {
				padding: 0 1em;
				}
				a_LINK(TreeNav,
					TreeNav_COLOR, inherit,
					display: block,
					font-size: 90%,
					margin-top: 0,
					text-align: center,
					margin-bottom: 0.5em,
					word-spacing: normal
				)
				a.SiblingPreceding,
				span.SiblingPreceding {
					float: left;
				}
				a.SiblingFollowing,
				span.SiblingFollowing {
					float: right;
				}
				span.SiblingPreceding,
				span.SiblingFollowing  {
					font-size: 90%;
					margin-top: 0;
				}
			ul.PanelMenu,
			ul.PanelMenu ul {
				clear: both;
				margin: 0;
				padding-left: 1.5em;
				text-transform: lowercase;
				}
				ul.PanelMenu > li {
					margin: 0;
					padding: 0.5ex 0;
					line-height: normal;
					}
				li.PanelMenuNode {
					font-weight: bold;
					list-style-type: square;
					}
				li.PanelMenuLeave, li.PanelMenuCurrent {
					list-style-type: disc;
					}
					a_LINK(PanelMenu,
						Panel_LINK_COLOR, inherit,
						display: block
					)
				li.PanelMenuNode:hover,
				li.PanelMenuLeave:hover {
					background-color: Container_BACKGROUND;
					}
			ul#PanelTags a {
				font-family: PanelTags_FACE;
				font-weight: normal;
			}

/*
vim:sw=4:ts=4:ai:fileencoding=utf8:syntax=css
*/
