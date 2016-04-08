// Evaluador del test SOC3
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestSOC3(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.bDesdeCero  = false
	this.aAscendentes = [1,4,10,13,22,5,11,14,20,29,3,6,15,18,30]
	this.sLetras = "abcdefg"
}
TestSOC3.prototype = new Test

TestSOC3.prototype.verifica = function() {
	function v(nPregunta, aBotones) {
		this.verificaOrden(nPregunta, aBotones)
		return true
	}
	this.itera(v)
	function p(v1, v2, v3, v4, v5, v6, v7) {
		return ((v1 === 1 && v2 === 2 && v3 === 3 &&
				 v4 === 4 && v5 === 5 && v6 === 6 && v7 === 7) ||
				(v1 === 7 && v2 === 6 && v3 === 5 &&
				 v4 === 4 && v5 === 3 && v6 === 2 && v7 === 1))
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5+6+7)*this.nTotal)
			&& cierto(this.nTotal === 30, 'expected 30 questions')
}

TestSOC3.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	var nGlobal = nCoeficiente
	// subescalas
	var nPregunta, aPreguntas, nS1 = 0, nS2 = 0, nS3 = 0
	aPreguntas = [1,4,7,10,13,16,19,22,25,28]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS1 += this.evalua(aPreguntas[nPregunta])
	}
	aPreguntas = [2,5,8,11,14,17,20,23,26,29]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS2 += this.evalua(aPreguntas[nPregunta])
	}
	aPreguntas = [3,6,9,12,15,18,21,24,27,30]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS3 += this.evalua(aPreguntas[nPregunta])
	}
	//
	if (debug() && (nS1+nS2+nS3 !== nGlobal)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[ this.aMensajes["socPC"], this.aMensajes["socIPC"], this.aMensajes["socSPC"]],
			[ String(nS1), String(nS2), String(nS3)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
