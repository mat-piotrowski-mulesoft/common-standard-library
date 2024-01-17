fun getErrorCode (errorType) = do {
	var code400 = ["QUERY_EXECUTION"]
	var code401 = ["INVALID_CREDENTIALS"]
	var code500 = ["BAD_SQL_SYNTAX", "CANNOT_LOAD_DRIVER", "INVALID_DATABASE"]
	var code503 = ["CANNOT_REACH", "CONNECTIVITY", "RETRY_EXHAUSTED"]
	---
	if (code400 contains errorType)
		"DB400"
	else if (code401 contains errorType)
		"DB401"
	else if (code503 contains errorType)
		"DB503"
	else 
		"DB500"
}

fun genereteDbErrorObject (errorType, errorDescription) = do {
	var errorsMap = readUrl("classpath://errors/default-db-errors-map.json","application/json")
	var code = getErrorCode(errorType)
	var errorValue = errorsMap[code]
	
	var appErrorName = Mule::p("api.error.code")
	var appLayer = Mule::p("api.layer")
	---
	{
		code: appErrorName ++ "-" ++ appLayer ++ "-" ++ code,
	    message: errorValue.message,
	    description: errorValue.description replace "{description}" with errorDescription,
	    statusCode: errorValue.statusCode
	}
}