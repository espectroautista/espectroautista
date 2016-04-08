// Evaluador del test SWLS
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestSWLS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcdefg"
}
TestSWLS.prototype = new Test

TestSWLS.prototype.verifica = function() {
	function p(v0, v1, v2, v3, v4, v5, v6) {
		return (v0 === 1 && v1 === 2 && v2 === 3 && v3 === 4 &&
				v4 === 5 && v5 === 6 && v6 === 7 )
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5+6+7)*this.nTotal)
			&& cierto(this.nTotal === 5, 'expected 5 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
