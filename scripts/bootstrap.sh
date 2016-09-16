#!/bin/bash

region=$(curl http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')

yum update -y
yum install -y httpd24 php56 php56-mysqlnd

service httpd start

cd /home/ec2-user/
aws s3 cp s3://webappsrc/app.zip . --region "$region"
unzip app.zip -d /var/www/html/

curl https://amazon-ssm-us-west-2.s3.amazonaws.com/latest/linux_amd64/amazon-ssm-agent.rpm -o amazon-ssm-agent.rpm
yum install -y amazon-ssm-agent.rpm
