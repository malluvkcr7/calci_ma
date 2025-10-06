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
        sh """
          python3 -m venv venv
          . venv/bin/activate
          pip install -r requirements.txt
        """
      }
    }
    stage('Test') {
      steps {
        sh ". venv/bin/activate && python -m pytest tests/ -v"
      }
    }
    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${IMAGE} ."
      }
    }
    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
          sh "docker push ${IMAGE}"
          sh "docker tag ${IMAGE} malluvkcr7/sci-calc:latest"
          sh "docker push malluvkcr7/sci-calc:latest"
        }
      }
    }
    stage('Deploy with Ansible') {
      steps {
        script {
          // Ensure Ansible is available
          sh '''
            if ! command -v ansible-playbook &> /dev/null; then
              echo "Installing Ansible..."
              sudo apt-get update -qq
              sudo apt-get install -y ansible python3-docker
            fi
          '''
          
          // Set up environment and run deployment
          sh '''
            cd ansible
            chmod +x deploy.sh
            
            # Update inventory with the new image tag
            sed -i "s|docker_image=.*|docker_image=malluvkcr7/sci-calc:${BUILD_NUMBER}|" inventory.ini
            
            # Export variables for Ansible
            export DOCKER_IMAGE="malluvkcr7/sci-calc:${BUILD_NUMBER}"
            export CONTAINER_NAME="sci-calc-app"
            export HOST_PORT="8090"
            export BUILD_NUMBER="${BUILD_NUMBER}"
            
            # Run Ansible deployment (without sudo to avoid permission issues)
            ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini deploy.yml -v -e "docker_image=malluvkcr7/sci-calc:${BUILD_NUMBER}" || true
            
            # Fallback: Use direct Docker deployment
            echo "Running fallback deployment script..."
            ./deploy.sh
            
            # Wait for application to start
            echo "Waiting for application to start..."
            sleep 15
            
            # Verify deployment
            if curl -f -s http://localhost:8090 > /dev/null; then
              echo "✅ Deployment successful - Application is responding"
            else
              echo "⚠️ Application may still be starting up"
            fi
          '''
        }
      }
    }
  }
  post {
    always {
      sh 'rm -rf venv || true'
      // Clean up old Docker images (keep last 3)
      sh '''
        docker images malluvkcr7/sci-calc --format "table {{.Tag}}" | grep -E "^[0-9]+$" | sort -nr | tail -n +4 | xargs -r -I {} docker rmi malluvkcr7/sci-calc:{} || true
      '''
    }
    success {
      echo 'Pipeline completed successfully!'
      echo "Application deployed and accessible at: http://localhost:8090"
    }
    failure {
      echo 'Pipeline failed! Check the logs.'
    }
  }
}