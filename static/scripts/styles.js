////////////////////////////////////////////////////////////////////////
// Styles
////////////////////////////////////////////////////////////////////////

function setActiveStyleSheet(title) {
	var i, a
	for (i = 0; (a = document.getElementsByTagName("link")[i]); ++i) {
		if (a.getAttribute("rel").indexOf("style") !== -1
				&& a.getAttribute("title")) {
			a.disabled = true
			if (a.getAttribute("title") === title) {
				a.disabled = false
			}
		}
	}
}

function getActiveStyleSheet() {
	var i, a
	for (i = 0; (a = document.getElementsByTagName("link")[i]); ++i) {
		if (a.getAttribute("rel").indexOf("style") !== -1
				&& a.getAttribute("title")
				&& !a.disabled) {
			return a.getAttribute("title")
		}
	}
	return null
}

function getPreferredStyleSheet() {
	var i, a
	for (i = 0; (a = document.getElementsByTagName("link")[i]); ++i) {
		if (a.getAttribute("rel").indexOf("style") !== -1
				&& a.getAttribute("rel").indexOf("alt") === -1
				&& a.getAttribute("title")) {
			return a.getAttribute("title")
		}
	}
	return null
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
