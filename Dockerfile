FROM openjdk:17
EXPOSE 8082
RUN curl -O http://192.168.202.128:8081/repository/maven-releases/tn/esprit/DevOps_Project/1.0/DevOps_Project-1.0.jar
ENTRYPOINT ["java", "-jar", "/DevOps_Project-1.0.jar"]