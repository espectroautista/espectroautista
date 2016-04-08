// Evaluador del test SQ
//
// require AQ.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestSQR(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	TestAQ.call(this, sId, nTotal, dMensajes)
}
TestSQR.prototype = new TestAQ

TestSQR.prototype.verifica = function() {
	function p(v1, v2, v3, v4) {
		return ((v1 === 0 && v2 === 0 && v3 === 1 && v4 === 2) ||
				(v1 === 2 && v2 === 1 && v3 === 0 && v4 === 0))
	}
	return Test.prototype.verifica.call(this, p, 150+75)
			&& cierto(this.nTotal === 75, 'expected 75 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
