pipeline {
    agent any

    environment {
        APP_NAME = 'jenkins-demo'
    }

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
                echo "Building ${APP_NAME}..."
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
            }
        }
	
	stage('Docker Check') {
   	 steps {
        bat 'docker --version'
        bat 'docker info'
    }
}

        stage('Package') {
            steps {
                echo "Packaging application..."
                bat 'if not exist build mkdir build'
                bat 'echo Jenkins build artifact > build\\app.txt'
            }
        }

        stage('Deploy') {
            when {
                expression {
                    params.ENVIRONMENT != 'production'
                }
            }
            steps {
                echo "Deploying ${APP_NAME} to ${params.ENVIRONMENT}"
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: 'build/**', fingerprint: true
        }
    }
}