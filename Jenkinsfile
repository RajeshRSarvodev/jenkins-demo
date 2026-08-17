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

        stage('Deploy') {
            steps {
                echo "Deploying to ${params.ENVIRONMENT}"
            }
        }
    }
}