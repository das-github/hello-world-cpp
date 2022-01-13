pipeline {
    agent any
    stages {
        stage('Build & Scan') {
            steps {
                sh "/usr/bin/make clean"
                sh "/usr/bin/make" 
                sh "cppcheck --xml --xml-version=2 --enable=all ./ 2> cppcheck-report.xml"
            }
        } 
        stage('SonarQube analysis') {
           environment {
              scannerHome = tool 'SonarScanner'
             } 
           steps {
             withSonarQubeEnv('SonarQube') {
                sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        } 
        /*stage("Quality Gate") {
            steps {
             timeout(activity: true, time: 2) {
                waitForQualityGate abortPipeline: false
              }
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
        stage('Scanning Image') {
            steps {
               echo 'sysdig scan of Docker image'
            }
        }        
        stage('Docker Tag test') {
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
