// Evaluador del test RSES
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestRSES(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.bDesdeCero  = false
	this.aAscendentes = [2,5,6,8,9]
	this.sLetras = "abcd"
}
TestRSES.prototype = new Test

TestRSES.prototype.verifica = function() {
	function v(nPregunta, aBotones) {
		this.verificaOrden(nPregunta, aBotones)
		return true
	}
	this.itera(v)
	function p(v1, v2, v3, v4) {
		return ((v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4) ||
				(v1 === 4 && v2 === 3 && v3 === 2 && v4 === 1))
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4)*this.nTotal)
			&& cierto(this.nTotal === 10, 'expected 10 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
