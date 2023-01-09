pipeline {
  agent any

  environment {
    dockerImageName = 'eosadchiy/nodejs-app-nginx'
    dockerRegistryCredentials = 'docker-hub'
  }

  stages {
    stage('Clone repository') {
      steps {
        script {
          checkout scm
        }
      }
    }

    stage('Build image') {
      steps {
        script {
          app = docker.build(dockerImageName)
        }
      }
    }

    stage('Push image to the Docker Hub') {
      steps {
        script {
          docker.withRegistry('', dockerRegistryCredentials) {
            app.push("${env.BUILD_NUMBER}")
            app.push('latest')
          }
        }
      }
    }
  }
}
