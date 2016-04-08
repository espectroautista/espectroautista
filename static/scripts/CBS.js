// Evaluador del test CBS
//
////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestCBS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcd"
}
TestCBS.prototype = new Test

TestCBS.prototype.verifica = function() {
	function p(v1, v2, v3, v4) {
		return ((v1 === 2 && v2 === 1 && v3 === 0 && v4 === 0) ||
				(v1 === 0 && v2 === 0 && v3 === 1 && v4 === 2))
	}
	return Test.prototype.verifica.call(this, p, 40*(1+2))
			&& cierto(this.nTotal === 40, 'expected 40 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
