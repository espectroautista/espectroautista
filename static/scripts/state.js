// state.js - Mantenimiento del estado mediante cookies
//
////////////////////////////////////////////////////////////////////////
// Cookie - Objetos persistentes en base a cookies
////////////////////////////////////////////////////////////////////////

function Cookie(sName, sScope, nExpires, sDomain) {
	var j, i = document.cookie.indexOf(sName+"_=")
	// uso '_' para distinguir de otras propiedades, que si se guardan
	this._name = sName
	this._scope = sScope
	this._expires = nExpires
	// domain esta por implementar...
	if (i === -1) {
		// no se ha recibido la galleta
		this.inicio = new Date().getTime()
	} else {
		i = document.cookie.indexOf("=", i)+1
		j = document.cookie.indexOf(";", i)
		if (j === -1) j = document.cookie.length
		var aPair, aVariables = document.cookie.substring(i, j).split("&")
		for (i in aVariables) {
			aPair = aVariables[i].split("=")
			switch (aPair[0]) {
				case "N":
					this[aPair[1]] = Number(unescape(aPair[2]))
					break
				case "S":
					this[aPair[1]] = unescape(aPair[2])
					break
				case "B":
					this[aPair[1]] = (aPair[2] === "1")
					break
				default:
					break
			}
			// solo se soportan los 3 tipos primitivos basicos
		}
	}
}

Cookie.prototype.save = function () {
	function expireDate(nSeconds) {
		if (!nSeconds) return ""
		var nMilliseconds = (new Date().getTime())+nSeconds*1000
		return "; expires="+new Date(nMilliseconds).toGMTString()
	}
	var aState = [ ], i = 0
	for (var p in this) {
		if (p.charAt(0) === "_") { 
			// propiedad privada
			continue
		}
		switch (typeof this[p]) {
			case "number":
				aState[i++] = "N="+p+"="+escape(this[p])
				break
			case "string":
				aState[i++] = "S="+p+"="+escape(this[p])
				break
			case "boolean":
				aState[i++] = "B="+p+"="+(this[p] ? "1" : "0")
				break
		}
	}
	var sCookie = this._name+"_="+aState.join("&")+
					expireDate(this._expires)+
					"; path="+(this._scope || "/")+";"
	document.cookie = sCookie
}

Cookie.prototype.expire = function () {
	this._expires = -7777
	this.save()
}

// vim:sw=4:ts=4:ai:fileencoding=utf8
