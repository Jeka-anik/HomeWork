import boto3
session1 = boto3.client('ec2',region_name='eu-north-1')

response = session1.copy_image(
   Name='myAmiInNginx',
   Description='Copied this AMI from region us-east-1',
   SourceImageId='ami-0e63949dce1827784',
   SourceRegion='us-east-1'
)