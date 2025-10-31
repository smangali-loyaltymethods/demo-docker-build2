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
                withCredentials([
                    usernamePassword(
                        credentialsId: "${DOCKERHUB_CREDENTIALS}",
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
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
                    sh '''
                        # Stop and remove old container if it exists
                        if [ "$(docker ps -aq -f name=moneesh_uncle)" ]; then
                            docker stop moneesh_uncle || true
                            docker rm moneesh_uncle || true
                        fi

                        # Run a new container on port 9090:4040
                        docker run -d --restart=always --name moneesh_uncle -p 9090:80 ${IMAGE_NAME}:${TAG}
                    '''
                }
            }
        }

        stage('Verify Container') {
            steps {
                script {
                    sh '''
                        echo "Running containers:"
                        docker ps
                    '''
                }
            }
        }
    }
}

