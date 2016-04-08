// Evaluador del test LIPT60
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestLIPT60(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "abcde"
}
TestLIPT60.prototype = new Test

TestLIPT60.prototype.verifica = function() {
	function p(v0, v1, v2, v3, v4) {
		return	(v0 === 0 && v1 === 1 && v2 === 2 && v3 === 3 && v4 === 4)
	}
	return Test.prototype.verifica.call(this, p, (0+1+2+3+4)*this.nTotal)
			&& cierto(this.nTotal === 60, "expected 60 questions")
}

TestLIPT60.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// subescalas
	var nPregunta, nNEAT = 0
	// NEAT
	for (nPregunta = 1; nPregunta <= 60; ++nPregunta) {
		var n = this.evalua(nPregunta)
		if (n > 0) nNEAT += 1
	}
	// IGAP
	var nIGAP = nCoeficiente / 60
	// IMAP
	var nIMAP = nCoeficiente / (nNEAT === 0 ? 1 : nNEAT)
	//
	this.muestraTotal(
			[this.aMensajes["liptNEAP"],
			 this.aMensajes["liptIGAP"],
			 this.aMensajes["liptIMAP"]],
			[String(round(nNEAT, 2)),
			 String(round(nIGAP, 2)),
			 String(round(nIMAP, 2))])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
