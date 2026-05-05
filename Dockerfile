FROM gradle:jdk17 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN ./gradlew build --no-daemon

# Official openjdk images were removed; Eclipse Temurin is the common replacement.
FROM eclipse-temurin:17-jre-jammy

ARG PORT=8085
ENV PORT=$PORT
EXPOSE $PORT

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=30s --timeout=5s --start-period=180s --retries=5 \
  CMD curl -fsS "http://127.0.0.1:${PORT}/actuator/health/liveness" >/dev/null || exit 1

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/user-admin.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/user-admin.jar"]