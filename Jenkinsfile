pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub'
        IMAGE_NAME = 'srikanth4402/moneesh_uncle'
        TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/smangali-loyaltymethods/demo-docker-build2.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${TAG}", ".")
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.image("${IMAGE_NAME}:${TAG}").push()
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop & remove existing container if running
                    sh '''
                    if [ "$(docker ps -q -f name=${IMAGE_NAME})" ]; then
                        docker stop ${IMAGE_NAME} && docker rm ${IMAGE_NAME}
                    fi

                    // Run new container on port 8080
                    docker run -d --name ${IMAGE_NAME} -p 8080:80 ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest
                    '''
                }
            }
        }
    }
}

