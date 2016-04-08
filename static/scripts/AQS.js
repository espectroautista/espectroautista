// Evaluador del tests AQS
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestAQS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcd"
}
TestAQS.prototype = new Test

TestAQS.prototype.verifica = function() {
	function p(v1, v2, v3, v4) {
		return ((v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4) ||
				(v1 === 4 && v2 === 3 && v3 === 2 && v4 === 1))
	}
	return Test.prototype.verifica.call(this, p, 28*(1+2+3+4))
			&& cierto(this.nTotal === 28, 'expected 28 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
