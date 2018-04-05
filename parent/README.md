# bytewood-parent

a parent pom for springboot based microservices deployed in docker images

### Using the microservice maven profile
builds a docker image of the application using maven GAV coordinates
```
mvn -P microservice clean install
```
Does not use spring-boot-maven-plugin:repackage
Instead copies to dependencies to lib folder and
creates a separate executable jar for the application
This allows dependencies to be written in a separate docker image layer.
