pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
         stage('Clone repository') { 
            steps { 
                script{
                checkout scm
                }
            }
        }

        stage('Build') { 
            steps { 
                script{
                 app = docker.build("log4shellstd1")
                }
            }
        }
        stage('Push') {
            steps {
                script{
                        //docker.withRegistry('https://371571523880.dkr.ecr.us-east-2.amazonaws.com/log4shell', 'ecr:us-east-2:aws-credentials') {
                    docker.withRegistry('https://public.ecr.aws/f9n2h3p5/log4shellpub'){
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
                }
            }
        }
     
        stage('Deploy'){
            steps {
                 sh 'sed -i "s/<TAG>/${BUILD_NUMBER}/" deployment.yml'
                 sh 'kubectl apply -f deployment.yml'
                 /*
                 //If you are sure this deployment is already running and want to change the container image version, then you can use:
                 sh 'kubectl set image deployments/dvwa 371571523880.dkr.ecr.us-east-2.amazonaws.com/dvwaxperts:${BUILD_NUMBER}'*/
            }
        } 
    }
}
