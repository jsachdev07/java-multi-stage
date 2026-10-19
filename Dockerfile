# Stage 1: Build using Maven and Java 8
FROM maven:3.8.8-eclipse-temurin-8 AS builder

WORKDIR /app/source

COPY . .

RUN mvn clean package


# Stage 2: Runtime only
FROM eclipse-temurin:8-jre-alpine

WORKDIR /app

COPY --from=builder /app/source/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]
