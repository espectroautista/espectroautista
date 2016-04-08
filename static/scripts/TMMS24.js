// Evaluador del test TMMS24
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestTMMS24(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcde"
}
TestTMMS24.prototype = new Test

TestTMMS24.prototype.verifica = function() {
	function p(v1, v2, v3, v4, v5) {
		return (v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4 || v5 === 5)
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5)*this.nTotal)
			&& cierto(this.nTotal === 24, "expected 24 questions")
}

TestTMMS24.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// subescalas
	var nPregunta, nS1 = 0, nS2 = 0, nS3 = 0
	for (nPregunta = 1;  nPregunta < 9;  ++nPregunta) { nS1 += this.evalua(nPregunta) }
	for (nPregunta = 9;  nPregunta < 17; ++nPregunta) { nS2 += this.evalua(nPregunta) }
	for (nPregunta = 17; nPregunta < 25; ++nPregunta) { nS3 += this.evalua(nPregunta) }
	//
	if (debug() && (nS1+nS2+nS3 !== nCoeficiente)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["tmmsS1"], this.aMensajes["tmmsS2"], this.aMensajes["tmmsS3"]],
			[String(nS1), String(nS2), String(nS3)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
