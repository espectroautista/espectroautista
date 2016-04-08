// Evaluador del test EQ
//
// require C.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestEQ(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	TestControl.call(this, sId, nTotal, dMensajes)
}
TestEQ.prototype = new TestControl

TestEQ.prototype.verifica = function() {
	var aPreguntasControl = [2,3,5,7,9,13,16,17,20,23,24,30,31,33,40,45,47,51,53,56]
	return TestControl.prototype.verifica.call(this, aPreguntasControl)
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
