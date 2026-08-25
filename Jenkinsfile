pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'staging', 'production'],
            description: 'Choose the deployment environment'
        )
    }

    stages {

        stage('Build') {
            steps {
                echo "Building application..."
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
            }
        }

  	stage('Credentials Test') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'demo-credentials',
                        usernameVariable: 'DEMO_USER',
                        passwordVariable: 'DEMO_PASSWORD'
                    )
                ]) {
                    echo "Credential username is: ${DEMO_USER}"
                    echo "Credential password is: ${DEMO_PASSWORD}"
                }
            }
        }


        stage('Deploy') {
            steps {
                echo "Deploying to ${params.ENVIRONMENT}"
            }
        }
    }
}