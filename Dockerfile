FROM alpine/git as clone (1)
WORKDIR /app
RUN git clone https://github.com/akshitchadha/spring-boot-docker-complete.git

FROM maven:8-jdk-alpine as build (2)
WORKDIR /app
COPY --from=clone /app/spring-boot-docker-complete /app (3)
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/spring-boot-docker-complete-0.0.1-SNAPSHOT.jar /app
CMD ["java -jar spring-boot-docker-complete-0.0.1-SNAPSHOT.jar"]
