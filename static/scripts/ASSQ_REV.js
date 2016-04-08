// Evaluador del test ASSQ_REV
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestASSQ_REV(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abc"
}
TestASSQ_REV.prototype = new Test

TestASSQ_REV.prototype.verifica = function() {
	function p(v0, v1, v2) {
		return (v0 === 0 && v1 === 1 && v2 === 2)
	}
	return Test.prototype.verifica.call(this, p, (0+1+2)*this.nTotal)
			&& cierto(this.nTotal === 45, "expected 45 questions")
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
