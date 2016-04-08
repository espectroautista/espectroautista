// Evaluador del test TAS20
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestTAS20(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.bDesdeCero   = false
	this.aAscendentes = [4,5,10,18,19]
	this.sLetras = "abcde"
}
TestTAS20.prototype = new Test

TestTAS20.prototype.verifica = function() {
	function v(nPregunta, aBotones) {
		this.verificaOrden(nPregunta, aBotones)
		return true
	}
	this.itera(v)
	function p(v1, v2, v3, v4, v5) {
		// redundant with v(), but ok.
		return ((v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4 || v5 === 5) ||
			    (v1 === 5 || v2 === 4 && v3 === 3 && v4 === 2 && v5 === 1))
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5)*this.nTotal)
			&& cierto(this.nTotal === 20, "expected 20 questions")
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
