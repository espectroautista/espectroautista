/*****************************************************************
 * Hoja de estilo CSS para los tests de tipo choice
 ******************************************************************/

include(test.m4)

table#TestQuestions {
	margin: 0;
	padding: 0;
	background-color: transparent;
	}
	li.OddQuestion,
	li.EvenQuestion {
		margin: 0 0 0.5em 0;
		padding: 0.5em;
		border: thin solid Container_COLOR;
		}
	li.OddQuestion {
		background-color: Test_ODD_QUESTION_BACKGROUND;
		}
	li.EvenQuestion {
		background-color: Test_EVEN_QUESTION_BACKGROUND;
		}
	li.QuestionOption {
		text-indent: -1.7em;
		}
	/*= li */
		/*= div.clearfix */
			strong.Question {
				float: left;
				width: 90%;
				}
			div.NavigationArrows {
				float: right;
				width: 3em;
				font-family: Symbol_FACE;
				text-align: center;
				}
		p.instrucciones {
			font-size: 90%;
			font-style: italic;
			}
		ol.Choices {
			list-style-type: none;
			}

/*
vim:sw=4:ts=4:ai:fileencoding=utf8:syntax=css
*/
