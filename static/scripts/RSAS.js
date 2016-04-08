// Evaluador del test RSAS
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestRSAS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "ab"
}
TestRSAS.prototype = new Test

TestRSAS.prototype.verifica = function() {
	function p(v0, v1) {
		return ((v0 === 0 && v1 === 1) || (v0 === 1 && v1 === 0))
	}
	return Test.prototype.verifica.call(this, p, 40)
			&& cierto(this.nTotal === 40, "expected 40 questions")
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
