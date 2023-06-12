FROM adoptopenjdk:11-jre-hotspot

EXPOSE 8080

COPY ./target/WebApp.war /usr/app/
WORKDIR /usr/app

LABEL image.name="welcome"
LABEL image.tag="1.0.0"

ENTRYPOINT ["java", "-jar", "WebApp.war"]
