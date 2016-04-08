// Evaluador del test LSAS
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestLSAS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
}
TestLSAS.prototype = new Test

TestLSAS.prototype.itera = function(f) {
	var sFactors = "FA"
	for (var nPregunta = 1; nPregunta <= this.nTotal; ++nPregunta) {
		var n = String(nPregunta)
		for (var nFactor = 0; nFactor < sFactors.length; ++nFactor) {
			var oSelect = document.getElementById('R'+n+sFactors.charAt(nFactor))
			if (!f.call(this, nPregunta, oSelect)) return false
		}
	}
	return true
}

TestLSAS.prototype.rellena = function() {
	function r(nPregunta, oSelect) {
		var nIndex = 0
		while (nIndex === 0) {
			nIndex = choose(oSelect.options).index
		}
		oSelect.options[nIndex].selected = true
		return true
	}
	this.itera(r)
}

TestLSAS.prototype.completo = function() {
	function c(nPregunta, oSelect) {
		if (oSelect.selectedIndex === 0) {
			this.faltaRespuesta(nPregunta)
			return false
		} else {
			return true
		}
	}
	return this.itera(c)
}

TestLSAS.prototype.submit = function() {
	var nFear = 0, nAvoidance = 0
	if (debug() && cierto(this.nTotal === 24, 'expected 24 questions')) {
		this.rellena()
	}
	if (this.completo()) {
		function evalua(nPregunta, oSelect) {
			if (oSelect.name.indexOf("F") !== -1) { // Fear
				nFear += Number(oSelect.options[oSelect.selectedIndex].value)
			} else {	// Avoidance
				nAvoidance += Number(oSelect.options[oSelect.selectedIndex].value)
			}
			return true
		}
		this.itera(evalua)
		this.muestraTotal(
				[this.aMensajes["lsasTotal"],
					this.aMensajes["lsasFear"],
					this.aMensajes["lsasAvoidance"]],
				[String(nFear+nAvoidance),
					String(nFear),
					String(nAvoidance)])
	}
	return CONSERVA
}

TestLSAS.prototype.reset = function() {
	var resultado = CONSERVA
	function r(nPregunta, oSelect) {
		if (oSelect.selectedIndex !== 0) {
			if (this.borramos()) resultado = BORRA
			return false
		} else {
			return true
		}
	}
	this.itera(r)
	return resultado
}

TestLSAS.prototype.serializa = function() {
	var sAcumulador = ''
	function acumula(nPregunta, oSelect) {
		sAcumulador += String.fromCharCode(65 + oSelect.selectedIndex)
		return true
	}
	this.itera(acumula)
	return sAcumulador
}

Test.prototype.recupera = function(sSerie) {
	function r(nPregunta, oSelect) {
		var n = (oSelect.name.indexOf("F") !== -1) ? 2 : 1
		oSelect.options[sSerie.charCodeAt((nPregunta * 2) - n) - 65].selected = true
		return true
	}
	this.itera(r)
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
