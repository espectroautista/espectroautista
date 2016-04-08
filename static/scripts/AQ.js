// Evaluador del tests AQ
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestAQ(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcd"
}
TestAQ.prototype = new Test

TestAQA = TestAQ

TestAQ.prototype.verifica = function() {
	function p(v1, v2, v3, v4) {
		return ((v1 === 1 && v2 === 1 && v3 === 0 && v4 === 0) ||
				(v1 === 0 && v2 === 0 && v3 === 1 && v4 === 1))
	}
	return Test.prototype.verifica.call(this, p, 50*(1+1))
			&& cierto(this.nTotal === 50, 'expected 50 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
