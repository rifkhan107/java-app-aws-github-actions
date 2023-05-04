pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "om-be"
        IMAGE_TAG = "v1.0.${env.BUILD_NUMBER}"
        ACR_REGISTRY = "crodmsdevd6a2.azurecr.io"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} ."
                sh "docker tag ${DOCKER_IMAGE}:${IMAGE_TAG} ${ACR_REGISTRY}/${DOCKER_IMAGE}:${IMAGE_TAG}"
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'acrCredentials', usernameVariable: 'ACR_USER', passwordVariable: 'ACR_PASS')]) {
                    sh "docker login ${ACR_REGISTRY} -u ${ACR_USER} -p ${ACR_PASS}"
                    sh "docker push ${ACR_REGISTRY}/${DOCKER_IMAGE}:${IMAGE_TAG}"
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'azureCredentials', usernameVariable: 'AZURE_USER', passwordVariable: 'AZURE_PASS')]) {
                        sh "az login -u ${AZURE_USER} -p ${AZURE_PASS}"
                        sh "az aks get-credentials --name <your-aks-cluster-name> --resource-group <your-aks-resource-group> --overwrite-existing"
                    }

                    // Replace the image in the manifest file with the new image from ACR
                    sh "sed -i 's|<your-image-placeholder>|${ACR_REGISTRY}/${DOCKER_IMAGE}:${IMAGE_TAG}|g' k8s-manifest.yaml"

                    // Apply the manifest file to deploy to the AKS cluster
                    sh "kubectl apply -f k8s-manifest.yaml"
                }
            }
        }
    }
}
