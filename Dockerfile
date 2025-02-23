FROM maven:3.8.6-openjdk-11-slim AS builder
WORKDIR /app/source
COPY . .
RUN mvn -f pom.xml clean package
FROM builder
COPY --from=builder /app/source/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
