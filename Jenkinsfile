pipeline {
    agent any
    
    tools {
        maven 'Maven3'
    }
    
    environment {
        def mvn = tool 'Maven3';
        def repository = 'arshdeepsingh070/devops-final-exam';
    }

    stages {
        stage('checkout') {
            steps {
                echo 'Branch is checked out form the git repo already..'
            }
        }
        stage('Build') {
            steps {
                bat "mvn clean install"
            }
        }
        stage('test') {
            steps {
                bat 'mvn test'
            }
        }
        
        stage('create docker image') {
            steps {
                bat 'docker build -t i-arshdeepsingh-feature:${BUILD_NUMBER} --no-cache -f Dockerfile .'
            }
        }
        stage('check and push') {
            parallel {
                stage ('container check'){
                    steps {
                        bat 'docker rm -f c-arshdeepsingh:latest || exit' 
                    } 
                }
                stage('push to docker hub') {
                    steps {
                        bat 'docker tag i-arshdeepsingh-feature:${BUILD_NUMBER} ${repository}:${BUILD_NUMBER}'
                        bat 'docker tag i-arshdeepsingh-feature:${BUILD_NUMBER} ${repository}:latest'
                        withDockerRegistry([credentialsId: 'Test_Docker', url:""]){
                            bat 'docker push ${repository}:${BUILD_NUMBER}'
                            bat 'docker push ${repository}:latest'
                        }
                        
                    }
                }
            }
        }   
        stage('docker deployment') {
            steps{
            bat 'docker run --name c-arshdeepsingh-feature -d -p 7400:8080 ${repository}:latest'
            }
        }
        
    }
}