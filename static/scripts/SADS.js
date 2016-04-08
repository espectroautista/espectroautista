// Evaluador del test SADS
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestSADS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "ab"
}
TestSADS.prototype = new Test

TestSADS.prototype.verifica = function() {
	function p(v0, v1) {
		return ((v0 === 0 && v1 === 1) || (v0 === 1 && v1 === 0))
	}
	return Test.prototype.verifica.call(this, p, 28)
			&& cierto(this.nTotal === 28, "expected 28 questions")
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
