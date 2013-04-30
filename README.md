#Escalation system
Escalation system is Ruby on Rails application implementing escalation process
and notification delivery via phone and mail. External system (e.g. issue
tracker) creates an escalation and system then delivers notifications to
subscribed users by levels. When the issue is solved user marks it as such in
external system which then cancels the escalation.

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
Roles can be global, specific to model or instance of a model

###User roles
User-role join table.

##Instalation and configuration

###Requirements
* PostgreSQL database
* [rvm] (https://github.com/wayneeseguin/rvm)
* [Rails Admin] (https://github.com/sferik/rails_admin)
* [Devise] (https://github.com/plataformatec/devise)
* [CanCan] (https://github.com/ryanb/cancan)
* [Rolify] (https://github.com/EppO/rolify)
* [Asterisk] (http://www.asterisk.org/)
* [Adhearsion] (https://github.com/adhearsion/adhearsion)

###Database
Database settings should be set in *config/database.yml*.
```
development:
    adapter: postgresql
    encoding: unicode
    database: escal_development
    pool: 5
    host: localhost
    port: 5432
    username: <username>
    password: <username>
```
TODO seed

###SMTP
Set delivery service properties for *mail* in administration interface.
* address
* user_name
* password
* port
* authentication

###Asterisk
Set delivery service properties for *phone* in administration interface.
TODO

###Templates
Templates are written in ERB; you have access to *escalation* instance variable.
Set *subject* and *body* templates for *mail* delivery service.
TODO Asterisk

Template example for email body.
```ERB
This as an escalation.
External reference: <%= @escalation.external_reference_id %>
Context: <%= @escalation.subscription.escalation_level.context.name %>
```

###Roles
Users with role 'admin' can log in to administration interface. 
Users with role 'user' for model *Context* can create and cancel escalations for all contexts.
User with role 'user' for specific *Context* can only create and cancel escalations for that context.

##API

###Tokens
For creating and canceling escalations you need a security token. 
To create a token you need to log in with your username and password

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

##Notification delivery

To manually check for scheduled mail escalations and deliver them run rake task:
```
rake escalate:mail
```

To manually check for scheduled phone escalations and deliver them run rake task:
```
rake escalate:phone
```

To manually check for all scheduled  escalations and deliver them run rake task:
```
rake escalate:all
```

###Cron job
TODO

