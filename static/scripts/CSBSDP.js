// Evaluador del test CSBSDP
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestCSBSDP(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.aNBotones = [undefined,	// used in place of sLetras
		3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,5,5,3,3,5,3,5,4,3
	]
}
TestCSBSDP.prototype = new Test

TestCSBSDP.prototype.verifica = function() {
	this.rellena()
	return cierto(this.nTotal === 24, 'expected 24 questions')
}

TestCSBSDP.prototype.itera = function(f) {
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

function valor(aBotones) {
	for (var nBoton = 0; nBoton < aBotones.length; ++nBoton) {
		if (aBotones[nBoton].checked) {
			return Number(aBotones[nBoton].value)
		}
	}
	return 0
}

TestCSBSDP.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// subescalas
	var nPregunta, nS1 = 0, nS2 = 0, nS3 = 0, nS4 = 0, nS5 = 0, nS6 = 0, nS7 = 0
	function evalua(nPregunta, aBotones) {
		if (1 <= nPregunta && nPregunta <= 4) {
			nS1 += valor(aBotones)
		} else if (5 <= nPregunta && nPregunta <= 8) {
			nS2 += valor(aBotones)
		} else if (9 <= nPregunta && nPregunta <= 13) {
			nS3 += valor(aBotones)
		} else if (14 <= nPregunta && nPregunta <= 16) {
			nS4 += valor(aBotones)
		} else if (17 <= nPregunta && nPregunta <= 18) {
			nS5 += valor(aBotones)
		} else if (19 <= nPregunta && nPregunta <= 20) {
			nS6 += valor(aBotones)
		} else if (21 <= nPregunta && nPregunta <= 24) {
			nS7 += valor(aBotones)
		} else {
			return false
		}
		return true
	}
	this.itera(evalua)
	if (debug() && (nS1+nS2+nS3+nS4+nS5+nS6+nS7 !== nCoeficiente)) alert('ERROR: subscales error')
	//
	this.muestraTotal([
			this.aMensajes["csbsdpS1"], this.aMensajes["csbsdpS2"], this.aMensajes["csbsdpS3"], this.aMensajes["csbsdpT1"],
			this.aMensajes["csbsdpS4"], this.aMensajes["csbsdpS5"], this.aMensajes["csbsdpT2"],
			this.aMensajes["csbsdpS6"], this.aMensajes["csbsdpS7"], this.aMensajes["csbsdpT3"], this.aMensajes["coeficiente"]],
			[String(nS1), String(nS2), String(nS3), String(nS1+nS2+nS3),
			 String(nS4), String(nS5), String(nS4+nS5),
			 String(nS6), String(nS7), String(nS6+nS7), String(nCoeficiente)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
