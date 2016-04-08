
div.KeywordList {
	padding-left: 2.5em;
	}
	div.KeywordItem {
		padding: 0.5em 0;
		}
		div.KeywordBibRef {
			float: left;
			display: list-item;
			width: 66%;
			list-style-type: disc;
			}
		div.KeywordKeywords {
			float: right;
			margin-left: 2%;
			width: 31%;
			font: 80% Display_FACE;
			}
			a_LINK(EvenKeyword,
				EvenKeyword_COLOR, inherit,
				margin-right: 1em
			)
			a_LINK(OddKeyword,
				OddKeyword_COLOR, inherit,
				margin-right: 1em
			)
			span.EvenKeyword {
				margin-right: 1em;
				color: EvenKeyword_COLOR;
			}
			span.OddKeyword {
				margin-right: 1em;
				color: OddKeyword_COLOR;
			}

/*
vim:sw=4:ts=4:ai:fileencoding=utf8:syntax=css
*/
