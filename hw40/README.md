# Повторить самостоятельно демо, которое показывал на уроке(создать launch template, асг, балансировщик, security groups и развернуть приложение)
1)создать launch template
```
aws ec2 create-launch-template \
    --launch-template-name TemplateForHWDevOps \
    --version-description TestTempate \
    --launch-template-data '{"NetworkInterfaces":[{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-07dc962540ad535eb"],"SubnetId":"subnet-b537eece"}],"ImageId":"ami-0ed17ff3d78e74700","InstanceType":"t3.micro","TagSpecifications":[{"ResourceType":"instance","Tags":[{"Key":"olololo","Value":"DevOpsDos-01"}]}]}'
```
Вывод:
```
{
    "LaunchTemplate": {
        "LaunchTemplateId": "lt-00192889d06d64510",
        "LaunchTemplateName": "TemplateForHWDevOps",
        "CreateTime": "2021-03-03T13:44:36+00:00",
        "CreatedBy": "arn:aws:iam::658683390959:root",
        "DefaultVersionNumber": 1,
        "LatestVersionNumber": 1
    }
}
```
2)acr
```
aws autoscaling create-auto-scaling-group --auto-scaling-group-name my-asg-devops-HW --launch-template "LaunchTemplateName=TemplateForHWDevOps,Version=1" --min-size 1 --max-size 3 --vpc-zone-identifier "subnet-b537eece,subnet-55e11a18,subnet-29853b40"
```

3)creates an Internet-facing Application Load Balancer

```
aws elbv2 create-load-balancer --name my-load-balancer-DevOps-HW --subnets subnet-b537eece subnet-55e11a18
```
Вывод
```
{
    "LoadBalancers": [
        {
            "LoadBalancerArn": "arn:aws:elasticloadbalancing:eu-north-1:658683390959:loadbalancer/app/my-load-balancer-DevOps-HW/eb92b043822625cc",
            "DNSName": "my-load-balancer-DevOps-HW-134969005.eu-north-1.elb.amazonaws.com",
            "CanonicalHostedZoneId": "Z23TAZ6LKFMNIO",
            "CreatedTime": "2021-03-03T14:33:13.110000+00:00",
            "LoadBalancerName": "my-load-balancer-DevOps-HW",
            "Scheme": "internet-facing",
            "VpcId": "vpc-dc10a9b5",
            "State": {
                "Code": "provisioning"
            },
            "Type": "application",
            "AvailabilityZones": [
                {
                    "ZoneName": "eu-north-1c",
                    "SubnetId": "subnet-55e11a18",
                    "LoadBalancerAddresses": []
                },
                {
                    "ZoneName": "eu-north-1b",
                    "SubnetId": "subnet-b537eece",
                    "LoadBalancerAddresses": []
                }
            ],
            "SecurityGroups": [
                "sg-0b4d0268"
            ],
            "IpAddressType": "ipv4"
        }
    ]
}
```
4) security groups
```
anik@K53:~$ curl https://checkip.amazonaws.com
37.214.86.151
anik@K53:~$ aws ec2 create-security-group --group-name my-sg --description "Eto save world"
{
    "GroupId": "sg-0aed0913dc3a81cbf"
}
anik@K53:~$ aws ec2 authorize-security-group-ingress --group-id sg-0aed0913dc3a81cbf --protocol tcp --port 22 --cidr 37.214.86.151/24
anik@K53:~$ aws ec2 describe-security-groups --group-ids sg-0aed0913dc3a81cbf
{
    "SecurityGroups": [
        {
            "Description": "Eto save world",
            "GroupName": "my-sg",
            "IpPermissions": [
                {
                    "FromPort": 22,
                    "IpProtocol": "tcp",
                    "IpRanges": [
                        {
                            "CidrIp": "37.214.86.0/24"
                        }
                    ],
                    "Ipv6Ranges": [],
                    "PrefixListIds": [],
                    "ToPort": 22,
                    "UserIdGroupPairs": []
                }
            ],
            "OwnerId": "658683390959",
            "GroupId": "sg-0aed0913dc3a81cbf",
            "IpPermissionsEgress": [
                {
                    "IpProtocol": "-1",
                    "IpRanges": [
                        {
                            "CidrIp": "0.0.0.0/0"
                        }
                    ],
                    "Ipv6Ranges": [],
                    "PrefixListIds": [],
                    "UserIdGroupPairs": []
                }
            ],
            "VpcId": "vpc-dc10a9b5"
        }
    ]
}


```


# Настроить ASG на скейлинг в зависимости от нагрузки и сделать оповещения на почту

настроено
```
AWS Notifications <no-reply@sns.amazonaws.com>
12:48 (16 минут назад)
кому: я

You have chosen to subscribe to the topic:
arn:aws:sns:eu-north-1:658683390959:Evgen

To confirm this subscription, click or visit the link below (If this was in error no action is necessary):
```

```
Subscription confirmed!
You have successfully subscribed.

Your subscription's id is:
arn:aws:sns:eu-north-1:658683390959:Evgen:a468c0f6-a14f-45c0-bbde-cb9a3158d458


```
# Сделать нагрузочное тестирование и посмотреть: как увеличиваются и уменьшаются инстансы

Completed. Смотреть папку media

# Обернуть 1 пункт в баш скрипт

run file *autoAWS.sh*
