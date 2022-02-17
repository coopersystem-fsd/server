FROM maven:3.8.2-jdk-8 as builder
COPY . /usr/src/mymaven
WORKDIR /usr/src/mymaven
RUN mvn clean install -DskipTests=true -f /usr/src/mymaven && mkdir /usr/src/wars/
RUN find /usr/src/mymaven/target/ -iname '*.war' -exec cp {} /usr/src/wars/ROOT.war \;

FROM tomcat:8.5.75-jdk8
COPY --from=builder /usr/src/wars/* /usr/local/tomcat/webapps/
