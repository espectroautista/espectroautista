// Evaluador del test GADS
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestGADS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "ab"
}
TestGADS.prototype = new Test

TestGADS.prototype.verifica = function() {
	function p(v0, v1) {
		return (v0 === 1 && v1 === 0)
	}
	return Test.prototype.verifica.call(this, p, 18)
			&& cierto(this.nTotal === 18, "expected 18 questions")
}

TestGADS.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// requisitos 4/5
	var nPregunta, nS1_4 = 0, nS2_4 = 0, nS1_5 = 0, nS2_5 = 0
	for (nPregunta = 1;  nPregunta < 5;   ++nPregunta) { nS1_4 += this.evalua(nPregunta) }
	for (nPregunta = 5;  nPregunta < 10;  ++nPregunta) { nS1_5 += this.evalua(nPregunta) }
	if (nS1_4 < 2 && nS1_5 !== 0) {
		alert(this.aMensajes["gadsM1"])
		return CONSERVA
	}
	for (nPregunta = 10;  nPregunta < 14; ++nPregunta) { nS2_4 += this.evalua(nPregunta) }
	for (nPregunta = 14;  nPregunta < 19; ++nPregunta) { nS2_5 += this.evalua(nPregunta) }
	if (nS2_4 === 0 && nS2_5 !== 0) {
		alert(this.aMensajes["gadsM2"])
		return CONSERVA
	}
	// subescalas
	var nS1 = nS1_4 + nS1_5, nS2 = nS2_4 + nS2_5
	//
	if (debug() && (nS1+nS2 !== nCoeficiente)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["gadsS1"], this.aMensajes["gadsS2"]],
			[String(nS1), String(nS2)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
