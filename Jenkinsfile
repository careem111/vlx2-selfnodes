pipeline{
    agent any

    tools {
        terraform 'Terraform'
    }
    stages{
        stage ('Clone') {
            steps {
                git branch: 'dev', url: "https://github.com/careem111/vlx2-selfnodes.git"
            }
        }
        stage ('Terraform init'){
            steps {
                dir("eks/") {
                        withAWS(credentials: 'aws-kodekloud', region: 'us-east-1'){
                            sh 'terraform init'
                        }
                    }
                }
            }
        stage ('Terraform apply'){
            steps {
                dir("eks/") {
                    withAWS(credentials: 'aws-kodekloud', region: 'us-east-1'){
                        sh 'terraform apply --auto-approve'
                    }
                    }
                }
            }
    }
}