// Evaluador del test QCHAT
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestQCHAT(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.aNBotones = [undefined,	// used in place of sLetras
		5,5,5,6,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5
	]
}
TestQCHAT.prototype = new Test

TestQCHAT.prototype.verifica = function() {
	this.rellena()
	function p(v1, v2, v3, v4, v5) {
		return (v1 === 0 && v2 === 1 && v3 === 2 && v4 === 3 && v5 === 4) ||
			   (v1 === 4 && v2 === 3 && v3 === 2 && v4 === 1 && v5 === 0)
	}
	return Test.prototype.verifica.call(this, p, ((1+2+3+4)*this.nTotal)+4)
			&& cierto(this.nTotal === 25, "expected 25 questions")
}

TestQCHAT.prototype.itera = function(f) {
	for (var nPregunta = 1; nPregunta <= this.nTotal; ++nPregunta) {
		var n = String(nPregunta)
		var nBotones = this.aNBotones[nPregunta]
		var aBotones = new Array(nBotones)
		for (var nBoton = 0; nBoton < nBotones; ++nBoton) {
			aBotones[nBoton] = document.getElementById('R'+n+String.fromCharCode(97+nBoton))
		}
		if (!f.call(this, nPregunta, aBotones)) return false
	}
	return true
}

TestQCHAT.prototype.submit = function() {
	if (debug() && !this.verifica()) return CONSERVA
	if (!this.completo()) return CONSERVA

	function valor(aBotones) {
		for (var nBoton = 0; nBoton < aBotones.length; ++nBoton) {
			if (aBotones[nBoton].checked) {
				return Number(aBotones[nBoton].value)
			}
		}
		return 0
	}

	var nAcumulador = 0
	function evalua(nPregunta, aBotones) {
		nAcumulador += valor(aBotones)
		return true
	}
	this.itera(evalua)
	this.muestraTotal([this.sCoeficiente], [String(nAcumulador)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
