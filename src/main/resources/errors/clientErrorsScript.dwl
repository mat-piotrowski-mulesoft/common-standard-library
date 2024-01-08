var clientError = (errorMessage) -> do {
	var errorObject = read(errorMessage, 'application/json')
	---
	{
		"code": errorObject.code,
	    "message": errorObject.message,
	    "description": errorObject.description    
	}
}

var clientErrorCode = (errorMessage) -> do {
	var errorObject = read(errorMessage, 'application/json')
	---
	errorObject.statusCode	
}