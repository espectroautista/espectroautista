// Evaluador del test FNES
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestFNES(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "ab"
}
TestFNES.prototype = new Test

TestFNES.prototype.verifica = function() {
	function p(v0, v1) {
		return ((v0 === 0 && v1 === 1) || (v0 === 1 && v1 === 0))
	}
	return Test.prototype.verifica.call(this, p, 30)
			&& cierto(this.nTotal === 30, "expected 30 questions")
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
