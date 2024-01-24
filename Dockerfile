#FROM openjdk:18-jdk as builder
FROM maven:3.8.6-openjdk-11-slim AS builder
RUN mkdir -p /app/source
COPY . /app/source
WORKDIR /app/source
ENV spring.data.mongodb.host=mongodb1
#RUN ./mvnw clean package
RUN mvn -f pom.xml clean package

FROM builder
#FROM openjdk:18-jdk
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]