# Building application using maven
#FROM openjdk:18-jdk as builder
FROM maven:3.8.6-openjdk-11-slim AS builder
#RUN mkdir -p /app/source
WORKDIR /app/source
COPY . .
# the below env is recommended to pass at Runtime with $ Docker run -e spring.data....
# here mongodb1 is the name of the mongodb server
#ENV spring.data.mongodb.host=mongodb1
#RUN ./mvnw clean package
RUN mvn -f pom.xml clean package

# packaing the application

FROM builder
#FROM openjdk:11-jdk-slim
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]