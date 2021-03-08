# Поднять инстанс в us-east-1, поставить туда nginx и создать ami

completed

# Написать скрипт на Python, который будет копировать эту ami в другой регион
aws cli
```
anik@K53:~$ aws ec2 copy-image --source-image-id ami-0e63949dce1827784 --source-region us-east-1 --region eu-north-1 --name "copy My server from Nginx"
{
    "ImageId": "ami-0547cfbf64e538a2a"
}

```
from Python
Using file *copyAmi.py*
# Создать vpc, сделать 3 сабнеты (паблик, изолированную и бэкенд)
```json
my vpc:
anik@K53:~$ aws ec2 describe-vpcs
{
    "Vpcs": [
        {
            "CidrBlock": "172.31.0.0/16",
            "DhcpOptionsId": "dopt-4b632131",
            "State": "available",
            "VpcId": "vpc-a067c6dd",
            "OwnerId": "658683390959",
            "InstanceTenancy": "default",
            "CidrBlockAssociationSet": [
                {
                    "AssociationId": "vpc-cidr-assoc-5255e73d",
                    "CidrBlock": "172.31.0.0/16",
                    "CidrBlockState": {
                        "State": "associated"
                    }
                }
            ],
            "IsDefault": true
        },
        {
            "CidrBlock": "10.0.0.0/16",
            "DhcpOptionsId": "dopt-4b632131",
            "State": "available",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959",
            "InstanceTenancy": "default",
            "Ipv6CidrBlockAssociationSet": [
                {
                    "AssociationId": "vpc-cidr-assoc-02989b6f52729f4e6",
                    "Ipv6CidrBlock": "2600:1f18:1652:6700::/56",
                    "Ipv6CidrBlockState": {
                        "State": "associated"
                    },
                    "NetworkBorderGroup": "us-east-1",
                    "Ipv6Pool": "Amazon"
                }
            ],
            "CidrBlockAssociationSet": [
                {
                    "AssociationId": "vpc-cidr-assoc-0b069c81f9b4fd1e8",
                    "CidrBlock": "10.0.0.0/16",
                    "CidrBlockState": {
                        "State": "associated"
                    }
                }
            ],
            "IsDefault": false,
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "my-vpc-forDos01"
                }
            ]
        }
    ]
}

```
my subnet:
```json
anik@K53:~$ aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-0ece4f7c6f8f3c668"
{
    "Subnets": [
        {
            "AvailabilityZone": "us-east-1a",
            "AvailabilityZoneId": "use1-az6",
            "AvailableIpAddressCount": 251,
            "CidrBlock": "10.0.65.0/24",
            "DefaultForAz": false,
            "MapPublicIpOnLaunch": false,
            "MapCustomerOwnedIpOnLaunch": false,
            "State": "available",
            "SubnetId": "subnet-0b1222320ec32ced1",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959",
            "AssignIpv6AddressOnCreation": false,
            "Ipv6CidrBlockAssociationSet": [],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "mySubnetPrivate"
                }
            ],
            "SubnetArn": "arn:aws:ec2:us-east-1:658683390959:subnet/subnet-0b1222320ec32ced1"
        },
        {
            "AvailabilityZone": "us-east-1c",
            "AvailabilityZoneId": "use1-az2",
            "AvailableIpAddressCount": 250,
            "CidrBlock": "10.0.194.0/24",
            "DefaultForAz": false,
            "MapPublicIpOnLaunch": false,
            "MapCustomerOwnedIpOnLaunch": false,
            "State": "available",
            "SubnetId": "subnet-0ec8749e0bd164311",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959",
            "AssignIpv6AddressOnCreation": false,
            "Ipv6CidrBlockAssociationSet": [],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "MySubnetDB3"
                }
            ],
            "SubnetArn": "arn:aws:ec2:us-east-1:658683390959:subnet/subnet-0ec8749e0bd164311"
        },
        {
            "AvailabilityZone": "us-east-1b",
            "AvailabilityZoneId": "use1-az1",
            "AvailableIpAddressCount": 250,
            "CidrBlock": "10.0.129.0/24",
            "DefaultForAz": false,
            "MapPublicIpOnLaunch": false,
            "MapCustomerOwnedIpOnLaunch": false,
            "State": "available",
            "SubnetId": "subnet-067cd92c7538b7f2f",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959",
            "AssignIpv6AddressOnCreation": false,
            "Ipv6CidrBlockAssociationSet": [],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "mySubnetPrivate2"
                }
            ],
            "SubnetArn": "arn:aws:ec2:us-east-1:658683390959:subnet/subnet-067cd92c7538b7f2f"
        },
        {
            "AvailabilityZone": "us-east-1a",
            "AvailabilityZoneId": "use1-az6",
            "AvailableIpAddressCount": 251,
            "CidrBlock": "10.0.66.0/24",
            "DefaultForAz": false,
            "MapPublicIpOnLaunch": false,
            "MapCustomerOwnedIpOnLaunch": false,
            "State": "available",
            "SubnetId": "subnet-039795cd2701f43de",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959",
            "AssignIpv6AddressOnCreation": false,
            "Ipv6CidrBlockAssociationSet": [],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "MySubnetDB1"
                }
            ],
            "SubnetArn": "arn:aws:ec2:us-east-1:658683390959:subnet/subnet-039795cd2701f43de"
        },
        {
            "AvailabilityZone": "us-east-1b",
            "AvailabilityZoneId": "use1-az1",
            "AvailableIpAddressCount": 251,
            "CidrBlock": "10.0.192.0/24",
            "DefaultForAz": false,
            "MapPublicIpOnLaunch": true,
            "MapCustomerOwnedIpOnLaunch": false,
            "State": "available",
            "SubnetId": "subnet-053eebfec7b5d8eb0",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959",
            "AssignIpv6AddressOnCreation": false,
            "Ipv6CidrBlockAssociationSet": [],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "mySubnetPublic3"
                }
            ],
            "SubnetArn": "arn:aws:ec2:us-east-1:658683390959:subnet/subnet-053eebfec7b5d8eb0"
        },
        {
            "AvailabilityZone": "us-east-1b",
            "AvailabilityZoneId": "use1-az1",
            "AvailableIpAddressCount": 251,
            "CidrBlock": "10.0.130.0/24",
            "DefaultForAz": false,
            "MapPublicIpOnLaunch": false,
            "MapCustomerOwnedIpOnLaunch": false,
            "State": "available",
            "SubnetId": "subnet-06ef3be7076a5adae",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959",
            "AssignIpv6AddressOnCreation": false,
            "Ipv6CidrBlockAssociationSet": [],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "MySubnetDB2"
                }
            ],
            "SubnetArn": "arn:aws:ec2:us-east-1:658683390959:subnet/subnet-06ef3be7076a5adae"
        },
        {
            "AvailabilityZone": "us-east-1a",
            "AvailabilityZoneId": "use1-az6",
            "AvailableIpAddressCount": 251,
            "CidrBlock": "10.0.64.0/24",
            "DefaultForAz": false,
            "MapPublicIpOnLaunch": true,
            "MapCustomerOwnedIpOnLaunch": false,
            "State": "available",
            "SubnetId": "subnet-08f7613c57e274b42",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959",
            "AssignIpv6AddressOnCreation": false,
            "Ipv6CidrBlockAssociationSet": [],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "mySubnetPublic"
                }
            ],
            "SubnetArn": "arn:aws:ec2:us-east-1:658683390959:subnet/subnet-08f7613c57e274b42"
        },
        {
            "AvailabilityZone": "us-east-1b",
            "AvailabilityZoneId": "use1-az1",
            "AvailableIpAddressCount": 251,
            "CidrBlock": "10.0.193.0/24",
            "DefaultForAz": false,
            "MapPublicIpOnLaunch": true,
            "MapCustomerOwnedIpOnLaunch": false,
            "State": "available",
            "SubnetId": "subnet-02d8a82d50d06e636",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959",
            "AssignIpv6AddressOnCreation": false,
            "Ipv6CidrBlockAssociationSet": [],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "mySubnetPrivate3"
                }
            ],
            "SubnetArn": "arn:aws:ec2:us-east-1:658683390959:subnet/subnet-02d8a82d50d06e636"
        },
        {
            "AvailabilityZone": "us-east-1b",
            "AvailabilityZoneId": "use1-az1",
            "AvailableIpAddressCount": 251,
            "CidrBlock": "10.0.128.0/24",
            "DefaultForAz": false,
            "MapPublicIpOnLaunch": true,
            "MapCustomerOwnedIpOnLaunch": false,
            "State": "available",
            "SubnetId": "subnet-0ac290306fe87a9de",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959",
            "AssignIpv6AddressOnCreation": false,
            "Ipv6CidrBlockAssociationSet": [],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "mySubnetPublic2"
                }
            ],
            "SubnetArn": "arn:aws:ec2:us-east-1:658683390959:subnet/subnet-0ac290306fe87a9de"
        }
    ]
}

```
# Приаттачить internet gateway к этой vpc
```json
anik@K53:~$ aws ec2 describe-nat-gateways
{
    "NatGateways": [
        {
            "CreateTime": "2021-03-05T08:45:06+00:00",
            "DeleteTime": "2021-03-07T08:10:19+00:00",
            "NatGatewayAddresses": [
                {
                    "AllocationId": "eipalloc-00c9373fcc73e0d3c",
                    "NetworkInterfaceId": "eni-0483717758658ac7c",
                    "PrivateIp": "10.0.192.62",
                    "PublicIp": "54.158.230.135"
                }
            ],
            "NatGatewayId": "nat-0f26a52b852a1aea7",
            "State": "deleted",
            "SubnetId": "subnet-053eebfec7b5d8eb0",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "myNATgatewayForMysubnetPublic3"
                }
            ]
        },
        {
            "CreateTime": "2021-03-05T08:44:28+00:00",
            "DeleteTime": "2021-03-07T08:08:56+00:00",
            "NatGatewayAddresses": [
                {
                    "AllocationId": "eipalloc-08fe5202eb23f6d9b",
                    "NetworkInterfaceId": "eni-0ea9d67f3688f255b",
                    "PrivateIp": "10.0.128.110",
                    "PublicIp": "34.238.236.60"
                }
            ],
            "NatGatewayId": "nat-02f6333fd1ad7bfc4",
            "State": "deleted",
            "SubnetId": "subnet-0ac290306fe87a9de",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "myNATgatewayForMysubnetPublic2"
                }
            ]
        },
        {
            "CreateTime": "2021-03-05T08:43:24+00:00",
            "DeleteTime": "2021-03-07T08:08:40+00:00",
            "NatGatewayAddresses": [
                {
                    "AllocationId": "eipalloc-0b05ffb1b3f98cf72",
                    "NetworkInterfaceId": "eni-089b1bc59c59018cc",
                    "PrivateIp": "10.0.64.229",
                    "PublicIp": "72.44.50.93"
                }
            ],
            "NatGatewayId": "nat-0ecc29dec014b50e9",
            "State": "deleted",
            "SubnetId": "subnet-08f7613c57e274b42",
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "myNATgatewayForMysubnetPublic1"
                }
            ]
        }
    ]
}
```
 смортри файл _./media/myNATgateway.png_

