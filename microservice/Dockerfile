FROM openjdk:8-jre-alpine
MAINTAINER Peter Wood

ENTRYPOINT ["/usr/bin/java", "-jar", "app.jar"]

ADD target/lib  lib

ARG java_jar
ADD target/${java_jar}  app.jar
