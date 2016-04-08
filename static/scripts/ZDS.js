// Evaluador del tests ZDS
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestZDS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcd"
}
TestZDS.prototype = new Test

TestZDS.prototype.verifica = function() {
	function p(v1, v2, v3, v4) {
		return ((v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4) ||
			(v1 === 4 && v2 === 3 && v3 === 2 && v4 === 1))
	}
	return Test.prototype.verifica.call(this, p, 20*(1+2+3+4))
			&& cierto(this.nTotal === 20, 'expected 20 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
