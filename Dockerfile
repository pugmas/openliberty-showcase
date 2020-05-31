FROM openjdk:8-jre-alpine

COPY target/openliberty-showcase.jar /opt/openliberty-showcase.jar

EXPOSE 9080
ENTRYPOINT exec java -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true -jar /opt/openliberty-showcase.jar
