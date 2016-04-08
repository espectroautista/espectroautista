// Evaluador del test Control
//
// require AQ.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestControl(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	TestAQ.call(this, sId, nTotal, dMensajes)
}
TestControl.prototype = new TestAQ

TestControl.prototype.controla = function(aPreguntasControl) {
	function c(nPregunta, aBotones) {
		if (member(nPregunta, aPreguntasControl)) {
			aBotones = map(aBotones, function (oRadio) { return Number(oRadio.value)})
			cierto(sum(aBotones) === 0, "bad control question: " + String(nPregunta))
		}
		return true
	}
	this.itera(c)
}

TestControl.prototype.verifica = function(aPreguntasControl) {
	this.controla(aPreguntasControl)
	function p(v1, v2, v3, v4) {
		return ((v1 === 0 && v2 === 0 && v3 === 1 && v4 === 2) ||
				(v1 === 2 && v2 === 1 && v3 === 0 && v4 === 0) ||
				(v1 === 0 && v2 === 0 && v3 === 0 && v4 === 0))
	}
	return Test.prototype.verifica.call(this, p, 80+40)
			&& cierto(this.nTotal === 60, 'expected 60 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
