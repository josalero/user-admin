FROM gradle:jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN ./gradlew build --no-daemon

FROM openjdk:17

ARG PORT
ENV PORT=$PORT
EXPOSE $PORT

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/user-admin.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/user-admin.jar"]