# Настроить маршрутизацию между этими сабнетами
```json
anik@K53:~$ aws ec2 describe-route-tables
{
    "RouteTables": [
        {
            "Associations": [
                {
                    "Main": false,
                    "RouteTableAssociationId": "rtbassoc-074e191a81987aca4",
                    "RouteTableId": "rtb-07a2e20c6810d9289",
                    "SubnetId": "subnet-02d8a82d50d06e636",
                    "AssociationState": {
                        "State": "associated"
                    }
                }
            ],
            "PropagatingVgws": [],
            "RouteTableId": "rtb-07a2e20c6810d9289",
            "Routes": [
                {
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                },
                {
                    "DestinationCidrBlock": "0.0.0.0/0",
                    "NatGatewayId": "nat-0f26a52b852a1aea7",
                    "Origin": "CreateRoute",
                    "State": "blackhole"
                },
                {
                    "DestinationIpv6CidrBlock": "2600:1f18:1652:6700::/56",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                }
            ],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "RouteTableforDos01Private2"
                }
            ],
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959"
        },
        {
            "Associations": [
                {
                    "Main": false,
                    "RouteTableAssociationId": "rtbassoc-0341c09197b525564",
                    "RouteTableId": "rtb-0a48789cf23b4ce5d",
                    "SubnetId": "subnet-0b1222320ec32ced1",
                    "AssociationState": {
                        "State": "associated"
                    }
                }
            ],
            "PropagatingVgws": [],
            "RouteTableId": "rtb-0a48789cf23b4ce5d",
            "Routes": [
                {
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                },
                {
                    "DestinationCidrBlock": "0.0.0.0/0",
                    "NatGatewayId": "nat-0ecc29dec014b50e9",
                    "Origin": "CreateRoute",
                    "State": "blackhole"
                },
                {
                    "DestinationIpv6CidrBlock": "2600:1f18:1652:6700::/56",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                }
            ],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "RouteTableforDos01Private1"
                }
            ],
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959"
        },
        {
            "Associations": [
                {
                    "Main": false,
                    "RouteTableAssociationId": "rtbassoc-09b1e6d43dc91561f",
                    "RouteTableId": "rtb-07d3ccd8bb3d7c4f5",
                    "SubnetId": "subnet-067cd92c7538b7f2f",
                    "AssociationState": {
                        "State": "associated"
                    }
                }
            ],
            "PropagatingVgws": [],
            "RouteTableId": "rtb-07d3ccd8bb3d7c4f5",
            "Routes": [
                {
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                },
                {
                    "DestinationCidrBlock": "0.0.0.0/0",
                    "NatGatewayId": "nat-02f6333fd1ad7bfc4",
                    "Origin": "CreateRoute",
                    "State": "blackhole"
                },
                {
                    "DestinationIpv6CidrBlock": "2600:1f18:1652:6700::/56",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                }
            ],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "RouteTableforDos01Private3"
                }
            ],
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959"
        },
        {
            "Associations": [
                {
                    "Main": true,
                    "RouteTableAssociationId": "rtbassoc-07922c2c0d47689a3",
                    "RouteTableId": "rtb-0ecf286ab35d58ae8",
                    "AssociationState": {
                        "State": "associated"
                    }
                },
                {
                    "Main": false,
                    "RouteTableAssociationId": "rtbassoc-01f48ef9b4e31edab",
                    "RouteTableId": "rtb-0ecf286ab35d58ae8",
                    "SubnetId": "subnet-053eebfec7b5d8eb0",
                    "AssociationState": {
                        "State": "associated"
                    }
                },
                {
                    "Main": false,
                    "RouteTableAssociationId": "rtbassoc-0bcaac7c5a14d92d9",
                    "RouteTableId": "rtb-0ecf286ab35d58ae8",
                    "SubnetId": "subnet-08f7613c57e274b42",
                    "AssociationState": {
                        "State": "associated"
                    }
                },
                {
                    "Main": false,
                    "RouteTableAssociationId": "rtbassoc-0c31f0bccf5f44c81",
                    "RouteTableId": "rtb-0ecf286ab35d58ae8",
                    "SubnetId": "subnet-0ac290306fe87a9de",
                    "AssociationState": {
                        "State": "associated"
                    }
                }
            ],
            "PropagatingVgws": [],
            "RouteTableId": "rtb-0ecf286ab35d58ae8",
            "Routes": [
                {
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                },
                {
                    "DestinationCidrBlock": "0.0.0.0/0",
                    "GatewayId": "igw-0b20ab86b2c4c815b",
                    "Origin": "CreateRoute",
                    "State": "active"
                },
                {
                    "DestinationIpv6CidrBlock": "2600:1f18:1652:6700::/56",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                }
            ],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "myRouteTableForDos01"
                }
            ],
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959"
        },
        {
            "Associations": [
                {
                    "Main": false,
                    "RouteTableAssociationId": "rtbassoc-03755f71ebb068a0c",
                    "RouteTableId": "rtb-0bab6617792eef3e2",
                    "SubnetId": "subnet-0ec8749e0bd164311",
                    "AssociationState": {
                        "State": "associated"
                    }
                },
                {
                    "Main": false,
                    "RouteTableAssociationId": "rtbassoc-0e46658090ec5cf3a",
                    "RouteTableId": "rtb-0bab6617792eef3e2",
                    "SubnetId": "subnet-06ef3be7076a5adae",
                    "AssociationState": {
                        "State": "associated"
                    }
                },
                {
                    "Main": false,
                    "RouteTableAssociationId": "rtbassoc-0de2b0b879e8575a8",
                    "RouteTableId": "rtb-0bab6617792eef3e2",
                    "SubnetId": "subnet-039795cd2701f43de",
                    "AssociationState": {
                        "State": "associated"
                    }
                }
            ],
            "PropagatingVgws": [],
            "RouteTableId": "rtb-0bab6617792eef3e2",
            "Routes": [
                {
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                },
                {
                    "DestinationIpv6CidrBlock": "2600:1f18:1652:6700::/56",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                }
            ],
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "RouteTableDB"
                }
            ],
            "VpcId": "vpc-0ece4f7c6f8f3c668",
            "OwnerId": "658683390959"
        },
        {
            "Associations": [
                {
                    "Main": true,
                    "RouteTableAssociationId": "rtbassoc-5fbd212e",
                    "RouteTableId": "rtb-43012d3d",
                    "AssociationState": {
                        "State": "associated"
                    }
                }
            ],
            "PropagatingVgws": [],
            "RouteTableId": "rtb-43012d3d",
            "Routes": [
                {
                    "DestinationCidrBlock": "172.31.0.0/16",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                },
                {
                    "DestinationCidrBlock": "0.0.0.0/0",
                    "GatewayId": "igw-4f3d2934",
                    "Origin": "CreateRoute",
                    "State": "active"
                }
            ],
            "Tags": [],
            "VpcId": "vpc-a067c6dd",
            "OwnerId": "658683390959"
        }
    ]
}
```

