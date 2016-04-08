// Evaluador del tests AQC
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestAQC(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcd"
}
TestAQC.prototype = new Test

TestAQC.prototype.verifica = function() {
	function p(v1, v2, v3, v4) {
		return ((v1 === 0 && v2 === 1 && v3 === 2 && v4 === 3) ||
				(v1 === 3 && v2 === 2 && v3 === 1 && v4 === 0))
	}
	return Test.prototype.verifica.call(this, p, 50*(0+1+2+3))
			&& cierto(this.nTotal === 50, 'expected 50 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
