#Escalation system

##API

###Tokens

####Creating a token
```
POST /tokens
{"username": "<username>", "password": "<password>"}
```

JSON response:
```JSON
{"status": "OK", "message": "<auth_token>"}
```

####Deleting a token
```
DELETE /tokens
{"auth_token": "<auth_token>"}
```

JSON response:
```JSON
{"status": "OK", "message": "Token destroyed."}
```

###Escalations

####Creating escalations
```
POST /escalations
{"context_id": "<context_id>",
 "external_reference_id": "<external_reference_id>",
 "auth_token": "<auth_token>"}
```

JSON response:
```JSON
{"status": "OK", "message": "3 escalations created."}
```

####Canceling escalations
```
DELETE /escalations
{"context_id": "<context_id>",
 "external_reference_id": "<external_reference_id>",
 "auth_token": "<auth_token>"}
```

JSON response:
```JSON
{"status": "OK", "message": "3 escalations canceled."}
```

###Testing API with curl
```
curl -H "Accept: application/json" \
     -H "Content-type: application/json" \
     -d '{"external_reference_id":"123", "context_id":1, "auth_token":"fs2t3ybDu1h2PzCWy4p"}' \
     -X DELETE \
     localhost:3000/escalations
```
