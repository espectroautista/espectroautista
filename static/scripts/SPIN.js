// Evaluador del test SPIN
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestSPIN(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcde"
}
TestSPIN.prototype = new Test

TestSPIN.prototype.verifica = function() {
	function p(v1, v2, v3, v4, v5) {
		return (v1 === 0 && v2 === 1 && v3 === 2 && v4 === 3 && v5 === 4)
	}
	return Test.prototype.verifica.call(this, p, (0+1+2+3+4)*this.nTotal)
			&& cierto(this.nTotal === 17, "expected 17 questions")
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
