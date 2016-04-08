dnl *****************************************************************
dnl Canvas
dnl *****************************************************************

define(Canvas_CONTENT_FLOAT, `right')
define(Canvas_SIDEBAR_FLOAT, `left')

define(Canvas_MAX_WIDTH, 68.75em) dnl 1100px
define(Canvas_MIN_WIDTH, 700px)

define(Canvas_GUTTER_SIZE, 1)dnl percentages
define(Canvas_SIDEBAR_SIZE, 22)
define(Canvas_CONTENT_SIZE, 75)

define(Canvas_FOOTER_RESERVED, 4em)

dnl *****************************************************************
dnl Typefaces
dnl *****************************************************************

dnl define(_GENERIC_FONTS_)
define(_CORE_FONTS_)
dnl define(_FREE_FONTS_)

ifdef(`_FREE_FONTS_', `
	define(_BODY_FACE,	``"Liberation Serif", "DejaVu Serif", serif'')
	define(_CODE_FACE,	``"Liberation Mono", "DejaVu Sans Mono", monospace'')
	define(_DISP_FACE,	``"Liberation Sans", "DejaVu Sans", sans-serif'')
	define(_MENU_FACE,	``"Liberation Sans", "DejaVu Sans", sans-serif'')
	define(_SMAL_FACE,	``"Liberation Sans", "DejaVu Sans", sans-serif'')
	define(_TITLE_FACE,	``"Liberation Sans", "DejaVu Sans", sans-serif'')
')
ifdef(`_GENERIC_FONTS_', `
	define(_BODY_FACE,	``serif'')
	define(_CODE_FACE,	``monospace'')
	define(_DISP_FACE,	``sans-serif'')
	define(_MENU_FACE,	``sans-serif'')
	define(_SMAL_FACE,	``sans-serif'')
	define(_TITLE_FACE,	``sans-serif'')
')
ifdef(`_CORE_FONTS_', `
	define(_BODY_FACE,	``Georgia, "Bitstream Charter", "Droid Serif", serif'')
	define(_CODE_FACE,	``"Courier New", monospace'')
	define(_DISP_FACE,	``"Trebuchet MS", sans-serif'')
	define(_MENU_FACE,	``Verdana, sans-serif'')
	define(_SMAL_FACE,	``Tahoma, Verdana, sans-serif'')
	define(_TITLE_FACE,	``"URW Gothic L", "Century Gothic", sans-serif'')
')

define(Symbol_FACE,		`Arial, "DejaVu Sans", "Droid Sans Fallback", OpenSymbol, sans-serif')

define(Display_FACE,		`_DISP_FACE')
define(Body_FACE,		`_BODY_FACE')

define(Title_FACE,		`_TITLE_FACE')
define(Title_FONT_SIZE,		350)dnl percentages

define(SearchButton_FACE,	`_MENU_FACE')
define(SearchButton_FONT_SIZE,	80)

define(Search_FACE,		`_MENU_FACE')
define(Search_FONT_SIZE,	70)

define(PathBar_FACE,		`_SMAL_FACE')
define(PathBar_FONT_SIZE,	70)
define(PathBar_LINE_HEIGHT,	1.2)

define(Sidebar_FACE,		`_MENU_FACE')
define(Sidebar_FONT_SIZE,	85)

define(Panel_FONT_SIZE,		80)

define(TopMenu_FACE,		`_SMAL_FACE')
define(TopMenu_FONT_SIZE,	75)
define(TopMenu_HEIGHT,		16px)

define(PanelTags_FACE,		`_SMAL_FACE')

define(Footer_FACE,		`_MENU_FACE')
define(Footer_FONT_SIZE,	70)

dnl *******
dnl Content
dnl *******

define(Content_FACE,		`_BODY_FACE')
define(Content_FONT_SIZE,	90)

define(Heading_FACE,		`_DISP_FACE')

define(table_FACE,		`_DISP_FACE')
define(table_FONT_SIZE,		90)

define(TOC_FACE,		`_DISP_FACE')
define(TOC_FONT_SIZE,		90)

define(AlphaMenu_FACE,		`_DISP_FACE')
define(AlphaMenu_FONT_SIZE,	120)

define(TagCloud_FACE,		`_DISP_FACE')
define(TagCloud_FONT_SIZE,	100)

define(url_FACE,		`_CODE_FACE')
define(url_FONT_SIZE,		90)

define(glossary_FACE,		`_DISP_FACE')
define(glossary_BACKGROUND,	`_HEAD_BACKGROUND')

define(map_FACE,		`_DISP_FACE')
define(map_FONT_SIZE,		90)

define(Text_LINE_HEIGTH,	150)

dnl *****************************************************************
dnl Colors
dnl *****************************************************************

define(_BACKGROUND,		GhostWhite)
define(_TEXT_COLOR,		Black)
define(_LINK_COLOR,		RoyalBlue)
define(_HEAD_COLOR,		MidnightBlue)
define(_HEAD_BACKGROUND,	LightGray)
define(_BOX_BACKGROUND,		Lavender)
define(_TAG1_COLOR,		SteelBlue)
define(_TAG2_COLOR,		SeaGreen)

dnl HTML body background (if defined max-width: for Container)
define(body_BACKGROUND,			_BACKGROUND)

dnl Container (page) colors
define(Container_COLOR,			_TEXT_COLOR)
define(Container_BACKGROUND,		_BACKGROUND)

dnl Generic colors
define(Heading_COLOR,			_HEAD_COLOR)
define(Heading_BACKGROUND,		_HEAD_BACKGROUND)

define(Content_INTERNAL_LINK_COLOR,	_LINK_COLOR)
define(Content_EXTERNAL_LINK_COLOR,	_LINK_COLOR)

define(Container_MENU_LINK_COLOR,	_LINK_COLOR)
define(Container_MENU_LINK_BACKGROUND,	_BACKGROUND)

dnl Header colors
define(Header_BACKGROUND,		_BACKGROUND)
define(Title_COLOR,			_HEAD_COLOR)
define(PathBar_BACKGROUND,		_HEAD_BACKGROUND)
define(Search_LINK_COLOR,		_LINK_COLOR)
define(Search_LINK_BACKGROUND,		_BACKGROUND)
define(Breadcrumb_LINK_COLOR,		_LINK_COLOR)

dnl Sidebar Panel colors
define(Panel_COLOR,			_HEAD_COLOR)
define(Panel_BACKGROUND,		_BOX_BACKGROUND)
define(Panel_LINK_COLOR,		_LINK_COLOR)
define(TreeNav_COLOR,			_HEAD_COLOR)

dnl Footer colors
define(Footer_COLOR,			_HEAD_COLOR)
define(Footer_BACKGROUND,		_HEAD_BACKGROUND)
define(Footer_LINK_COLOR,		_LINK_COLOR)

dnl Tables
define(table_BACKGROUND,		_BOX_BACKGROUND)

dnl Tags
define(OddTag_COLOR,			_TAG1_COLOR)
define(EvenTag_COLOR,			_TAG2_COLOR)

dnl Keywords
define(OddKeyword_COLOR,		_TAG1_COLOR)
define(EvenKeyword_COLOR,		_TAG2_COLOR)

dnl Tests
define(Test_LABEL_BACKGROUND,		Silver)
define(Test_TOTAL_BACKGROUND,		_BOX_BACKGROUND)

define(Test_ODD_QUESTION_BACKGROUND,	Gainsboro)
define(Test_EVEN_QUESTION_BACKGROUND,	Beige)

define(Test_ARROW_COLOR,		_HEAD_COLOR)
define(Test_ARROW_BORDER_COLOR,		_HEAD_COLOR)
define(Test_ARROW_DISABLED_COLOR,	Silver)

dnl *****************************************************************
dnl Macros
dnl *****************************************************************

define(MENU_LINK_PADDING, `padding: 0 0.25em')

dnl a_MENU_LINK: links for menus (search, breadcrumb, content menu, footer)
dnl 	$1: class
dnl 	$2: color
dnl 	$3: background
dnl 	$4..$9: extra properties
define(a_MENU_LINK,
`	a.$1 {
		text-decoration: none;
		MENU_LINK_PADDING;
		ifelse($4,`',,$4;)
		ifelse($5,`',,$5;)
		ifelse($6,`',,$6;)
		ifelse($7,`',,$7;)
		ifelse($8,`',,$8;)
		ifelse($9,`',,$9;) }
	a.$1,
	a.$1:link,
	a.$1:visited {
		color: $2;
		background-color: $3; }
	a.$1:hover {
		color: $3;
		text-decoration: none;
		background-color: $2; }'
)

dnl a_LINK: links for panels
dnl 	$1: class
dnl 	$2: color
dnl 	$3: background
dnl 	$4..$9: extra properties
define(a_LINK,
`	a.$1 {
		text-decoration: none;
		ifelse($4,`',,$4;)
		ifelse($5,`',,$5;)
		ifelse($6,`',,$6;)
		ifelse($7,`',,$7;)
		ifelse($8,`',,$8;)
		ifelse($9,`',,$9;) }
	a.$1,
	a.$1:link,
	a.$1:visited {
		color: $2;
		background-color: $3; }
	a.$1:hover {
		text-decoration: underline; }'
)

dnl *****************************************************************
dnl CSS
dnl *****************************************************************

@charset "UTF-8";

.hiddenStructure {
	display: block;
	background: transparent;
	background-image: none;
	border: none;
	height: 0.1em;
	overflow: hidden;
	padding: 0;
	margin: -0.1em 0 0 -0.1em;
	width: 1px;
}

dnl vim:sw=8:ts=8:ai:fileencoding=utf8:syntax=m4:nowrap
