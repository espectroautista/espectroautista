/*****************************************************************
 * Hoja de estilo CSS para el mapa
 ******************************************************************/

ul.xoxo {
	font: map_FONT_SIZE% map_FACE;
	}

ul.Section {
	margin: 0;
	padding: 0;
	padding-left: 2em;
	}
	ul.Section li {
		margin: 0;
		padding: 0.2ex 0;
		}

div#Conventions {
	float: right;
	width: 20em;
	border: solid 1px;
	font: map_FONT_SIZE% map_FACE;
	}
	div#Conventions > p {
		margin: 0;
		border-bottom: solid 1px;
		font-weight: bold;
		text-align: center;
	}
	ul.Conventions {
		margin: 0;
		padding: 1ex 0 1ex 2em;
		}
		li.Node {
			list-style-type: square;
			}
		li.Leave {
			list-style-type: disc;
			}
		li.Related {
			list-style-type: circle;
			margin: 0;
			padding: 0;
			font-style: italic;
			font-size: 90%;
			}
			a:target {
				padding: 2px 0 !important;
				color: Container_BACKGROUND !important;
				background-color: Content_INTERNAL_LINK_COLOR !important;
				font-weight: normal !important;
				}

/*
vim:sw=4:ts=4:ai:fileencoding=utf8:syntax=css
*/
