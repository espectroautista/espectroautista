// Evaluador del test OAS
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestOAS(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.bDesdeCero   = true
	this.aAscendentes = [11,12,13,14,15,16,19,20,21,22,23,27,28,29,30,31,32,33]
	this.sLetras = "abcd"
}
TestOAS.prototype = new Test

TestOAS.prototype.completo = function() {
	function c(nPregunta, aBotones) {
		if (!some(map(aBotones, function (oRadio) { return oRadio.checked }))) {
			aBotones[2].checked = true
		}
		return true
	}
	return this.itera(c)
}

TestOAS.prototype.verifica = function() {
	function v(nPregunta, aBotones) {
		this.verificaOrden(nPregunta, aBotones)
		return true
	}
	this.itera(v)
	function p(v1, v2, v3, v4) {
		// redundant with v(), but ok.
		return ((v1 === 0 && v2 === 1 && v3 === 2 && v4 === 3) ||
			    (v1 === 3 && v2 === 2 && v3 === 1 && v4 === 0 ))
	}
	return Test.prototype.verifica.call(this, p, (0+1+2+3)*this.nTotal)
			&& cierto(this.nTotal === 33, "expected 33 questions")
}

TestOAS.prototype.submit = function() {
	var nCoeficiente = this.totaliza()
	if (nCoeficiente === -1) return CONSERVA
	var nTotal = nCoeficiente
	// subescalas
	var nPregunta, nS1 = 0, nS2 = 0, nS3 = 0, nS4 = 0, nS5 = 0
	for (nPregunta = 1;  nPregunta < 11; ++nPregunta) { nS1 += this.evalua(nPregunta) }
	for (nPregunta = 11; nPregunta < 19; ++nPregunta) { nS2 += this.evalua(nPregunta) }
	for (nPregunta = 19; nPregunta < 24; ++nPregunta) { nS3 += this.evalua(nPregunta) }
	for (nPregunta = 24; nPregunta < 29; ++nPregunta) { nS4 += this.evalua(nPregunta) }
	for (nPregunta = 29; nPregunta < 34; ++nPregunta) { nS5 += this.evalua(nPregunta) }
	//
	if (debug() && (nS1+nS2+nS3+nS4+nS5 !== nTotal)) alert('ERROR: subscales error')
	//
	this.muestraTotal(
			[this.aMensajes["oasTotal"],
				this.aMensajes["oasS1"],
				this.aMensajes["oasS2"],
				this.aMensajes["oasS3"],
				this.aMensajes["oasS4"],
				this.aMensajes["oasS5"]],
			[String(nTotal), String(nS1), String(nS2), String(nS3), String(nS4), String(nS5)])
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
