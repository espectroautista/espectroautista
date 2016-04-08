// Evaluador del test ASDI
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestASDI(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "ab"
}
TestASDI.prototype = new Test

TestASDI.prototype.verifica = function() {
	function p(v0, v1) {
		return (v0 === 0 && v1 === 1)
	}
	return Test.prototype.verifica.call(this, p, 20)
			&& cierto(this.nTotal === 20, "expected 20 questions")
}

TestASDI.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// areas
	var nPregunta, nA1 = 0, nA2 = 0, nA3 = 0, nA4 = 0, nA5 = 0, nA6 = 0
	for (nPregunta = 1;  nPregunta < 5;  ++nPregunta) { nA1 += this.evalua(nPregunta) }
	for (nPregunta = 5;  nPregunta < 8;  ++nPregunta) { nA2 += this.evalua(nPregunta) }
	for (nPregunta = 8;  nPregunta < 10; ++nPregunta) { nA3 += this.evalua(nPregunta) }
	for (nPregunta = 10; nPregunta < 15; ++nPregunta) { nA4 += this.evalua(nPregunta) }
	for (nPregunta = 15; nPregunta < 20; ++nPregunta) { nA5 += this.evalua(nPregunta) }
	nA6 += this.evalua(20)
	//
	if (debug() && (nA1+nA2+nA3+nA4+nA5+nA6 !== nCoeficiente))
		alert('ERROR: subscales error')
	//
	sCriterio = this.aMensajes["asdiCriterio"]
	function criterio(nPuntuacion, nNecesarias) {
		if (nPuntuacion >= nNecesarias)
			return sCriterio
		else
			return "-----------"
	}
	this.muestraTotal(
			[this.aMensajes["asdiA1"],
			 this.aMensajes["asdiA2"],
			 this.aMensajes["asdiA3"],
			 this.aMensajes["asdiA4"],
			 this.aMensajes["asdiA5"],
			 this.aMensajes["asdiA6"]],
			[criterio(nA1, 2), criterio(nA2, 1), criterio(nA3, 1),
			 criterio(nA4, 3), criterio(nA5, 1), criterio(nA6, 1)])
	return CONSERVA
}
// vim:sw=4:ts=4:ai:fileencoding=utf8
