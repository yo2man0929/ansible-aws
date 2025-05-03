#!/bin/bash
#region=ap-southeast-1
region=us-east-1
#region=ap-northeast-1
profile=devops

public_key=$(cat ~/.ssh/id_rsa.pub)

ec2_instances=$(aws --profile $profile --region $region ec2 describe-instances --query 'Reservations[*].Instances[].InstanceId' \
                --profile ele --region $region --output json)


for instance_id in $(echo "$ec2_instances" | jq -r '.[]'); do

    aws ssm --profile $profile --region $region  send-command --document-name "AWS-RunShellScript" \
        --targets "Key=instanceids,Values=$instance_id" \
        --parameters "commands=echo $public_key >> /home/ubuntu/.ssh/authorized_keys" \
        --output json
     aws ssm --profile $profile --region $region  send-command --document-name "AWS-RunShellScript" \
        --targets "Key=instanceids,Values=$instance_id" \
        --parameters "commands=echo $public_key >> /home/ec2-user/.ssh/authorized_keys" \
        --output json
done
