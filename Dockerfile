FROM alpine/git as clone (1)
WORKDIR /app
RUN git clone https://github.com/akshitchadha/spring-boot-docker-complete.git

FROM maven:3.5-jdk-8-alpine as builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTest

FROM openjdk:8-jdk-alpine
WORKDIR /app
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
