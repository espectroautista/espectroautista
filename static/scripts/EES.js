// Evaluador del test EES
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestEES(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.bDesdeCero  = false
	this.aAscendentes = [1,5,6,8,13,14]
	this.sLetras = "abcdef"
}
TestEES.prototype = new Test

TestEES.prototype.verifica = function() {
	function v(nPregunta, aBotones) {
		this.verificaOrden(nPregunta, aBotones)
		return true
	}
	this.itera(v)
	function p(v1, v2, v3, v4, v5, v6) {
		return ((v1 === 1 && v2 === 2 && v3 === 3 &&
				 v4 === 4 && v5 === 5 && v6 === 6) ||
				(v1 === 6 && v2 === 5 && v3 === 4 &&
				 v4 === 3 && v5 === 2 && v6 === 1))
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5+6)*this.nTotal)
			&& cierto(this.nTotal === 17, 'expected 17 questions')
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
