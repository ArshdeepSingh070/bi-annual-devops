pipeline {

  agent any
  
  tools {
      maven 'Maven3'
  }  
  environment {
      def mvn = tool 'Maven3';
      def repo = 'arshdeepsingh070/devops-final-exam';
  }
  
  stages {
      Stage("checkout") {
          steps{
          checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ArshdeepSingh070/bi-annual-devops.git']]])
        }
       }
      
      stage("build") {
          steps {
              bat "mvn clean install"
          }
      }
      
      stage("Unit Test"){
          steps {
              bat "mvn test"
          }
      }
      
      stage("Sonar Analysis") {
          steps {
              withSonarQubeEnv("SonarQubeScanner") {
                  bat "mvn clean package sonar:sonar"
              }
          }
      }
      
      stage("Create docker image") {
          steps {
              bat "docker build -t i-practice-master:{BUILD_NUMBER} --no-cache -f Dockerfile ."
          }
      }
      stage("Push To Docker Hub") {
          steps {
              bat "docker tag i-practice-master:{BUILD_NUMBER} ${repo}:${BUILD_NUMBER}"
              withDockerRegistry([credentialsId: 'Test_Docker', url:""]){
                  bat "docker push ${repo}:{BUILD_NUMBER}"
              }
          }
      }
      stage("Docker Deployment") {
          steps {
              bat "docker run --name c-practice-master -d -p 7100:8080 ${repo}:${BUILD_NUMBER}"
          }
      }
  }

}