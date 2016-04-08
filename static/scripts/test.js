// Evaluador base 
//
// require library.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function menu_description() {
	document.getElementById("MenuHide").blur()
	if (PageState.descripcion === 'si') {
		menu_description_no()
	} else {
		menu_description_si()
	}
	return false
}

function menu_description_no() {
	document.getElementById("TestText").style.display = "none"
	document.getElementById("MenuHide").innerHTML = test.aMensajes["mostrar"]
	PageState.descripcion = 'no'
}

function menu_description_si() {
	document.getElementById("TestText").style.display = "block"
	document.getElementById("MenuHide").innerHTML = test.aMensajes["ocultar"]
	PageState.descripcion = 'si'
}

PageState.descripcion = 'si'

OnHashChange.push(function () {
	if (PageState.descripcion === 'si') {
		menu_description_si()
	} else if (PageState.descripcion === 'no') {
		menu_description_no()
	}
})

var BORRA = true
var CONSERVA = false

function cierto(bCondicion, sMensaje) {
	if (!bCondicion) alert("ERROR: " + sMensaje)
	return bCondicion
}

function debug() {
	return (window.location.search === "?DEBUG")
}

function Test(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	this.sId = sId
	this.nTotal = nTotal
	this.sCoeficiente = dMensajes["coeficiente"]
	this.sPregunta = dMensajes["pregunta"]
	this.sBorrar = dMensajes["borrar"]
	this.aMensajes = dMensajes
	var l = window.location
	var s = (l.protocol === "file") ? "///" : "//"
	this.sUrl = l.protocol + s + l.host + l.pathname
}

// for likert tests (this.sLetras must be defined)
Test.prototype.itera = function(f) {
	for (var nPregunta = 1; nPregunta <= this.nTotal; ++nPregunta) {
		var n = String(nPregunta), aBotones = new Array(this.sLetras.length)
		for (var i = 0; i < aBotones.length; ++i) {
			aBotones[i] = document.getElementById("R"+n+this.sLetras.charAt(i))
		}
		if (!f.call(this, nPregunta, aBotones)) return false
	}
	return true
}

// for likert tests (this.sLetras must be defined)
Test.prototype.evalua = function(nPregunta) {
	var oRadio, n = String(nPregunta)
	for (var i = 0; i < this.sLetras.length; ++i) {
		oRadio = document.getElementById("R"+n+this.sLetras.charAt(i))
		if (oRadio.checked) return Number(oRadio.value)
	}
}

Test.prototype.rellena = function() {
	function r(nPregunta, aBotones) {
		choose(aBotones).checked = true
		return true
	}
	this.itera(r)
}

Test.prototype.verifica = function(fCondicion, nSuma) {
	this.rellena()

	var nAcumulador = 0
	function v(nPregunta, aBotones) {
		aBotones = map(aBotones, function (oRadio) { return Number(oRadio.value)})
		if (cierto(fCondicion.apply(this, aBotones), "bad value " + String(nPregunta))) {
			nAcumulador += sum(aBotones)
			return true
		} else {
			return false
		}
	}
	if (!this.itera(v)) return false
	return cierto(nAcumulador === nSuma,
				  this.sId + " != " + String(nSuma) + "; = "+ String(nAcumulador))
}

Test.prototype.verificaOrden = function(nPregunta, aBotones) {
		function ascendente(aList) {
			var n = 1; if (this.bDesdeCero) n = 0
			for (var i = 0; i < aList.length; ++i) {
				if (aList[i] !== (i+n)) return false
			}
			return true
		}
		function descendente(aList) {
			var n = 0; if (this.bDesdeCero) n = 1
			for (var i = aList.length - 1; i >= 0; i = i-1) {
				if (aList[i] !== (aList.length - i - n)) return false
			}
			return true
		}
		aBotones = map(aBotones, function (oRadio) { return Number(oRadio.value)})
		if (member(nPregunta, this.aAscendentes)) {
			cierto(ascendente.call(this, aBotones), "expected ascendent order: " + String(nPregunta))
		} else {
			cierto(descendente.call(this, aBotones), "expected descendent order: " + String(nPregunta))
		}
}

//
Test.prototype.saltamos = function(nPregunta, sPregunta) {
	alert(sPregunta + String(nPregunta))
	window.location.assign(this.sUrl+"#P"+String(nPregunta))
}

Test.prototype.faltaRespuesta = function(nPregunta) {
	this.saltamos(nPregunta, this.sPregunta)
}

Test.prototype.completo = function() {
	function c(nPregunta, aBotones) {
		if (!some(map(aBotones, function (oRadio) { return oRadio.checked }))) {
			this.faltaRespuesta(nPregunta)
			return false
		} else {
			return true
		}
	}
	return this.itera(c)
}

Test.prototype.totaliza = function() {
	if (debug() && !this.verifica()) return -1
	if (!this.completo()) return -1

	var nAcumulador = 0
	function acumula(nPregunta, aBotones) {
		for (var nBoton = 0; nBoton < aBotones.length; ++nBoton) {
			if (aBotones[nBoton].checked) {
				nAcumulador += Number(aBotones[nBoton].value)
				break
			}
		}
		return true
	}
	this.itera(acumula)
	return nAcumulador
}

Test.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente !== -1) {
		this.muestraTotal([this.sCoeficiente], [String(nCoeficiente)])
	}
	return CONSERVA
}

//
Test.prototype.borramos = function() {
	if (confirm(this.sBorrar)) {
		window.location.assign(this.sUrl+(debug()?"?DEBUG":"")+"#B0")
		document.getElementById("TestTotal").style.display = "none"
		return true
	} else {
		return false
	}
}

Test.prototype.reset = function() {
	var resultado = CONSERVA
	function r(nPregunta, aBotones) {
		if (some(map(aBotones, function (oRadio) { return oRadio.checked }))) {
			if (this.borramos()) {
				resultado = BORRA
			}
			return false
		} else {
			return true
		}
	}
	this.itera(r)
	return resultado
}

Test.prototype.muestraTotal = function(etiquetas, valores) {
	var sMensaje = "", nbsp = " "
	for (var i = 0; i < etiquetas.length; ++i) {
		sMensaje += etiquetas[i] + ((etiquetas[i] !== "") ? ":"+nbsp : "") + valores[i] + "\n"
		document.getElementById("OUTPUT"+String(i+1)).innerHTML = nbsp + valores[i]
	}
	//
	var e = document.getElementById("LINK")
	e.href= '#' + hash_merge({recupera: this.serializa()})
	//
	var d = document.getElementById("TestTotal")
	d.style.display = "block"
	alert(sMensaje)
}

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

Test.prototype.serializa = function() {
	var sAcumulador = ''
	function acumula(nPregunta, aBotones) {
		for (var nBoton = 0; nBoton < aBotones.length; ++nBoton) {
			if (aBotones[nBoton].checked) {
				sAcumulador += String.fromCharCode(65 + nBoton)
				break
			}
		}
		return true
	}
	this.itera(acumula)
	return sAcumulador
}

Test.prototype.recupera = function(sSerie) {
	function r(nPregunta, aBotones) {
		aBotones[sSerie.charCodeAt(nPregunta - 1) - 65].checked = true
		return true
	}
	this.itera(r)
}

OnHashChange.push(function () {
	if (PageState.recupera !== undefined) {
		test.recupera(PageState.recupera)
		test.submit()
	}
})

// vim:sw=4:ts=4:ai:fileencoding=utf8
