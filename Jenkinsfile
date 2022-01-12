pipeline {
    agent any
    stages {
        stage('SonarQube analysis') {
           environment {
              scannerHome = tool 'SonarQubeScanner'
             } 
           steps {
             withSonarQubeEnv(installationName: 'SonarQube', credentialsId: 'SonarQube') {
                sh "${scannerHome}/bin/sonar-scanner -X"
                }
            }
        } 
        /*stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }
        stage('Build') {
            steps {
                sh '/usr/bin/make clean'
                sh '/usr/bin/make' 
            }
        }
        stage('Test'){
            steps {
                sh './hello'
            }
        }*/
        stage('Docker Build') {
            steps {
                sh 'docker build -t helloworld:latest .'
            }
        }
        stage('Test Docker image'){
            steps {
                sh 'docker run --rm helloworld:latest'
            }
        }
        stage('Docker Tag') {
            steps {
                sh 'docker tag hello dockerdaas/helloworld:latest'
                sh 'docker tag hello dockerdaas/helloworld:$BUILD_NUMBER'
            }
        }
        stage('Publish image to Docker Hub') {
           steps {
               withDockerRegistry([credentialsId: 'dockerhub', url: "https://index.docker.io/v1/"]) {
               sh  'docker push dockerdaas/helloworld:latest'
               sh  'docker push dockerdaas/helloworld:$BUILD_NUMBER'
              }
           }
        }
        stage('Publish to Artifactory') {
            steps {
                echo 'placeholder'
            }
        }
    }
    post { 
        always { 
            cleanWs()
        }
    }
}
