FROM open:jdk
EXPOSE 8080
ADD target/devops-exam-sample-0.0.1-SNAPSHOT.jar devops-exam-sample-0.0.1-SNAPSHOT.jar
ENTRYPOINT [ "java" , "-jar" , "/devops-exam-sample-0.0.1-SNAPSHOT.jar"]