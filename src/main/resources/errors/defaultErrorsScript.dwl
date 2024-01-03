var defaultErrorsMap = readUrl("classpath://errors/default-errors-map.json","application/json")

var standardError = (code, exceptionDescription = "") -> do {
	var appErrorName = Mule::p("api.error.code")
	var appLayer = Mule::p("api.layer")
	---
	{
	    "code": appErrorName ++ "-" ++ appLayer ++ "-99" ++ code,
	    "message": defaultErrorsMap[code].message,
	    "description": defaultErrorsMap[code].description replace "{exceptionDescription}" with exceptionDescription
	}
}

var paginationError = (code, exceptionDescription = "") -> do {
	var appErrorName = Mule::p("api.error.code")
	var appLayer = Mule::p("api.layer")
	---
	{
	    "code": appErrorName ++ "-" ++ appLayer ++ "-99400",
	    "message": defaultErrorsMap[code].message,
	    "description": defaultErrorsMap[code].description replace "{exceptionDescription}" with exceptionDescription
	}
}