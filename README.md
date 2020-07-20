# Open Liberty Showcase

[![GitHub last commit](https://img.shields.io/github/last-commit/stephan-mueller/openliberty-showcase)](https://github.com/stephan-mueller/openliberty-showcase/commits) 
[![GitHub](https://img.shields.io/github/license/stephan-mueller/openliberty-showcase)](https://github.com/stephan-mueller/openliberty-showcase/blob/master/LICENSE)
[![CircleCI](https://circleci.com/gh/stephan-mueller/openliberty-showcase.svg?style=shield)](https://app.circleci.com/pipelines/github/stephan-mueller/openliberty-showcase)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=stephan-mueller_openliberty-showcase&metric=alert_status)](https://sonarcloud.io/dashboard?id=stephan-mueller_openliberty-showcase)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=stephan-mueller_openliberty-showcase&metric=coverage)](https://sonarcloud.io/dashboard?id=stephan-mueller_openliberty-showcase)
 
This is a showcase for the microservice framework [Open Liberty](https://openliberty.io). It contains a hello world application, 
which demonstrates several features of Open Liberty and Eclipse Microprofile.

Software requirements to run the samples are `maven`, `openjdk-1.8` (or any other 1.8 JDK) and `docker`. 
When running the Maven lifecycle it will create the war package and use the `liberty-maven-plugin` to create a runnable jar (fat jar) 
which contains the application and the Open Liberty application server. The fat jar will be copied into a Docker image using Spotify's 
`dockerfile-maven-plugin` during the package phase.

**Notable Features:**
* Dockerfiles for runnable JAR & Server
* Integration of MP Health and MP OpenAPI
* Testcontainer-Tests with Rest-Assured, Cucumber and Postman/newman
* [CircleCI](https://circleci.com) Integration
* [Sonarcloud](https://sonarcloud.io) Integration


## How to run

Before running the application it needs to be compiled and packaged using `Maven`. It creates the runnable jar and Docker image and can be 
run via `docker`:

```shell script
$ mvn clean package
$ docker run --rm -p 9080:9080 openliberty-showcase
```

For the Open Liberty Server a multi-stage Docker image is provided. It can be created and run via `docker`:    
```shell script
$ docker build -f Dockerfile.server -t openliberty-server-showcase .
$ docker run --rm -p 9080:9080 openliberty-server-showcase
```

Wait for a message log similar to this:

> service_1   | [3/5/20 16:36:02:145 UTC] 0000001b id=         com.ibm.ws.kernel.feature.internal.FeatureManager            A CWWKF0011I: The defaultServer server is ready to run a smarter planet. The defaultServer server started in 13.006 seconds.

If everything worked you can access the OpenAPI UI via [http://localhost:9080/openapi/ui](http://localhost:9080/openapi/ui).

### Resolving issues

Sometimes it may happen that the containers did not stop as expected when trying to stop the pipeline early. This may
result in running containers although they should have been stopped and removed. To detect them you need to check
Docker:

```shell script
$ docker ps -a | grep openliberty-showcase
```

If there are containers remaining although the application has been stopped you can remove them:

```shell script
$ docker rm <ids of the containers>
```


## Features

### Application 

The application is a very simple "Hello World" greeting service. It supports GET requests for generating a greeting message, and a PUT 
request for changing the greeting itself. The response is encoded using JSON.

Try the application
```shell script
curl -X GET http://localhost:9080/api/greet
{"message":"Hello World!"}

curl -X GET http://localhost:9080/api/greet/Stephan
{"message":"Hello Stephan!"}

curl -X PUT -H "Content-Type: application/json" -d '{"greeting" : "Hola"}' http://localhost:9080/api/greet/greeting

curl -X GET http://localhost:9080/api/greet/greeting
{"greeting":"Hola"}

curl -X GET http://localhost:9080/api/greet/Max
{"message":"Hola Max!"}
```

### Health and OpenAPI

The application server provides built-in support for health and openapi endpoints.

Health liveness and readiness
```shell script
curl -s -X GET http://localhost:9080/health

curl -s -X GET http://localhost:9080/health/live

curl -s -X GET http://localhost:9080/health/ready
```

OpenAPI in YAML / JSON Format
```shell script
curl -s -X GET http://localhost:9080/openapi

curl -H 'Accept: application/json' -X GET http://localhost:9080/openapi
```