/*****************************************************************
 * test.css - Hoja de estilo CSS para los tests
 ******************************************************************/

div#TestText { }

form#Test {
	margin: 0;
	padding: 0;
	line-height: normal;
	}
	form#Test table {
		width: 100%;
	}
	table#TestQuestions {
		border: none;
		margin: 1px 0 1px 0;
		}
		table#TestQuestions th,
		table#TestQuestions td {
			padding: 2px;
			border: 2px solid Container_BACKGROUND;
			}
	div#TestButtons {
		background-color: Test_LABEL_BACKGROUND;
		margin-bottom: 2px;
		padding: 4px 0;
		text-align: center;
		}
		div#TestButtons p { /* Disclaimer */
			margin: 0 3em 1ex 3em;
			font: bold 80%/1 Display_FACE;
			text-align: center;
			}
		div#TestButtons input {
			margin: 0 10px;
			width: 7em;
			font: bold 90% SearchButton_FACE;
			}
	div#TestTotal {
		display: none;
		/*visibility: hidden;*/
		margin: 2px 0;
		border: 1px solid Container_COLOR;
		color: Container_COLOR;
		background-color: Test_TOTAL_BACKGROUND;
		}
		div#TestTotal td {
			padding: 0;
			border: none;
		}
		div#TestTotal p { /* Title for totals */
			margin: 4px;
			font-family: Display_FACE;
			font-weight: bold;
			text-align: center;
			text-align: left;
		}
		td.TestScale {
			text-align: right;
			}

address#TestFooter {
	margin-top: 2px;
	font-style: normal;
	font-weight: normal;
	font-size: 85%;
	text-align: center;
}

th.Range {
	width: 6em;
}

.Arrow {
	outline-style: none;
	font-family: Symbol_FACE;
	color: Test_ARROW_COLOR !important;
	text-decoration: none !important;
}

/*
vim:sw=4:ts=4:ai:fileencoding=utf8:syntax=css
*/
