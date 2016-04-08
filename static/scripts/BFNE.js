
// Evaluador del test BFNE
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestBFNE(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcde"
}
TestBFNE.prototype = new Test

TestBFNE.prototype.verifica = function() {
	function p(v1, v2, v3, v4, v5) {
		return (v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4 && v5 === 5) ||
			(v1 === 5 && v2 === 4 && v3 === 3 && v4 === 2 && v5 === 1)
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5)*(this.nTotal))
			&& cierto(this.nTotal === 12, 'expected 12 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
