pipeline {
    agent any
    tools {
        maven "Maven"
        jdk "JDK"
    }
    stages {
        stage('Pulling the code'){
            steps{
                echo "PATH = ${M2_HOME}/bin:${PATH}"
                echo "M2_HOME = /opt/maven"
            }
        }
        stage(Build') {
            steps {
                dir("${workspace}") {
                sh 'mvn -B -DskipTests clean package'
                
                }
            }
        }
        stage('Test') {
            steps {
                dir("${workspace}") {
                sh 'mvn test'
                
                }
            }
        }
        stage('Container Build') {
            steps {
                dir("${workspace}") {
                sh 'docker build . -t junittest'
                }
            }
        }
        stage('Registry Push') {
            steps {
                
                    withAWS(credentials: 'Personla', region: 'us-east-1') {
                        sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 725482889936.dkr.ecr.us-east-1.amazonaws.com'
                        sh 'docker tag junittest:latest 725482889936.dkr.ecr.us-east-1.amazonaws.com/junittest:latest'
                        sh 'docker push 725482889936.dkr.ecr.us-east-1.amazonaws.com/junittest:latest'
                    }
                
                
            }
        }
        stage('Dev Deploy') {
            steps {
                
                    withAWS(credentials: 'Personla', region: 'us-east-1') {
                        sh 'aws eks update-kubeconfig --region us-east-1 --name first'
                        sh 'kubectl version'
                    }
                
                
            }
        }
        
     }
    post {
       always {
          junit(
        allowEmptyResults: true,
        testResults: '*/test-reports/.xml'
      )
      }
   } 
}
