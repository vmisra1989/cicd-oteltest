pipeline {
    agent any

    environment {
        IMAGE_NAME = "vmisra1989/my-otel-contrib"
        IMAGE_TAG = "latest"
        KUBECONFIG = '/Users/vinay/.kube/config'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/vmisra1989/cicd-oteltest.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $IMAGE_NAME:$IMAGE_TAG ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                      docker push $IMAGE_NAME:$IMAGE_TAG
                    """
                }
            }
        }
        stage('Deploy to Minikube') {
            
            steps {
                script {
                    sh 'kubectl create namespace otel || echo "Namespace already exists"'
                
                    sh 'kubectl config current-context'
                    sh 'kubectl cluster-info'
                    sh 'kubectl apply -f k8s/otel-config.yaml'
                    sh 'kubectl apply -f k8s/otel-collector-deployment.yaml'
                    sh 'kubectl apply -f k8s/otel-service.yaml'
                }

            }
        }
    }
}