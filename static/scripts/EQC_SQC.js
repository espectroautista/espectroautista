// Evaluador del test EQC_SQC
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestEQC_SQC(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcd"
}
TestEQC_SQC.prototype = new Test

TestEQC_SQC.prototype.verifica = function() {
	function p(v1, v2, v3, v4, v5) {
		return (v1 === 0 && v2 === 0 && v3 === 1 && v4 === 2) ||
			   (v1 === 2 && v2 === 1 && v3 === 0 && v4 === 0)
	}
	return Test.prototype.verifica.call(this, p, (0+0+1+2)*this.nTotal)
			&& cierto(this.nTotal === 55, "expected 55 questions")
}

TestEQC_SQC.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// subescalas (EQC, SQC)
	var nPregunta, nEQC = 0, nSQC = 0, aPreguntas
	aPreguntas = [1,6,14,18,26,28,30,31,37,42,43,45,48,52,2,4,7,9,13,17,20,23,33,36,40,53,55]
	for (nPregunta = 0;  nPregunta < aPreguntas.length; ++nPregunta) {
		nEQC += this.evalua(aPreguntas[nPregunta])
	}
	aPreguntas = [5,8,10,12,19,21,24,25,29,34,35,38,39,41,44,46,49,50,3,11,15,16,22,27,32,47,51,54]
	for (nPregunta = 0;  nPregunta < aPreguntas.length; ++nPregunta) {
		nSQC += this.evalua(aPreguntas[nPregunta])
	}
	//
	if (debug() && (nEQC > 54)) alert('ERROR: subscale EQC error')
	if (debug() && (nSQC > 56)) alert('ERROR: subscale SQC error')
	if (debug() && (nEQC+nSQC !== nCoeficiente)) alert('ERROR: subscales error')
	//
	var nE = (nEQC - 37.7) / 54
	var nS = (nSQC - 24.11) / 56
	var sD, nD = (nS - nE) / 2
	if (nD < -0.205) {
		sD = this.aMensajes["eqcsqcS5"]
	} else if (-0.205 <= nD && nD < -0.050) {
		sD = this.aMensajes["eqcsqcS6"]
	} else if (-0.050 <= nD && nD < 0.037) {
		sD = this.aMensajes["eqcsqcS7"]
	} else if (0.037 <= nD && nD < 0.260) {
		sD = this.aMensajes["eqcsqcS8"]
	} else if (nD >= 0.260) {
		sD = this.aMensajes["eqcsqcS9"]
	}

	//
	this.muestraTotal(
			[this.aMensajes["eqcsqcS1"], this.aMensajes["eqcsqcS2"], this.aMensajes["eqcsqcS4"]],
			[String(nEQC), String(nSQC), sD])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
