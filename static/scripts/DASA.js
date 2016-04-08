// Evaluador del test DASA
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestDASA(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcde"
}
TestDASA.prototype = new Test

TestDASA.prototype.verifica = function() {
	function p(v1, v2, v3, v4, v5) {
		return (v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4 && v5 === 5) ||
			(v1 === 0 && v2 === 0 && v3 === 0 && v4 === 0 && v5 === 0)
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5)*(this.nTotal-5))
			&& cierto(this.nTotal === 26, 'expected 26 questions')
}

TestDASA.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	var nGlobal = nCoeficiente
	// subescalas
	var nPregunta, aPreguntas, nS1 = 0, nS2 = 0, nS3 = 0
	aPreguntas = [2,3,6,8,14,17,20,22,23,26]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS1 += this.evalua(aPreguntas[nPregunta])
	}
	aPreguntas = [1,7,9,10,13,19,24]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS2 += this.evalua(aPreguntas[nPregunta])
	}
	aPreguntas = [4,12,16,21]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS3 += this.evalua(aPreguntas[nPregunta])
	}
	//
	if (debug() && (nS1+nS2+nS3 !== nGlobal)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["dasaDASA"],
				this.aMensajes["dasaFNED"],
				this.aMensajes["dasaSDD"],
				this.aMensajes["dasaSDG"]],
			[String(nGlobal),
				String(nS1),
				String(nS2),
				String(nS3)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
