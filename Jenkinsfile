pipeline {
  agent any
  environment {
    IMAGE = "malluvkcr7/sci-calc:${env.BUILD_NUMBER}"
  }
  stages {
    stage('Checkout') {
      steps { 
        checkout scm 
      }
    }
    stage('Setup Python') {
      steps {
        dir('sci-calc') {
          sh """
            python3 -m venv venv
            . venv/bin/activate
            pip install -r requirements.txt
          """
        }
      }
    }
    stage('Test') {
      steps {
        dir('sci-calc') {
          sh ". venv/bin/activate && python -m pytest tests/ -v"
        }
      }
    }
    stage('Build Docker Image') {
      steps {
        dir('sci-calc') {
          sh "docker build -t ${IMAGE} ."
        }
      }
    }
    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
          sh "docker push ${IMAGE}"
        }
      }
    }
  }
  post {
    always {
      dir('sci-calc') {
        sh 'rm -rf venv || true'
      }
    }
    success {
      echo 'Pipeline completed successfully!'
    }
    failure {
      echo 'Pipeline failed! Check the logs.'
    }
  }
}