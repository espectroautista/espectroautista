// Evaluador del test ULS
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestULS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcd"
}
TestULS.prototype = new Test

TestULS.prototype.verifica = function() {
	function p(v1, v2, v3, v4) {
		return (v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4)
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4)*this.nTotal)
			&& cierto(this.nTotal === 10, 'expected 10 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
