// Evaluador del test BEQ
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestBEQ(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.bDesdeCero  = false
	this.aAscendentes = [1,2,4,5,6,7,10,11,12,13,14,15,16]
	this.sLetras = "abcdefg"
}
TestBEQ.prototype = new Test

TestBEQ.prototype.verifica = function() {
	function v(nPregunta, aBotones) {
		this.verificaOrden(nPregunta, aBotones)
		return true
	}
	this.itera(v)
	function p(v1, v2, v3, v4, v5, v6, v7) {
		return ((v1 === 1 && v2 === 2 && v3 === 3 &&
				 v4 === 4 && v5 === 5 && v6 === 6 && v7 === 7) ||
				(v1 === 7 && v2 === 6 && v3 === 5 &&
				 v4 === 4 && v5 === 3 && v6 === 2 && v7 === 1))
	}
	return Test.prototype.verifica.call(this, p, (1+2+3+4+5+6+7)*this.nTotal)
			&& cierto(this.nTotal === 16, 'expected 16 questions')
}

TestBEQ.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	var nGlobal = nCoeficiente
	// subescalas
	var nPregunta, aPreguntas, nS1 = 0, nS2 = 0, nS3 = 0
	aPreguntas = [9,13,16,3,5,8]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS1 += this.evalua(aPreguntas[nPregunta])
	}
	aPreguntas = [6,1,4,10]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS2 += this.evalua(aPreguntas[nPregunta])
	}
	aPreguntas = [15,11,14,7,2,12]
	for (nPregunta = 0; nPregunta < aPreguntas.length; ++nPregunta) {
		nS3 += this.evalua(aPreguntas[nPregunta])
	}
	//
	if (debug() && (nS1+nS2+nS3 !== nGlobal)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["beqGlobal"],
				this.aMensajes["beqS1"],
				this.aMensajes["beqS2"],
				this.aMensajes["beqS3"]],
			[String(round(nGlobal / 16, 2)),
				String(round(nS1 / 6, 2)),
				String(round(nS2 / 4, 2)),
				String(round(nS3 / 6, 2))])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
