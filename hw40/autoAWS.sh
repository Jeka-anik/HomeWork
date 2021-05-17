#!/bin/bash
aws ec2 create-launch-template \
    --launch-template-name TemplateForHWDevOps \
    --version-description TestTempate \
    --launch-template-data '{"NetworkInterfaces":[{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-07dc962540ad535eb"],"SubnetId":"subnet-b537eece"}],"ImageId":"ami-0ed17ff3d78e74700","InstanceType":"t3.micro","TagSpecifications":[{"ResourceType":"instance","Tags":[{"Key":"olololo","Value":"DevOpsDos-01"}]}]}'

aws autoscaling create-auto-scaling-group --auto-scaling-group-name my-asg-devops-HW --launch-template "LaunchTemplateName=TemplateForHWDevOps,Version=1" --min-size 1 --max-size 3 --vpc-zone-identifier "subnet-b537eece,subnet-55e11a18,subnet-29853b40"

aws elbv2 create-load-balancer --name my-load-balancer-DevOps-HW --subnets subnet-b537eece subnet-55e11a18

aws ec2 create-security-group --group-name my-sg --description "Eto save world"
aws ec2 authorize-security-group-ingress --group-id sg-0aed0913dc3a81cbf --protocol tcp --port 22 --cidr 37.214.86.151/24
