FROM gradle:8.2.1-jdk17-alpine AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM eclipse-temurin
WORKDIR /temp/app
COPY --from=build /home/gradle/src/build/libs/*.jar /temp/app/spring-boot-application.jar
RUN ls /temp/app/
ENTRYPOINT ["java", "-jar", "/temp/app/spring-boot-application.jar"]CMD