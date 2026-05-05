FROM gradle:jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN ./gradlew build --no-daemon

# Official openjdk images were removed; Eclipse Temurin is the common replacement.
FROM eclipse-temurin:17-jre-jammy

ARG PORT=8085
ENV PORT=$PORT
EXPOSE $PORT

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/user-admin.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/user-admin.jar"]