pipeline {
    agent any
    
    environment {
        CURRENT_DATE = sh(script: 'date "+%Y%m%d"', returnStdout: true).trim()
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your source code from the repository
                git url: 'https://github.com/rifkhan107/java-app-aws-github-actions.git'
            }
        }

        stage('Build') {
            steps {
                withEnv(["JAVA_HOME=/opt/jdk-18.0.2.1", "MAVEN_HOME=/usr/share/maven"]) {
                    sh "${env.JAVA_HOME}/bin/java -version"
                    sh "${env.MAVEN_HOME}/bin/mvn --version"
                    sh 'mvn clean install -DskipTests'
                }
            }
        }


        stage('Build Docker Image') {
            steps {
                script {
                    // Set the version number and date for the Docker image
                    def version = "v1.0.${env.BUILD_NUMBER}-${env.CURRENT_DATE}"

                    // Build the Docker image
                    sh "docker build -t om-be:${version} ."

                    // Tag the Docker image for the Azure Container Registry
                    sh "docker tag om-be:${version} dev98.azurecr.io/om-be:${version}"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Set the version number for the Docker image
                    def version = "v1.0.${env.BUILD_NUMBER}-${env.CURRENT_DATE}"

                    // Login to Azure Container Registry
                    sh "az acr login --name dev98"

                    // Push the Docker image to Azure Container Registry
                    sh "docker push dev98.azurecr.io/om-be:${version}"
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                script {
                    // Set the version number and date for the Docker image
                    def version = "v1.0.${env.BUILD_NUMBER}-${env.CURRENT_DATE}"
                    def ACR_REGISTRY = 'dev98.azurecr.io'
                    def DOCKER_IMAGE = 'om-be'

                    // Replace the image in the manifest file with the new image from ACR
                    sh "sed -i 's|<your-image-placeholder>|${ACR_REGISTRY}/${DOCKER_IMAGE}:${version}|g' k8s-manifest.yaml"

                    // Apply the manifest file to deploy to the AKS cluster
                    sh "kubectl apply -f k8s-manifest.yaml"
                }
            }
        }

    }
}
