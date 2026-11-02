FROM gradle:jdk17 AS build
# Temurin 17.0.20.1 still trusts the eMudhra roots behind the compromised intermediates (JDK-8395690,
# CVE-2026-114820). Temurin aliases differ from Oracle's "[jdk]" names: match on subject, and fail if any remain.
# Drop once the base image ships a JDK with the fix.
RUN roots='^Owner: CN=(emSign ECC Root CA - G3|emSign Root CA - G1|emSign Root CA - G2|AAA Certificate Services),'; \
    keytool -list -v -cacerts -storepass changeit > /tmp/cacerts.txt \
    && awk -v re="$roots" '/^Alias name: /{alias=substr($0,13)} $0 ~ re {print alias}' /tmp/cacerts.txt \
      | while IFS= read -r alias; do keytool -delete -cacerts -storepass changeit -alias "$alias" || exit 1; done \
    && keytool -list -v -cacerts -storepass changeit > /tmp/cacerts.txt \
    && if grep -Eq "$roots" /tmp/cacerts.txt; then echo "eMudhra roots still trusted" >&2; exit 1; fi \
    && rm /tmp/cacerts.txt
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

RUN roots='^Owner: CN=(emSign ECC Root CA - G3|emSign Root CA - G1|emSign Root CA - G2|AAA Certificate Services),'; \
    keytool -list -v -cacerts -storepass changeit > /tmp/cacerts.txt \
    && awk -v re="$roots" '/^Alias name: /{alias=substr($0,13)} $0 ~ re {print alias}' /tmp/cacerts.txt \
      | while IFS= read -r alias; do keytool -delete -cacerts -storepass changeit -alias "$alias" || exit 1; done \
    && keytool -list -v -cacerts -storepass changeit > /tmp/cacerts.txt \
    && if grep -Eq "$roots" /tmp/cacerts.txt; then echo "eMudhra roots still trusted" >&2; exit 1; fi \
    && rm /tmp/cacerts.txt

HEALTHCHECK --interval=30s --timeout=5s --start-period=180s --retries=5 \
  CMD curl -fsS "http://127.0.0.1:${PORT}/actuator/health/liveness" >/dev/null || exit 1

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/user-admin.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/user-admin.jar"]