# Создать iam юзера с пермишнами - создание инстансов, security groups и s3 бакетов (создать свою полиси и приаттачить ее к юзеру)

Completed


# Развернуть инстанс открыв 22 и 80,443 порты наружу

Completed


# Используя ансибл установить nginx и проверить доступность со своего компьютера

Using playbook.yml

# Создать s3 бакет, разместить в него веб-сайт, проверить доступность со своего компьютера

Completed

# Установить AWS SDK и через aws-cli повторить пункт 2 и 4, используя креды юзера, которого создали

```bash
 curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

anik@K53:~$ aws --version
aws-cli/2.1.28 Python/3.8.8 Linux/5.8.0-43-generic exe/x86_64.ubuntu.20 prompt/off

```

```bash
anik@K53:~$ aws configure --profile prod
AWS Access Key ID [None]: AKIAZSXEW5PX7KGJJ4NY
AWS Secret Access Key [None]: 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
Default region name [None]: eu-north-1
Default output format [None]: json
anik@K53:~$ aws s3 ls --profile prod
2021-02-24 14:09:29 dos01.student
2021-02-19 21:41:50 myfirstbucketevgen

```
```
anik@K53:~$ aws ec2 run-instances --image-id ami-09b44b5f46219ee86 --count 1 --instance-type t3.micro --key-name HW31 --security-group-ids sg-00b81cc9a62e8787b --subnet-id subnet-29853b40 --profile qa
{
    "Groups": [],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-09b44b5f46219ee86",
            "InstanceId": "i-0c3d03b5954cd1c52",
            "InstanceType": "t3.micro",
            "KeyName": "HW31",
            "LaunchTime": "2021-02-25T18:29:36+00:00",
            "Monitoring": {
                "State": "disabled"
            },
            "Placement": {
                "AvailabilityZone": "eu-north-1a",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-172-31-23-224.eu-north-1.compute.internal",
            "PrivateIpAddress": "172.31.23.224",
            "ProductCodes": [],
            "PublicDnsName": "",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "StateTransitionReason": "",
            "SubnetId": "subnet-29853b40",
            "VpcId": "vpc-dc10a9b5",
            "Architecture": "x86_64",
            "BlockDeviceMappings": [],
            "ClientToken": "a45797ef-85c0-481a-aae7-db09a932e9cc",
            "EbsOptimized": false,
            "EnaSupport": true,
            "Hypervisor": "xen",
            "NetworkInterfaces": [
                {
                    "Attachment": {
                        "AttachTime": "2021-02-25T18:29:36+00:00",
                        "AttachmentId": "eni-attach-0d832380b256b8cac",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attaching"
                    },
                    "Description": "",
                    "Groups": [
                        {
                            "GroupName": "launch-wizard-2",
                            "GroupId": "sg-00b81cc9a62e8787b"
                        }
                    ],
                    "Ipv6Addresses": [],
                    "MacAddress": "06:9a:e3:69:cf:76",
                    "NetworkInterfaceId": "eni-0899fecec5312c4a7",
                    "OwnerId": "658683390959",
                    "PrivateDnsName": "ip-172-31-23-224.eu-north-1.compute.internal",
                    "PrivateIpAddress": "172.31.23.224",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateDnsName": "ip-172-31-23-224.eu-north-1.compute.internal",
                            "PrivateIpAddress": "172.31.23.224"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-29853b40",
                    "VpcId": "vpc-dc10a9b5",
                    "InterfaceType": "interface"
                }
            ],
            "RootDeviceName": "/dev/sda1",
            "RootDeviceType": "ebs",
            "SecurityGroups": [
                {
                    "GroupName": "launch-wizard-2",
                    "GroupId": "sg-00b81cc9a62e8787b"
                }
            ],
            "SourceDestCheck": true,
            "StateReason": {
                "Code": "pending",
                "Message": "pending"
            },
            "VirtualizationType": "hvm",
            "CpuOptions": {
                "CoreCount": 1,
                "ThreadsPerCore": 2
            },
            "CapacityReservationSpecification": {
                "CapacityReservationPreference": "open"
            },
            "MetadataOptions": {
                "State": "pending",
                "HttpTokens": "optional",
                "HttpPutResponseHopLimit": 1,
                "HttpEndpoint": "enabled"
            },
            "EnclaveOptions": {
                "Enabled": false
            }
        }
    ],
    "OwnerId": "658683390959",
    "ReservationId": "r-035004f2cb52b9186"
}
```

Create s3 bucket static web-site

```
anik@K53:~$ aws s3 mb s3://etomybucket
make_bucket: etomybucket
anik@K53:~$ aws s3 website s3://etomybucket/ --index-document index.html --error-document error.html
anik@K53:~$ aws s3 cp ~//HomeWork/hw39/index.html s3://etomybucket
upload: HomeWork/hw39/index.html to s3://etomybucket/index.html 
anik@K53:~$ aws s3 cp ~//HomeWork/hw39/error.html s3://etomybucket
upload: HomeWork/hw39/error.html to s3://etomybucket/error.html
```

security policy for web-site-bucket

```json
{
    "Version": "2012-10-17",
    "Id": "Policy1614668223880",
    "Statement": [
        {
            "Sid": "Stmt1614668218520",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::etomybucket/*"
        }
    ]
}
```
ссылка для проверки 
http://etomybucket.s3-website.eu-north-1.amazonaws.com/

# Написать баш скрипт, который будет делать пункт 2 и 4

using createinstans.sh

