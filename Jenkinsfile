pipeline {
    agent any

    environment {
        IMAGE_NAME = "otel/opentelemetry-collector-k8s"
        IMAGE_TAG = "latest"
        KUBECONFIG = '/Users/vinay/.kube/config'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/vmisra1989/cicd-oteltest.git'
            }
        }
        stage('Deploy to Minikube') {
            
            steps {
                
                sh 'kubectl config current-context'
                sh 'kubectl cluster-info'
                sh 'kubectl apply -f k8s/otel-config.yaml'
                sh 'kubectl apply -f k8s/otel-collector-deployment.yaml'
                sh 'kubectl apply -f k8s/otel-service.yaml'


            }
        }
    }
}