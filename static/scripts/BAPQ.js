// Evaluador del test BAPQ
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestBAPQ(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcdef"
}
TestBAPQ.prototype = new Test

TestBAPQ.prototype.verifica = function() {
	function p(v1, v2, v3, v4, v5, v6) {
		return	(v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4 && v5 === 5 && v6 === 6) ||
				(v1 === 6 && v2 === 5 && v3 === 4 && v4 === 3 && v5 === 2 && v6 === 1)
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5+6)*this.nTotal)
			&& cierto(this.nTotal === 36, "expected 36 questions")
}

TestBAPQ.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// subescalas
	var nPregunta, aPreguntas, nS1 = 0, nS2 = 0, nS3 = 0
	// A: Aloof
	aPreguntas = [1, 5, 9, 12, 16, 18, 23, 25, 27, 28, 31, 36]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS1 += this.evalua(aPreguntas[nPregunta])
	}
	// P: Pragmatic language
	aPreguntas = [2, 4, 7, 10, 11, 14, 17, 20, 21, 29, 32, 34]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS2 += this.evalua(aPreguntas[nPregunta])
	}
	// R: Rigid
	aPreguntas = [3, 6, 8, 13, 15, 19, 22, 24, 26, 30, 33, 35]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS3 += this.evalua(aPreguntas[nPregunta])
	}
	//
	if (debug() && (nS1+nS2+nS3 !== nCoeficiente)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["bapqS1"],
			 this.aMensajes["bapqS2"],
			 this.aMensajes["bapqS3"],
			 this.aMensajes["bapqTotal"]],
			[String(round(nS1/12, 2)),
			 String(round(nS2/12, 2)),
			 String(round(nS3/12, 2)),
			 String(round(nCoeficiente/36, 2))])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
