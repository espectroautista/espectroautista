// Evaluador del test IRI
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestIRI(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcde"
}
TestIRI.prototype = new Test

TestIRI.prototype.verifica = function() {
	function p(v1, v2, v3, v4, v5) {
		return	(v1 === 0 && v2 === 1 && v3 === 2 && v4 === 3 && v5 === 4) ||
				(v1 === 4 && v2 === 3 && v3 === 2 && v4 === 1 && v5 === 0)
	}
	return Test.prototype.verifica.call(this, p, (0+1+2+3+4)*this.nTotal)
			&& cierto(this.nTotal === 28, "expected 28 questions")
}

TestIRI.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// subescalas
	var nPregunta, aPreguntas, nS1 = 0, nS2 = 0, nS3 = 0, nS4 = 0
	// PT
	aPreguntas = [3, 8, 11, 15, 21, 25, 28]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS1 += this.evalua(aPreguntas[nPregunta])
	}
	// FS
	aPreguntas = [1, 5, 7, 12, 16, 23, 26]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS2 += this.evalua(aPreguntas[nPregunta])
	}
	// EC
	aPreguntas = [2, 4, 9, 14, 18, 20, 22]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS3 += this.evalua(aPreguntas[nPregunta])
	}
	// PD
	aPreguntas = [6, 10, 13, 17, 19, 24, 27]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS4 += this.evalua(aPreguntas[nPregunta])
	}
	//
	if (debug() && (nS1+nS2+nS3+nS4 !== nCoeficiente)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["iriS1"],
			 this.aMensajes["iriS2"],
			 this.aMensajes["iriS3"],
			 this.aMensajes["iriS4"]],
			[String(nS1), String(nS2), String(nS3), String(nS4)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
