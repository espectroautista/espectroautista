// Evaluador del test CHAT
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestCHAT(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "ab"
}
TestCHAT.prototype = new Test

TestCHAT.prototype.verifica = function() {
	function p(v0, v1) {
		return (v0 === 0 && v1 === 1)
	}
	return Test.prototype.verifica.call(this, p, 14)
			&& cierto(this.nTotal === 14, "expected 14 questions")
}


TestCHAT.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	// subescalas
	var nPregunta, aPreguntas, nS1 = 0, nS2 = 0
	aPreguntas = [5,7,11,12,13]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS1 += this.evalua(aPreguntas[nPregunta])
	}
	aPreguntas = [7,13]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS2 += this.evalua(aPreguntas[nPregunta])
	}
	//
	var sMsg
	if (nS1 === 5) {
		sMsg = this.aMensajes["chat1"]
	} else if (nS2 === 2) {
		sMsg = this.aMensajes["chat2"]
	} else {
		sMsg = this.aMensajes["chat3"]
	}

	this.muestraTotal(
			[this.aMensajes["chat0"]],
			[ sMsg ])
	return CONSERVA
}
// vim:sw=4:ts=4:ai:fileencoding=utf8
