#bin/bash/
aws ec2 run-instances --image-id ami-09b44b5f46219ee86 --count 1 --instance-type t3.micro --key-name HW31 --security-group-ids sg-00b81cc9a62e8787b --subnet-id subnet-29853b40 
