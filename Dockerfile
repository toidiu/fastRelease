FROM openjdk:8

LABEL version="v1.0"

MAINTAINER Apoorv

EXPOSE 9000

WORKDIR /app

RUN chown -R daemon .
USER daemon


ADD dep.jar /app/deps.jar
ADD app.jar /app/app.jar
ENTRYPOINT ["java", "-J-server", "-Dconfig.resource=prod.conf", "-Dhttps.port=9433", "-cp", "/app/deps.jar:/app/app.jar", "play.core.server.ProdServerStart"]






