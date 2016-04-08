// Evaluador del test ERQ
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestERQ(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcdefg"
}
TestERQ.prototype = new Test

TestERQ.prototype.verifica = function() {
	function p(v1, v2, v3, v4, v5, v6, v7) {
		return (v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4 &&
				v5 === 5 && v6 === 6 && v7 === 7)
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5+6+7)*this.nTotal)
			&& cierto(this.nTotal === 10, "expected 10 questions")
}

TestERQ.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// subescalas
	var nPregunta, nS1 = 0, nS2 = 0, aS1 = [1,3,5,7,8,10], aS2 = [2,4,6,9]
	for (nPregunta = 0; nPregunta < aS1.length; ++nPregunta) {
		nS1 += this.evalua(aS1[nPregunta])
	}
	for (nPregunta = 0; nPregunta < aS2.length; ++nPregunta) {
		nS2 += this.evalua(aS2[nPregunta])
	}
	//
	if (debug() && (nS1+nS2 !== nCoeficiente)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["erqS1"], this.aMensajes["erqS2"]],
			[String(round(nS1 / 6, 2)), String(round(nS2 / 4, 2))])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
