pipeline{
    agent any
    tools{
        terraform 'terraform'
    }
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages{
        stage ('checkout'){
            steps{
                git branch: 'main', url:'https://github.com/KR-Nitesh/ec2_terra_jen.git'
            }
        }
        stage ('setup environment'){
            steps {
                sh'''
                    terraform init
                    terraform destroy --auto-approve
                '''
            }
        }
    }
}