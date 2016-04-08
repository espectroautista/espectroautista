// Evaluador del test SASA
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestSASA(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcde"
}
TestSASA.prototype = new Test

TestSASA.prototype.verifica = function() {
	function p(v1, v2, v3, v4, v5) {
		return (v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4 && v5 === 5) ||
			(v1 === 0 && v2 === 0 && v3 === 0 && v4 === 0 && v5 === 0)
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5)*(this.nTotal-4))
			&& cierto(this.nTotal === 22, 'expected 22 questions')
}

TestSASA.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	var nGlobal = nCoeficiente
	// subescalas
	var nPregunta, aPreguntas, nS1 = 0, nS2 = 0, nS3 = 0
	aPreguntas = [3,6,8,9,12,14,17,18]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS1 += this.evalua(aPreguntas[nPregunta])
	}
	aPreguntas = [1,4,5,10,13,20]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS2 += this.evalua(aPreguntas[nPregunta])
	}
	aPreguntas = [15,19,21,22]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS3 += this.evalua(aPreguntas[nPregunta])
	}
	//
	if (debug() && (nS1+nS2+nS3 !== nGlobal)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["sasaSASA"],
				this.aMensajes["sasaFNE"],
				this.aMensajes["sasaSADN"],
				this.aMensajes["sasaSADG"]],
			[String(nGlobal),
				String(nS1),
				String(nS2),
				String(nS3)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
