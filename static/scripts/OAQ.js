// Evaluador del test OAQ
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestOAQ(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.bDesdeCero   = false
	this.aAscendentes = [3,7,8,23,32]
	this.sLetras = "abcde"
}
TestOAQ.prototype = new Test

TestOAQ.prototype.completo = function() {
	function c(nPregunta, aBotones) {
		if (!some(map(aBotones, function (oRadio) { return oRadio.checked }))) {
			aBotones[2].checked = true
		}
		return true
	}
	return this.itera(c)
}

TestOAQ.prototype.verifica = function() {
	function v(nPregunta, aBotones) {
		this.verificaOrden(nPregunta, aBotones)
		return true
	}
	this.itera(v)
	function p(v1, v2, v3, v4, v5) {
		// redundant with v(), but ok.
		return ((v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4 || v5 === 5) ||
			    (v1 === 5 && v2 === 4 && v3 === 3 && v4 === 2 || v5 === 1))
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5)*this.nTotal)
			&& cierto(this.nTotal === 37, "expected 37 questions")
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
