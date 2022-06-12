// Pipeline as Code
pipeline{
    agent any
    // Environment Variables //
    environment{
        ENVIRONMENT_NAME       = 'BRKSEC'
        PROD_ENV_ID            = '2353'
        AWS_ACCESS_KEY_ID      = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY  = credentials('aws-secret-key')
        PROD_AWS_REGION        = 'us-east-2'
        PROD_AWS_AZ1           = 'us-east-2a'
        PROD_AWS_AZ2           = 'us-east-2b'
        FTD_USERNAME           = credentials('ftd-username')
        FTD_PASSWORD           = credentials('ftd-password')
        AWS_SSH_KEY_NAME       = 'ftd_key'
    }
    stages{
        // This stage will run Terraform Apply when "Deploy Env" is added to the commit message //
        stage('Build Environment'){
           when{
                allOf{
                    branch "main"
                    changelog "Deploy Env*"
                }
            }
           steps{
                echo "Building Environment"
                sh 'terraform get -update'
                sh 'terraform init -upgrade'
                sh 'terraform apply -auto-approve \
                -var="aws_access_key=$AWS_ACCESS_KEY_ID" \
                -var="aws_secret_key=$AWS_SECRET_ACCESS_KEY" \
                -var="env_name=$ENVIRONMENT_NAME" \
                -var="env_id=$PROD_ENV_ID" \
                -var="region=$PROD_AWS_REGION" \
                -var="aws_az1=$PROD_AWS_AZ1" \
                -var="aws_az2=$PROD_AWS_AZ2" \
                -var="ftd_pass=$FTD_FTD_USERNAME" \
                -var="ftd_pass=$FTD_PASSWORD" \
                -var="key_name=$AWS_SSH_KEY_NAME"'
            }
        }
        // This stage will destroy the environment when "Destroy Environment" is added to the commit message
        stage('Destroy Environment'){
            when{
                allOf{
                    branch "main"
                    changelog "Destroy Environment*"
                }
            }

            steps{
                echo "Destroying Environment"
                sh 'terraform destroy -auto-approve \
                -var="aws_access_key=$AWS_ACCESS_KEY_ID" \
                -var="aws_secret_key=$AWS_SECRET_ACCESS_KEY" \
                -var="env_name=$ENVIRONMENT_NAME" \
                -var="env_id=$PROD_ENV_ID" \
                -var="region=$PROD_AWS_REGION" \
                -var="aws_az1=$PROD_AWS_AZ1" \
                -var="aws_az2=$PROD_AWS_AZ2" \
                -var="ftd_pass=$FTD_FTD_USERNAME" \
                -var="ftd_pass=$FTD_PASSWORD" \
                -var="key_name=$AWS_SSH_KEY_NAME"'
            }
        }
    }
}