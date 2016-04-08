// Evaluador del test ASAS
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestASAS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcdefg"
}
TestASAS.prototype = new Test

TestASAS.prototype.verifica = function() {
	function p(v0, v1, v2, v3, v4, v5, v6) {
		return (v0 === 0 && v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4 && v5 === 5 && v6 === 6)
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5+6)*this.nTotal)
			&& cierto(this.nTotal === 24, 'expected 24 questions')
}

TestASAS.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente !== -1) {
		nCoeficiente /= this.nTotal
		this.muestraTotal([this.sCoeficiente], [String(round(nCoeficiente, 2))])
	}
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
