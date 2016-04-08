// Evaluador del test PANAS
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestPANAS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcde"
}
TestPANAS.prototype = new Test

TestPANAS.prototype.verifica = function() {
	function p(v1, v2, v3, v4, v5) {
		return (v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4 || v5 === 5)
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5)*this.nTotal)
			&& cierto(this.nTotal === 20, "expected 20 questions")
}

TestPANAS.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// subescalas
	var nPregunta, aPreguntas, nPos = 0, nNeg = 0
	aPreguntas = [1,3,5,9,10,12,14,16,17,19]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nPos += this.evalua(aPreguntas[nPregunta])
	}
	aPreguntas = [2,4,6,7,8,11,13,15,18,20]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nNeg += this.evalua(aPreguntas[nPregunta])
	}
	//
	if (debug() && (nPos+nNeg !== nCoeficiente)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["panasP"], this.aMensajes["panasN"]],
			[String(nPos), String(nNeg)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
