/*****************************************************************
 * Hoja de estilo CSS para los tests de tipo likert
 ******************************************************************/

include(test.m4)

table#TestQuestions {
	background-color: transparent;
	}
	table#TestQuestions td.NavigationCell {
		padding: 0;
		vertical-align: bottom;
		}
		div.NavigationArrows {
			margin: 4px 0 4px 0;
			width: 6em;
			border: 1px solid Test_ARROW_BORDER_COLOR;
			font-family: Symbol_FACE;
			text-align: center;
			}
			span.DisabledArrow {
				color: Test_ARROW_DISABLED_COLOR;
				font-family: Symbol_FACE;
				text-decoration: none;
				}
		td.OddQuestionRadio,
		td.EvenQuestionRadio {
			vertical-align: middle;
			}
		td.OddQuestionText,
		td.EvenQuestionText {
			vertical-align: top;
			}
		td.OddQuestionNumber,
		td.OddQuestionText,
		td.OddQuestionRadio {
			background-color: Test_ODD_QUESTION_BACKGROUND;
			}
		td.EvenQuestionNumber,
		td.EvenQuestionText,
		td.EvenQuestionRadio {
			background-color: Test_EVEN_QUESTION_BACKGROUND;
			}
		td.OddQuestionNumber, 
		td.EvenQuestionNumber {
			width: 4em;
			font-weight: bold;
			font-size: 90%;
			text-align: right;
			vertical-align: middle;
			}
		td.OddQuestionText,
		td.EvenQuestionText {
			text-align: left;
			}
		td.OddQuestionRadio,
		td.EvenQuestionRadio {
			text-align: center;
			}
		th.OptionLabel {
			background-color: Test_LABEL_BACKGROUND;
			text-align: center;
			font-weight: bold;
			font-size: 80%;
			}
		th.AAASection {
			background-color: Test_LABEL_BACKGROUND;
			font-weight: bold;
			text-align: center;
			}

/*
vim:sw=4:ts=4:ai:fileencoding=utf8:syntax=css
*/
