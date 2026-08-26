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
        bat 'exit /b 1'
    		}
	}

        stage('Package') {
            steps {
                echo "Packaging application..."

                bat 'if not exist build mkdir build'
                bat 'echo Jenkins build artifact > build\\app.txt'
            }
        }

        stage('Docker Build') {
            steps {
                echo "Building Docker image..."

                bat 'docker build -t jenkins-demo:%BUILD_NUMBER% .'
            }
        }

        stage('Deploy to Dev/Staging') {
            when {
                expression {
                    params.ENVIRONMENT != 'production'
                }
            }

            steps {
                echo "Deploying ${APP_NAME} to ${params.ENVIRONMENT}"
            }
        }

        stage('Production Approval') {
            when {
                expression {
                    params.ENVIRONMENT == 'production'
                }
            }

            steps {
                input(
                    message: 'Approve deployment to PRODUCTION?',
                    ok: 'Deploy to Production'
                )
            }
        }

        stage('Production Deploy') {
            when {
                expression {
                    params.ENVIRONMENT == 'production'
                }
            }

            steps {
                echo "Deploying ${APP_NAME} to production"
            }
        }
    }

    post {
    always {
        echo "Pipeline finished."
    }

    success {
        echo "Pipeline completed successfully."
        archiveArtifacts artifacts: 'build/**', fingerprint: true
    }

    failure {
        echo "Pipeline FAILED."
    }

    cleanup {
        echo "Cleanup completed."
    }
}