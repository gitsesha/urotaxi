FROM jcrhub.com/docker/ubuntu:20.04
ENV JAVA_HOME=/u01/applications/jdk-11
ENV PATH=${PATH}:${JAVA_HOME}/bin

RUN mkdir -p /u01/applications/
RUN apt update -y
# RUN apt install -y openjdk-11-jdk
RUN apt install -y curl

EXPOSE 8082

WORKDIR /u01/applications/
ADD https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz .
RUN tar -xvzf openjdk-11+28_linux-x64_bin.tar.gz
RUN rm openjdk-11+28_linux-x64_bin.tar.gz

COPY target/urotaxi-1.0.jar .

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl http://localhost:8082/actuator/health || exit 1
ENTRYPOINT [ "java", "-jar", "./urotaxi-1.0.jar" ]
