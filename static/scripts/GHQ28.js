// Evaluador del test GHQ28
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestGHQ28(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcd"
}
TestGHQ28.prototype = new Test

TestGHQ28.prototype.verifica = function() {
	this.rellena()
	function p(v1, v2, v3, v4) {
		return (v1 === 0 && v2 === 0 && v3 === 1 && v4 === 1)
	}
	return Test.prototype.verifica.call(this, p, (1+1)*this.nTotal)
			&& cierto(this.nTotal === 28, "expected 28 questions")
}

TestGHQ28.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// subescalas
	var nPregunta, nS1 = 0, nS2 = 0, nS3 = 0, nS4 = 0
	for (nPregunta = 1;  nPregunta < 8;  ++nPregunta) { nS1 += this.evalua(nPregunta) }
	for (nPregunta = 8;  nPregunta < 15; ++nPregunta) { nS2 += this.evalua(nPregunta) }
	for (nPregunta = 15; nPregunta < 22; ++nPregunta) { nS3 += this.evalua(nPregunta) }
	for (nPregunta = 22; nPregunta < 29; ++nPregunta) { nS4 += this.evalua(nPregunta) }
	//
	if (debug() && (nS1+nS2+nS3+nS4 !== nCoeficiente)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["ghq28S1"], this.aMensajes["ghq28S2"],
			 this.aMensajes["ghq28S3"], this.aMensajes["ghq28S4"]],
			[String(nS1), String(nS2), String(nS3), String(nS4)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
