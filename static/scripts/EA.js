// Evaluador del test EA
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestEA(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcde"
}
TestEA.prototype = new Test

TestEA.prototype.verifica = function() {
	function p(v1, v2, v3, v4, v5) {
		return (v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4 || v5 === 0)
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4)*this.nTotal)
			&& cierto(this.nTotal === 18, "expected 18 questions")
}

TestEA.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente !== -1) {
		var nPregunta, nObservadas = 0
		for (nPregunta = 1; nPregunta <= 18; ++nPregunta) {
			if (this.evalua(nPregunta) !== 0) {
				++nObservadas
			}
		}
		if (nObservadas === 0) {
			return CONSERVA
		} else if (nObservadas < 16) {
			this.muestraTotal(
					[this.aMensajes["eaD"], this.aMensajes["eaP"]],
					[this.aMensajes["eaN"], round(nCoeficiente / nObservadas, 2)])
		} else {
			this.muestraTotal(
					[this.aMensajes["eaD"], this.aMensajes["eaP"]],
					[String(nCoeficiente), round(nCoeficiente / nObservadas, 2)])
		}
	}
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
