pipeline{
    agent any
    tools{
        Terraform"terraform"
    }
    environment{
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY_ID = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages{
        stage ('checkout'){
            steps{
                git(url: 'https://github.com/KR-Nitesh/ec2_terra_jen.git', credentialsId: 'githubKR-Nitesh')
            }
        }
        stage ('setup environment'){
            steps {
                sh'''
                    terraform init
                    terraform apply --auto-approve
                '''
            }
        }
    }
}