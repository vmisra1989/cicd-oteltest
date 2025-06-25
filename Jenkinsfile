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

        stage('Check Image on Docker Hub') {
            steps {
                script {
                    def fullImage = "${IMAGE_NAME}:${IMAGE_TAG}"
                    def result = sh(script: "docker pull ${fullImage}", returnStatus: true)
                    imageExists = (result == 0)
                    
                    if (imageExists) {
                        echo "Image ${fullImage} already exists on Docker Hub. Skipping build and push."
                    } else {
                        echo "Image ${fullImage} not found. Will build and push."
                    }
                }
            }
        }

        stage('Build Docker Image') {
            when {
                expression { return !imageExists }
            }
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            when {
                expression { return !imageExists }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }


        stage('Deploy to Minikube') {
            
            steps {
                
                sh 'kubectl config current-context'
                sh 'kubectl cluster-info'
                sh 'kubectl apply -f k8s/deployment.yaml'


            }
        }
    }
}