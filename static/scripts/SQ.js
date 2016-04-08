// Evaluador del test SQ
//
// require C.js

////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////

function TestSQ(sId, nTotal, dMensajes) {
	if (arguments.length === 0) return
	TestControl.call(this, sId, nTotal, dMensajes)
}
TestSQ.prototype = new TestControl

TestSQ.prototype.verifica = function() {
	var aPreguntasControl = [2,3,8,9,10,14,16,17,21,22,27,36,39,46,47,50,52,54,58,59]
	return TestControl.prototype.verifica.call(this, aPreguntasControl)
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
