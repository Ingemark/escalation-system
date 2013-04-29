#Escalation system
Escalation system is Ruby on Rails application implementing escalation process
and notification delivery via phone and mail. External system (e.g. issue
tracker) creates an escalation and system then delivers notifications to
subscribed users by levels. When the issue is solved user marks it as such in
external system which then has to cancel the escalation.

##Features
* Simultaneous escalation processes
* Multiple escalation configurations
* Escalation creation and canceling via web API
* Administration interface (via [Rails Admin] (https://github.com/sferik/rails_admin))
* Authentication (via [Devise] (https://github.com/plataformatec/devise))
* Authorization (via [CanCan] (https://github.com/ryanb/cancan) and [Rolify]
    (https://github.com/EppO/rolify))
* Mail notifications (you need SMTP server)
* Phone notifications (via [Asterisk] (http://www.asterisk.org/) and [Adhearsion] 
    (https://github.com/adhearsion/adhearsion))

##Data model
![model](https://raw.github.com/Inge-mark/escalation-system/master/public/es.png)

###Consumers
Persons or systems that are notified about new escalations.

###Delivery services
Implemented notification methods.

###Delivery service properties
Configurations (key-value pairs) for notification methods.

###Delivery addresses
Consumer addresses for notification delivery.

###Contexts
Groups of escalation levels.

###Escalation levels
Every context can contain multiple escalation levels. Consumers in higher levels
are notified after defined time only if lower levels couldn't solve the issue.

###Templates
Notification template for specific context and delivery service. E.g. subject and
body for email delivery.

###Scheduled escalations
New escalations with due time and status ('scheduled', 'canceled' or 'delivered').

###Subscriptions
User subscription for escalation level via delivery address.

###User
User that can log in to administration interface or create new escalations.

###Roles
Users with role 'admin' can log in administration interface. Users with role 'user'
and specific context can create escalations for that context.

###User roles
User-role join table.

##Instalation and configuration

###Requirements

###Database

###SMTP

###Asterisk

###Roles

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
