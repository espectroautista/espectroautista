// Evaluador del test FQ
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestFQ(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sPreguntaX = dMensajes["preguntaX"]
	this.aNBotones = [undefined,	// used in place of sLetras
		3,2,2,2,2,2,2,2,2,2,2,3,2,4,4,
		5,5,4,4,5,5,5,5,5,4,4,5,3,7,
		3,5,6,8,7,7
	]
}
TestFQ.prototype = new Test

function especial(nPregunta) {
	return member(nPregunta, [30,34,35])
}

function valor(aBotones) {
	for (var nBoton = 0; nBoton < aBotones.length; ++nBoton) {
		if (aBotones[nBoton].checked) {
			return Number(aBotones[nBoton].value)
		}
	}
	return 0
}

TestFQ.prototype.itera = function(f) {
	for (var nPregunta = 1; nPregunta <= this.nTotal; ++nPregunta) {
		var n = String(nPregunta)
		var nBotones = this.aNBotones[nPregunta]
		var aBotones = new Array(nBotones)
		if (especial(nPregunta)) {
			for (var nBoton = 0; nBoton < nBotones; ++nBoton) {
				var c = String.fromCharCode(97+nBoton)
				switch (nPregunta) {
					case 30:
						aBotones[nBoton] = [
							document.getElementById('R'+n+c+'0'),
							document.getElementById('R'+n+c+'1'),
							document.getElementById('R'+n+c+'2'),
							document.getElementById('R'+n+c+'3')
						]
						break
					default:
						aBotones[nBoton] = [
							document.getElementById('R'+n+c+'0'),
							document.getElementById('R'+n+c+'1'),
							document.getElementById('R'+n+c+'2'),
							document.getElementById('R'+n+c+'3'),
							document.getElementById('R'+n+c+'4'),
							document.getElementById('R'+n+c+'5'),
							document.getElementById('R'+n+c+'6'),
							document.getElementById('R'+n+c+'7')
						]
						break
				}
			}
		} else {
			for (var nBoton = 0; nBoton < nBotones; ++nBoton) {
				aBotones[nBoton] = document.getElementById('R'+n+String.fromCharCode(97+nBoton))
			}
		}
		if (!f.call(this, nPregunta, aBotones)) return false
	}
	return true
}

TestFQ.prototype.controla = function(aPreguntasControl) {
	function c(nPregunta, aBotones) {
		if (member(nPregunta, aPreguntasControl) && !member(nPregunta,[30,35])) {
			var aValores = map(aBotones, function (oRadio) { return Number(oRadio.value)})
			cierto(sum(aValores) === 0, "bad control question: " + String(nPregunta))
		}
		return true
	}
	this.itera(c)
}

TestFQ.prototype.rellena = function() {
	function r(nPregunta, aBotones) {
		if (especial(nPregunta)) {
			var aBotoneras = aBotones
			switch (nPregunta) {
				case 30:
					var aIndices = [1,2,3]
					break
				default:
					var aIndices = [1,2,3,4,5,6,7]
					break
			}
			shuffle(aIndices)
			for (var nBotonera = 0; nBotonera < aBotoneras.length; ++nBotonera) {
				aBotoneras[nBotonera][aIndices[nBotonera]].checked  = true
			}
		} else {
			choose(aBotones).checked = true
		}
		return true
	}
	this.itera(r)
}

Test.prototype.respuestaIncorrecta = function(nPregunta) {
	this.saltamos(nPregunta, this.sPreguntaX)
}

TestFQ.prototype.completo = function() {
	function c(nPregunta, aBotones) {
		if (especial(nPregunta)) {
			var aBotoneras = aBotones
			switch (nPregunta) {
				case 30:
					var aOpciones = [false,false,false]
					break
				default:
					var aOpciones = [false,false,false,false,false,false,false]
					break
			}
			for (var nBotonera = 0; nBotonera < aBotoneras.length; ++nBotonera) {
				aOpciones[valor(aBotoneras[nBotonera]) - 1] = true
			}
			if (every(aOpciones)) {
				return true
			} else {
				this.respuestaIncorrecta(nPregunta)
				return false
			}
		} else {
			if (!some(map(aBotones, function (oRadio) { return oRadio.checked }))) {
				this.faltaRespuesta(nPregunta)
				return false
			} else {
				return true
			}
		}
	}
	return this.itera(c)
}

TestFQ.prototype.verifica = function() {
	this.rellena()
	this.controla([8,11,17,19,21,24,30,35])
	return cierto(this.nTotal === 35, 'expected 35 questions')
}

TestFQ.prototype.submit = function() {
	if (debug() && !this.verifica()) return CONSERVA
	if (!this.completo()) return CONSERVA

	var nAcumulador = 0
	function evalua(nPregunta, aBotones) {
		if (especial(nPregunta)) {
			var aBotoneras = aBotones
			if (nPregunta === 34) {
				if (valor(aBotoneras[2]) === 1 || valor(aBotoneras[4]) === 1) {
					nAcumulador += 5
				}
			}
		} else {
			nAcumulador += valor(aBotones)
		}
		return true
	}
	this.itera(evalua)
	this.muestraTotal([this.sCoeficiente], [String(nAcumulador)])
	return CONSERVA
}

TestFQ.prototype.reset = function() {
	var resultado = CONSERVA
	function r(nPregunta, aBotones) {
		if (especial(nPregunta)) {
			var aBotoneras = aBotones
			for (var nBotonera = 0; nBotonera < aBotoneras.length; ++nBotonera) {
				if (some(map(aBotoneras[nBotonera], function (oRadio) { return oRadio.checked }))) {
					if (this.borramos()) resultado = BORRA
					return false
				}
			}
			return true
		} else {
			if (some(map(aBotones, function (oRadio) { return oRadio.checked }))) {
				if (this.borramos()) resultado = BORRA
				return false
			} else {
				return true
			}
		}
	}
	this.itera(r)
	return resultado
}

TestFQ.prototype.serializa = function() {
	function indice(aBotones) {
		for (var nBoton = 0; nBoton < aBotones.length; ++nBoton) {
			if (aBotones[nBoton].checked) {
				return nBoton
			}
		}
		return 0
	}

	var sAcumulador = ''
	function acumula(nPregunta, aBotones) {
		if (especial(nPregunta)) {
			var aBotoneras = aBotones
			for (var nBotonera = 0; nBotonera < aBotoneras.length; ++nBotonera) {
				sAcumulador += String.fromCharCode(65 + indice(aBotoneras[nBotonera]))
			}
		} else {
			sAcumulador += String.fromCharCode(65 + indice(aBotones))
		}
		return true
	}
	this.itera(acumula)
	return sAcumulador
}

Test.prototype.recupera = function(sSerie) {
	function r(nPregunta, aBotones) {
		n = nPregunta
		if (nPregunta > 30) n += 2
		if (nPregunta > 34) n += 6
		switch (nPregunta) {
			case 30:
				var aBotoneras = aBotones
				for (var nBotonera = 0; nBotonera < 3; ++nBotonera) {
					aBotoneras[nBotonera][sSerie.charCodeAt(n + nBotonera - 1) - 65].checked = true
				}
				break
			case 34:
			case 35:
				var aBotoneras = aBotones
				for (var nBotonera = 0; nBotonera < 7; ++nBotonera) {
					aBotoneras[nBotonera][sSerie.charCodeAt(n + nBotonera - 1) - 65].checked = true
				}
				break
			default:
				aBotones[sSerie.charCodeAt(n - 1) - 65].checked = true
		}
		return true
	}
	this.itera(r)
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
