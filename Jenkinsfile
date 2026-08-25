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
	
	stage('Security Scan') {	
		Steps {
			echo "Scanning Docker Image for vulnerabilities..."
			bat 'trivy image --severity HIGH,CRITICAL --exit-code 1 jenkins-demo:%				BUILD_NUMBER'
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