# Развернуть бастион в паблик сети и nginx в изолированной
```
anik@K53:~$ aws ec2 describe-instances
{
    "Reservations": [
        {
            "Groups": [],
            "Instances": [
                {
                    "AmiLaunchIndex": 0,
                    "ImageId": "ami-0915bcb5fa77e4892",
                    "InstanceId": "i-0a25a043376249ea4",
                    "InstanceType": "t2.micro",
                    "KeyName": "hw41",
                    "LaunchTime": "2021-03-07T09:02:41+00:00",
                    "Monitoring": {
                        "State": "disabled"
                    },
                    "Placement": {
                        "AvailabilityZone": "us-east-1b",
                        "GroupName": "",
                        "Tenancy": "default"
                    },
                    "PrivateDnsName": "ip-10-0-129-85.ec2.internal",
                    "PrivateIpAddress": "10.0.129.85",
                    "ProductCodes": [],
                    "PublicDnsName": "",
                    "State": {
                        "Code": 80,
                        "Name": "stopped"
                    },
                    "StateTransitionReason": "User initiated (2021-03-07 09:06:07 GMT)",
                    "SubnetId": "subnet-067cd92c7538b7f2f",
                    "VpcId": "vpc-0ece4f7c6f8f3c668",
                    "Architecture": "x86_64",
                    "BlockDeviceMappings": [
                        {
                            "DeviceName": "/dev/xvda",
                            "Ebs": {
                                "AttachTime": "2021-03-05T09:41:01+00:00",
                                "DeleteOnTermination": true,
                                "Status": "attached",
                                "VolumeId": "vol-08cd1627d532aecac"
                            }
                        }
                    ],
                    "ClientToken": "",
                    "EbsOptimized": false,
                    "EnaSupport": true,
                    "Hypervisor": "xen",
                    "NetworkInterfaces": [
                        {
                            "Attachment": {
                                "AttachTime": "2021-03-05T09:41:01+00:00",
                                "AttachmentId": "eni-attach-02c86114ce098e68d",
                                "DeleteOnTermination": true,
                                "DeviceIndex": 0,
                                "Status": "attached",
                                "NetworkCardIndex": 0
                            },
                            "Description": "Primary network interface",
                            "Groups": [
                                {
                                    "GroupName": "SecurityGroupSSH",
                                    "GroupId": "sg-03ece1edcd91c0d77"
                                }
                            ],
                            "Ipv6Addresses": [],
                            "MacAddress": "02:46:b3:d4:ab:95",
                            "NetworkInterfaceId": "eni-0a472ecd20e8efc99",
                            "OwnerId": "658683390959",
                            "PrivateIpAddress": "10.0.129.85",
                            "PrivateIpAddresses": [
                                {
                                    "Primary": true,
                                    "PrivateIpAddress": "10.0.129.85"
                                }
                            ],
                            "SourceDestCheck": true,
                            "Status": "in-use",
                            "SubnetId": "subnet-067cd92c7538b7f2f",
                            "VpcId": "vpc-0ece4f7c6f8f3c668",
                            "InterfaceType": "interface"
                        }
                    ],
                    "RootDeviceName": "/dev/xvda",
                    "RootDeviceType": "ebs",
                    "SecurityGroups": [
                        {
                            "GroupName": "SecurityGroupSSH",
                            "GroupId": "sg-03ece1edcd91c0d77"
                        }
                    ],
                    "SourceDestCheck": true,
                    "StateReason": {
                        "Code": "Client.UserInitiatedShutdown",
                        "Message": "Client.UserInitiatedShutdown: User initiated shutdown"
                    },
                    "Tags": [
                        {
                            "Key": "Name",
                            "Value": "InstansInPrivateSubnet"
                        },
                        {
                            "Key": "name",
                            "Value": "InstansForPrivateNetwork"
                        }
                    ],
                    "VirtualizationType": "hvm",
                    "CpuOptions": {
                        "CoreCount": 1,
                        "ThreadsPerCore": 1
                    },
                    "CapacityReservationSpecification": {
                        "CapacityReservationPreference": "open"
                    },
                    "HibernationOptions": {
                        "Configured": false
                    },
                    "MetadataOptions": {
                        "State": "applied",
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
            "ReservationId": "r-0944c2454ee525b64"
        },
        {
            "Groups": [],
            "Instances": [
                {
                    "AmiLaunchIndex": 0,
                    "ImageId": "ami-0915bcb5fa77e4892",
                    "InstanceId": "i-0f16ef3fb7a76c901",
                    "InstanceType": "t2.micro",
                    "KeyName": "hw41",
                    "LaunchTime": "2021-03-07T09:06:15+00:00",
                    "Monitoring": {
                        "State": "disabled"
                    },
                    "Placement": {
                        "AvailabilityZone": "us-east-1c",
                        "GroupName": "",
                        "Tenancy": "default"
                    },
                    "PrivateDnsName": "ip-10-0-194-10.ec2.internal",
                    "PrivateIpAddress": "10.0.194.10",
                    "ProductCodes": [],
                    "PublicDnsName": "",
                    "State": {
                        "Code": 16,
                        "Name": "running"
                    },
                    "StateTransitionReason": "",
                    "SubnetId": "subnet-0ec8749e0bd164311",
                    "VpcId": "vpc-0ece4f7c6f8f3c668",
                    "Architecture": "x86_64",
                    "BlockDeviceMappings": [
                        {
                            "DeviceName": "/dev/xvda",
                            "Ebs": {
                                "AttachTime": "2021-03-05T09:43:52+00:00",
                                "DeleteOnTermination": true,
                                "Status": "attached",
                                "VolumeId": "vol-04131ce4377792f0d"
                            }
                        }
                    ],
                    "ClientToken": "",
                    "EbsOptimized": false,
                    "EnaSupport": true,
                    "Hypervisor": "xen",
                    "NetworkInterfaces": [
                        {
                            "Attachment": {
                                "AttachTime": "2021-03-05T09:43:51+00:00",
                                "AttachmentId": "eni-attach-01166153a3fce061a",
                                "DeleteOnTermination": true,
                                "DeviceIndex": 0,
                                "Status": "attached",
                                "NetworkCardIndex": 0
                            },
                            "Description": "Primary network interface",
                            "Groups": [
                                {
                                    "GroupName": "SecurityGroupForSubnetDB",
                                    "GroupId": "sg-0dad3638af1f1096b"
                                }
                            ],
                            "Ipv6Addresses": [],
                            "MacAddress": "12:6e:8e:e6:df:6b",
                            "NetworkInterfaceId": "eni-01eea498aa5946975",
                            "OwnerId": "658683390959",
                            "PrivateIpAddress": "10.0.194.10",
                            "PrivateIpAddresses": [
                                {
                                    "Primary": true,
                                    "PrivateIpAddress": "10.0.194.10"
                                }
                            ],
                            "SourceDestCheck": true,
                            "Status": "in-use",
                            "SubnetId": "subnet-0ec8749e0bd164311",
                            "VpcId": "vpc-0ece4f7c6f8f3c668",
                            "InterfaceType": "interface"
                        }
                    ],
                    "RootDeviceName": "/dev/xvda",
                    "RootDeviceType": "ebs",
                    "SecurityGroups": [
                        {
                            "GroupName": "SecurityGroupForSubnetDB",
                            "GroupId": "sg-0dad3638af1f1096b"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Tags": [
                        {
                            "Key": "Name",
                            "Value": "InstansInSubnetDB"
                        },
                        {
                            "Key": "name",
                            "Value": "InstansForDB-Subnet"
                        }
                    ],
                    "VirtualizationType": "hvm",
                    "CpuOptions": {
                        "CoreCount": 1,
                        "ThreadsPerCore": 1
                    },
                    "CapacityReservationSpecification": {
                        "CapacityReservationPreference": "open"
                    },
                    "HibernationOptions": {
                        "Configured": false
                    },
                    "MetadataOptions": {
                        "State": "applied",
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
            "ReservationId": "r-0eaddb0d40ad3fc36"
        },
        {
            "Groups": [],
            "Instances": [
                {
                    "AmiLaunchIndex": 0,
                    "ImageId": "ami-042e8287309f5df03",
                    "InstanceId": "i-0df4f6c0b53cf3129",
                    "InstanceType": "t2.micro",
                    "KeyName": "hw41",
                    "LaunchTime": "2021-03-07T09:01:06+00:00",
                    "Monitoring": {
                        "State": "disabled"
                    },
                    "Placement": {
                        "AvailabilityZone": "us-east-1a",
                        "GroupName": "",
                        "Tenancy": "default"
                    },
                    "PrivateDnsName": "ip-10-0-64-112.ec2.internal",
                    "PrivateIpAddress": "10.0.64.112",
                    "ProductCodes": [],
                    "PublicDnsName": "",
                    "PublicIpAddress": "3.85.216.151",
                    "State": {
                        "Code": 16,
                        "Name": "running"
                    },
                    "StateTransitionReason": "",
                    "SubnetId": "subnet-08f7613c57e274b42",
                    "VpcId": "vpc-0ece4f7c6f8f3c668",
                    "Architecture": "x86_64",
                    "BlockDeviceMappings": [
                        {
                            "DeviceName": "/dev/sda1",
                            "Ebs": {
                                "AttachTime": "2021-03-07T09:01:07+00:00",
                                "DeleteOnTermination": true,
                                "Status": "attached",
                                "VolumeId": "vol-09e61c8d09ed5e5cf"
                            }
                        }
                    ],
                    "ClientToken": "3485e02f-acac-63e7-94d4-e341fe599195",
                    "EbsOptimized": false,
                    "EnaSupport": true,
                    "Hypervisor": "xen",
                    "NetworkInterfaces": [
                        {
                            "Association": {
                                "IpOwnerId": "amazon",
                                "PublicDnsName": "",
                                "PublicIp": "3.85.216.151"
                            },
                            "Attachment": {
                                "AttachTime": "2021-03-07T09:01:06+00:00",
                                "AttachmentId": "eni-attach-00b97d83ef725e392",
                                "DeleteOnTermination": true,
                                "DeviceIndex": 0,
                                "Status": "attached",
                                "NetworkCardIndex": 0
                            },
                            "Description": "",
                            "Groups": [
                                {
                                    "GroupName": "MySecGroupForBastion",
                                    "GroupId": "sg-0a6edfd31fc1fd3bc"
                                }
                            ],
                            "Ipv6Addresses": [],
                            "MacAddress": "0e:7d:d8:4b:2b:d5",
                            "NetworkInterfaceId": "eni-06a3cc7a0f2f54053",
                            "OwnerId": "658683390959",
                            "PrivateIpAddress": "10.0.64.112",
                            "PrivateIpAddresses": [
                                {
                                    "Association": {
                                        "IpOwnerId": "amazon",
                                        "PublicDnsName": "",
                                        "PublicIp": "3.85.216.151"
                                    },
                                    "Primary": true,
                                    "PrivateIpAddress": "10.0.64.112"
                                }
                            ],
                            "SourceDestCheck": true,
                            "Status": "in-use",
                            "SubnetId": "subnet-08f7613c57e274b42",
                            "VpcId": "vpc-0ece4f7c6f8f3c668",
                            "InterfaceType": "interface"
                        }
                    ],
                    "RootDeviceName": "/dev/sda1",
                    "RootDeviceType": "ebs",
                    "SecurityGroups": [
                        {
                            "GroupName": "MySecGroupForBastion",
                            "GroupId": "sg-0a6edfd31fc1fd3bc"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Tags": [
                        {
                            "Key": "aws:ec2launchtemplate:id",
                            "Value": "lt-0404f75d96c8519ae"
                        },
                        {
                            "Key": "aws:ec2launchtemplate:version",
                            "Value": "1"
                        },
                        {
                            "Key": "aws:autoscaling:groupName",
                            "Value": "AutoScalingforBastion"
                        }
                    ],
                    "VirtualizationType": "hvm",
                    "CpuOptions": {
                        "CoreCount": 1,
                        "ThreadsPerCore": 1
                    },
                    "CapacityReservationSpecification": {
                        "CapacityReservationPreference": "open"
                    },
                    "HibernationOptions": {
                        "Configured": false
                    },
                    "MetadataOptions": {
                        "State": "applied",
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
            "RequesterId": "940372691376",
            "ReservationId": "r-0363f9877e7a1e8dd"
        }
    ]
}
```

# Проверить доступ из бастиона к изолированной сети

проверил доступ, есть подключение по ssh с Instans Bastion в instans который находится in private network
Смотреть файл _./media/bastion.png_

```bash
ubuntu@ip-10-0-128-189:~/.ssh$ sudo chmod 755 hw41.pem
ubuntu@ip-10-0-128-189:~/.ssh$ ssh -i "hw41.pem" ec2-user@10.0.129.85

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
[ec2-user@ip-10-0-129-85 ~]$ 
```

# Создать RDS с мастер-мастер репликацией, и мастер-слейв репликацией



# Написать скрипт на Python, который будет делать бэкап базы по расписанию и хранить на s3
* Развернуть наше Flask/Django приложение в lambda(данные(json) можно читать из s3 или базы)
