// Evaluador del test AAA
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestAAA(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "ab"
}
TestAAA.prototype = new Test

TestAAA.prototype.verifica = function() {
	function p(v0, v1) {
		return (v0 === 1 && v1 === 0)
	}
	return Test.prototype.verifica.call(this, p, 23)
			&& cierto(this.nTotal === 23, "expected 23 questions")
}

TestAAA.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// subescalas
	var nPregunta, nSA = 0, nSB = 0, nSC = 0, nSD = 0, nSE = 0
	for (nPregunta = 1;  nPregunta < 6;  ++nPregunta) { nSA += this.evalua(nPregunta) }
	for (nPregunta = 6;  nPregunta < 11; ++nPregunta) { nSB += this.evalua(nPregunta) }
	for (nPregunta = 11; nPregunta < 16; ++nPregunta) { nSC += this.evalua(nPregunta) }
	for (nPregunta = 16; nPregunta < 19; ++nPregunta) { nSD += this.evalua(nPregunta) }
	for (nPregunta = 19; nPregunta < 24; ++nPregunta) { nSE += this.evalua(nPregunta) }
	//
	if (debug() && (nSA+nSB+nSC+nSD+nSE !== nCoeficiente)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["aaaSA"], this.aMensajes["aaaSB"], this.aMensajes["aaaSC"],
			 this.aMensajes["aaaSD"], this.aMensajes["aaaSE"]],
			[String(nSA), String(nSB), String(nSC), String(nSD), String(nSE)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
