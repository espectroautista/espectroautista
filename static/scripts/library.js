// Utilidades
//
////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function map(aList, f) {
	if (aList.length === 0) return aList
	var aNew = new Array(aList.length)
	for (var i = 0; i < aList.length; ++i) {
		aNew[i] = f(aList[i])
	}
	return aNew
}

function filter(aList, f) {
	if (aList.length === 0) return aList
	var aNew = new Array()
	for (var i = 0; i < aList.length; ++i) {
		if (f(aList[i])) {
			aNew.push(aList[i])
		}
	}
	return aNew
}

function reduce(aList, f, x) {
	for (var i = 0; i < aList.length; ++i) {
		x = f(x, aList[i])
	}
	return x
}

function sum(aList) {
	return reduce(aList, function (x,y) { return x+y }, 0)
}

function every(aList) {
	for (var i = 0; i < aList.length; ++i) {
		if (!aList[i]) return false
	}
	return true
}

function some(aList) {
	for (var i = 0; i < aList.length; ++i) {
		if (aList[i]) return true
	}
	return false
}

function member(x, aList) {
	for (var i = 0; i < aList.length; ++i) {
		if (x === aList[i]) return true
	}
	return false
}

function shuffle(aList) {
	function swap(a, i, j) {
		var x	= a[i]
		a[i]	= a[j]
		a[j]	= x
	}
	function between(m, n) {
		return m + Math.floor(Math.random() * (n-m))
	}
	for (var i = 0; i < aList.length; ++i) {
		var j = between(i, aList.length)
		swap(aList, i, j)
	}
	return aList
}

function choose(aList) {
	if (aList.length === 0) return undefined
	return aList[Math.floor(Math.random() * aList.length)]
}

function round(n, p) {
	return Math.round(n * Math.pow(10, p)) / Math.pow(10, p)
}

////////////////////////////////////////////////////////////////////////
// For analytics
////////////////////////////////////////////////////////////////////////

function online() {
	return (location.protocol !== "file:") &&
		   (location.hostname.indexOf('-') === -1)
}

////////////////////////////////////////////////////////////////////////
// Hash management
////////////////////////////////////////////////////////////////////////

var PageState = new Object()
var OnHashChange = new Array()

function hash_merge(oParams) {
	// merge parameters with PageState
	if (oParams) {
		for (var p in oParams) {
			PageState[p] = oParams[p]
		}
	}
	// build has string
	var a = []	
	for (var p in PageState) {
		if (PageState[p] !== undefined)
			a.push(p + ':' + PageState[p])
	}
	return a.join(';')
}

function hash_handler(e) {
	// add/change to PageState parameters in hash
	var sHash = location.hash
	if (sHash) {
		if (sHash.charAt(0) === '#')
			sHash = sHash.substr(1)
		if (sHash) {
			var aVariables = sHash.split(';')
			for (var p in aVariables) {
				var aPair = aVariables[p].split(':', 2)
				if (aPair.length === 2) {
					PageState[aPair[0]] = aPair[1]
				}
			}
		}
	}
	// run callbacks
	for (var i = 0; i < OnHashChange.length; ++i) {
		OnHashChange[i]()
	}
}

// hash init
window.onload = function (e) {
	window.onhashchange = hash_handler
	hash_handler()
}

//window.onunload = function (e) { }

////////////////////////////////////////////////////////////////////////
//  printable
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

OnHashChange.push(function () {
	if (PageState.imprimir === 'si') {
		setActiveStyleSheet('Printer')
	} else if (getActiveStyleSheet() !== 'Screen') {
		setActiveStyleSheet('Screen')
	}
	PageState.imprimir = undefined
})

PageState.imprimir = undefined

function menu_print() {
	location.hash = hash_merge({imprimir:'si'})
	return false
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
