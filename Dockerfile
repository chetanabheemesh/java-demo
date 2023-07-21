# BUild stage
FROM maven:3.6.0-jdk-11-slim AS builder
USER root
RUN mkdir /home/app
WORKDIR /home/app
COPY . /home/app
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean install

FROM tomcat:9.0
COPY --from=builder /home/app/webapp/target/webapp.war /usr/local/tomcat/webapps/
EXPOSE 8082
CMD ["catalina.sh", "run"]
