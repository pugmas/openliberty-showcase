FROM openliberty/open-liberty:20.0.0.6-full-java8-openj9-ubi

COPY --chown=1001:0 src/main/liberty/config /config/
COPY --chown=1001:0 target/openliberty-showcase.war /config/apps

HEALTHCHECK --start-period=10s --timeout=60s --retries=10 --interval=5s CMD curl -f http://localhost:9080/health/ready || exit 1

RUN configure.sh