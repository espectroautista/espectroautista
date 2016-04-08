// related.js - Para uso de mapa.html
//
// 

function getRelated() {
	var aElements = new Array()
	var oElements = document.getElementsByTagName('ul')
	var nLen = oElements.length
	for (i = 0, j = 0; i < nLen; i++) {
		if (oElements[i].className === 'Section RelatedNode') {
			aElements[j] = oElements[i]
			j++
		}
	}
	return aElements
}

function hideRelated() {
	var aElements = getRelated()
	var nLen = aElements.length
	for (i = 0; i < nLen; i++){
		aElements[i].style.display = "none"
	}
}

function showRelated() {
	var aElements = getRelated()
	var nLen = aElements.length
	for (i = 0; i < nLen; i++){
		aElements[i].style.display = "block"
	}
}

function menu_related() {
// toggle
	document.getElementById("MenuRelated").blur()
	if (PageState.relaciones === 'si') {
		menu_related_no()
	} else {
		menu_related_si()
	}
	return false
}
function menu_related_no() {
	hideRelated()
	document.getElementById("MenuRelated").innerHTML = mapa["mostrar"]
	PageState.relaciones = 'no'
}

function menu_related_si() {
	showRelated()
	document.getElementById("MenuRelated").innerHTML = mapa["ocultar"]
	PageState.relaciones = 'si'
}

PageState.relaciones = 'si'

OnHashChange.push(function () {
	if (PageState.relaciones === 'si') {
		menu_related_si()
	} else if (PageState.relaciones === 'no') {
		menu_related_no()
	}
})

// vim:sw=4:ts=4:ai:fileencoding=utf8
