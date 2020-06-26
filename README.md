# Open Liberty Showcase

[![GitHub last commit](https://img.shields.io/github/last-commit/stephan-mueller/openliberty-showcase)](https://github.com/stephan-mueller/openliberty-showcase/commits) 
[![GitHub](https://img.shields.io/github/license/stephan-mueller/openliberty-showcase)](https://github.com/stephan-mueller/openliberty-showcase/blob/master/LICENSE)
[![CircleCI](https://circleci.com/gh/stephan-mueller/openliberty-showcase.svg?style=shield)](https://app.circleci.com/pipelines/github/stephan-mueller/openliberty-showcase)
 
This is a showcase for the microservice framework [Open Liberty](https://openliberty.io). It contains a hello world application, which demonstrates several features of openliberty and Eclipse Microprofile

Software requirements to run the samples are `maven`, `openjdk-1.8` (or any other 1.8 JDK) and `docker`. When running the Maven lifecycle it will create the war package and use the `liberty-maven-plugin` to create a runnable jar (fat jar) which contains the application and the Open Liberty application server. The fat jar will be copied into a Docker image using Spotify's `dockerfile-maven-plugin` during the package phase. 

## How to run

Before running the application it needs to be compiled and packaged using Maven. It creates the required war,
jar and Docker image and can be run via `docker`:

```shell script
$ mvn clean package
$ docker run --rm -p 9080:9080 openliberty-showcase
```

Wait for a message log similar to this:

> service_1   | [3/5/20 16:36:02:145 UTC] 0000001b id=         com.ibm.ws.kernel.feature.internal.FeatureManager            A CWWKF0011I: The defaultServer server is ready to run a smarter planet. The defaultServer server started in 13.006 seconds.

If everything worked you can access the OpenAPI UI via http://localhost:9080/openapi/ui.

## Resolving issues

Sometimes it may happen that the containers did not stop as expected when trying to stop the pipeline early. This may
result in running containers although they should have been stopped and removed. To detect them you need to check
Docker:

```shell script
$ docker ps -a | grep openliberty-showcase
```

If there are containers remaining although the application has been stopped you can remove them:

````shell script
$ docker rm <ids of the containers>
````