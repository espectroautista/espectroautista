// Evaluador del test CAST
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestCAST(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "ab"
}
TestCAST.prototype = new Test

TestCAST.prototype.controla = function(aPreguntasControl) {
	function c(nPregunta, aBotones) {
		if (member(nPregunta, aPreguntasControl)) {
			aBotones = map(aBotones, function (oRadio) { return Number(oRadio.value)})
			cierto(sum(aBotones) === 0, "bad control question: " + String(nPregunta))
		}
		return true
	}
	this.itera(c)
}

TestCAST.prototype.verifica = function() {
	this.controla([3,4,12,22,26,33])
	function p(v0, v1) {
		return ((v0 === 0 && v1 === 1) ||
				(v0 === 1 && v1 === 0) ||
				(v0 === 0 && v1 === 0))
	}
	return Test.prototype.verifica.call(this, p, 31)
			&& cierto(this.nTotal === 37, "expected 37 questions")
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
