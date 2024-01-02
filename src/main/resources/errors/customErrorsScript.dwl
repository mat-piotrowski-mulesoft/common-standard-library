var customErrorsMap = readUrl("classpath://errors/custom-errors-map.json","application/json")

var customError = (code, exceptionDescription = "") -> {
	"code": code,
    "message": customErrorsMap[code].message,
    "description": customErrorsMap[code].description replace "{exceptionDescription}" with exceptionDescription
}

var customErrorCode = (code) -> customErrorsMap[code].responseCode