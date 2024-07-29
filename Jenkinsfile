pipeline {
    agent any

    environment {
        TERRAFORM_DIR = 'development/verifiers/lambda_based_verifier'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/SofiyaTkachenia/code-hero-deployment'
            }
        }
        stage('Terraform Init') {
            steps {
                dir("${env.TERRAFORM_DIR}") {
                    sh '''
                        terraform init -reconfigure \
                            -backend-config=config.s3.tfbackend
                    '''
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                dir("${env.TERRAFORM_DIR}") {
                    sh '''
                        terraform apply \
                            -var-file=dev.tfvars \
                            --auto-approve
                    '''
                }
            }
        }
    }
}

