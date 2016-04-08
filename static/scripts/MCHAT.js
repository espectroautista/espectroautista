// Evaluador del test MCHAT
//
// require test.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestMCHAT(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	Test.call(this, sId, nTotal, dMensajes)
	this.sLetras = "ab"
}
TestMCHAT.prototype = new Test

TestMCHAT.prototype.verifica = function() {
	function p(v0, v1) {
		return ((v0 === 0 && v1 === 1) || (v0 === 1 && v1 === 0))
	}
	return Test.prototype.verifica.call(this, p, 23)
			&& cierto(this.nTotal === 23, "expected 23 questions")
}

TestMCHAT.prototype.submit = function() {
	var aCriticos = [2,7,9,13,14,15], aFallos = new Array()
	function fallos(nPregunta, aBotones) {
		for (var nBoton = 0; nBoton < 2; ++nBoton) {
			if (aBotones[nBoton].checked) {
				if (aBotones[nBoton].value === "1") {
					aFallos[aFallos.length] = nPregunta
				}
				break
			}
		}
		return true
	}
	function criticos() {
		var n = 0
		for (var i = 0; i < aFallos.length; ++i) {
			if (member(aFallos[i], aCriticos)) ++n
		}
		return n
	}

	var nFallos = this.totaliza(), sMensaje
	if (nFallos !== -1) {
		this.itera(fallos)
		var nCriticos = criticos()
		if (nFallos >= 3 || nCriticos >= 2) {
			sMensaje =	this.aMensajes["mchat0"] + String(nFallos) +
						this.aMensajes["mchat1"] + String(nCriticos) +
						this.aMensajes["mchat2"]
		} else if (nFallos > 1) {
			sMensaje =	this.aMensajes["mchat0"] + String(nFallos) + this.aMensajes["mchat4"]
		} else if (nFallos === 1) {
			sMensaje =	this.aMensajes["mchat5"] + String(nFallos) + this.aMensajes["mchat6"]
		} else {
			sMensaje =	this.aMensajes["mchat3"]
		}
		this.muestraTotal([""], [sMensaje])
	}
	return CONSERVA
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
