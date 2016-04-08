// query.js - Gestion de la query string
//
// Para trocear url-encoded strings
function parseQueryString(sQuery) {
	if (!sQuery) return null
	if (sQuery.charAt(0) === "?") sQuery = sQuery.substr(1)
	if (!sQuery) return null
	var oDictionary = new Object()
	var aVariables = sQuery.split("&")
	for (var i in aVariables) {
		var aPair = aVariables[i].split("=", 2)
		oDictionary[unescape(aPair[0])] = unescape(aPair[1])
	}
	return oDictionary
}

var oQuery = parseQueryString(window.location.search)

// vim:sw=4:ts=4:ai:fileencoding=utf8
