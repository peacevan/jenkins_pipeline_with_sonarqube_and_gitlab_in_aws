pipeline {
  agent any
  environment {
    AWS_REGION = 'us-east-1'
  }
  options { timestamps() }
  stages {
    stage('Checkout') {
      steps { checkout scm }
    }
    stage('Prereqs') {
      steps {
        sh '''
        echo "Checking prerequisites: terraform, tflint (optional), git"
        command -v terraform >/dev/null 2>&1 || { echo "terraform not found"; exit 1; }
        '''
      }
    }
    stage('Terraform Fmt') {
      steps {
        sh 'terraform fmt -check -diff || true'
      }
    }
    stage('Terraform Init') {
      steps {
        sh 'terraform init -input=false -backend=false'
      }
    }
    stage('Terraform Validate') {
      steps { sh 'terraform validate' }
    }
    stage('TFLint (optional)') {
      steps {
        sh '''
        if command -v tflint >/dev/null 2>&1; then
          tflint || true
        else
          echo "tflint not installed - skipping"
        fi
        '''
      }
    }
    stage('Plan') {
      steps {
        sh 'terraform plan -out=tfplan -input=false'
      }
    }
  }
  post {
    always {
      archiveArtifacts artifacts: 'tfplan', allowEmptyArchive: true
    }
  }
}
