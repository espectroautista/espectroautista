// Evaluador del test GAD7
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestGAD7(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcd"
}
TestGAD7.prototype = new Test

TestGAD7.prototype.verifica = function() {
	function p(v1, v2, v3, v4) {
		return (v1 === 0 && v2 === 1 && v3 === 2 && v4 === 3)
	}
	return Test.prototype.verifica.call(this, p, (0+1+2+3)*this.nTotal)
			&& cierto(this.nTotal === 7, "expected 7 questions")
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
