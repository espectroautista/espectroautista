// Evaluador del test IDEA
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestIDEA(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcde"
}
TestIDEA.prototype = new Test

TestIDEA.prototype.verifica = function() {
	this.rellena()
	function p(v1, v2, v3, v4, v5) {
		return (v1 === 8 && v2 === 6 && v3 === 4 && v4 === 2 && v5 === 0)
	}
	return Test.prototype.verifica.call(this, p, (0+2+4+6+8)*this.nTotal)
			&& cierto(this.nTotal === 12, "expected 12 questions")
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
