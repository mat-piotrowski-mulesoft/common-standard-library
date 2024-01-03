# common-standard-library
Mulesoft common library to handle reusable flows and configurations.

## Version
1.0.0

## Installation
To install this package you need to have:

- Java 8
- Maven 3.5+

Run maven command:

```bash
mvn clean install
```

Add the following to your project's pom.xml file:

```xml
<dependency>
    <groupId>com.itsnooge</groupId>
    <artifactId>common-standard-library</artifactId>
    <version>1.0.0</version>
</dependency>
```

Import files you want to use in your project.

```xml
<import doc:name="Import FILE_NAME" doc:id="edbf1bca-5b10-4d5b-88b9-e21309137b47" file="FILE_NAME.xml" />
```

## Usage
To use this dependency, simply import it into your project and use the provided flows and confguration.

### Error handling

1. Import error-handling file
```xml
<import doc:name="Import error handling" doc:id="edbf1bca-5b10-4d5b-88b9-e21309137b47" file="error-handling.xml" /
```

2. Add this lines to your properties file:
```yml
api:
  layer: "API_LAYER"
  error:
    code: "ERROR_CODE"
```

3. To use custom codes add **custom-errors-map.json** file to
```
src/main/resources/errors
```

Errors map should be a JSON object with this structure:
```json
{
  "API.ERROR.CODE-API.LAYER-ERROR_CODE": {
    "code": "API.ERROR.CODE-API.LAYER-ERROR_CODE",
    "message": "MESSAGE",
    "description": "DESCRIPTION",
    "responseCode": "RESPONSE_CODE (as number)"
  },
  "API.ERROR.CODE-API.LAYER-ERROR_CODE": {
    "code": "API.ERROR.CODE-API.LAYER-ERROR_CODE",
    "message": "MESSAGE",
    "description": "DESCRIPTION",
    "responseCode": "RESPONSE_CODE (as number)"
  }
}
```

Example
```json
{
  "DDBAUTH-S-00001": {
    "code": "DDBAUTH-S-00001",
    "message": "Bad Request",
    "description": "Wrong format of the email address",
    "responseCode": 400
  },
  "DDBAUTH-S-00002": {
    "code": "DDBAUTH-S-00002",
    "message": "Bad Request",
    "description": "Wrong format of the phone number",
    "responseCode": 400
  }
}
```

4. Use **APP:EXCEPTION_HANDLING** error type and error code in error description/message field.

### Pagination

1. Import pagination file
```xml
<import doc:name="Import pagination" doc:id="edbf1bca-5b10-4d5b-88b9-e21309137b47" file="pagination.xml" /
```

2. Add this lines to your properties file:
```yml
pagination:
  limit:
    default: "PAGINATION_LIMIT_DEFAULT_VALUE"
    max: "PAGINATION_LIMIT_MAXIMUM_VALUE"
```

3. On the begining of flow that required pagination use flow reference to init flow. Pagination module uses _offset_ and _limit_ query parameters to handle pagination and sets variables _offset_ and _limit_.
```xml
<flow-ref doc:name="Ref to csl:pagination-init-subflow" doc:id="abc38c22-5eb9-4cde-92d3-0514ddbf955d" name="csl:pagination-init-subflow"/>
```

4. After get the data set variables:
- **isNextPage** - boolean value, if _true_ nextPage link value will be set to offset + 1
- **lastPageValue** - string value, it will be set as offset in lastPage link value

5. Before set the response payload make a flow reference to create links flow.
```
<flow-ref doc:name="Ref to csl:create-pagination-links-subflow" doc:id="abc38c22-5eb9-4cde-92d3-0514ddbf955d" name="csl:create-pagination-links-subflow"/>
```

6. Add **paginationLinks** variable to your response payload (it is object with firstPage, prevPage, nextPage and optional lastPage)

## Authors

- Mateusz Piotrowski - [mat-piotrowski](https://github.com/mat-piotrowski)


## License
This project is licensed under the MIT License - see the LICENSE.md file for details.
