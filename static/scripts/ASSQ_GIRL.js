// Evaluador del test ASSQ_GIRL
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestASSQ_GIRL(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abc"
}
TestASSQ_GIRL.prototype = new Test

TestASSQ_GIRL.prototype.verifica = function() {
	function p(v0, v1, v2) {
		return (v0 === 0 && v1 === 1 && v2 === 2)
	}
	return Test.prototype.verifica.call(this, p, (0+1+2)*this.nTotal)
			&& cierto(this.nTotal === 18, "expected 18 questions")
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
