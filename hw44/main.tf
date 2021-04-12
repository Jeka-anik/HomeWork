provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/home/anik/.aws/credentials"
}

locals {
    project_name = "${var.env} environment"
}
data "aws_ami" "my-ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

   owners = ["099720109477"] # Canonical
}

resource "aws_instance" "demo_app" {
  count         = 1
  ami           = var.ami
  instance_type = var.instance_type
  #iam_instance_profile = "ecs-demo-role"
  vpc_security_group_ids = [aws_security_group.my_test.id]
  #user_data = file("./nginx.tmpl")
  subnet_id       = "subnet-22769a13"
  user_data = templatefile("./user_data.sh.tmpl", {
      team  = "DevOps"
      tools = ["Terraform", "Jinja2"]
  })
  tags = {
    Name = "Demo"
  }
  depends_on = [
    aws_instance.demo_db,
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "demo_db" {
  #count                = 1
  ami           = var.ami
  instance_type = var.instance_type
  #iam_instance_profile = "ecs-demo-role"
  vpc_security_group_ids = [aws_security_group.my_test.id]
  #user_data = file("./nginx.tmpl")
  subnet_id       = "subnet-22769a13"
#   user_data = templatefile("./user_data.sh.tmpl", {
#       team  = "DevOps"
#       tools = ["Terraform", "Jinja2"]
#   })
  tags = {
    Name = "Demo"
  }
}

 resource "aws_security_group" "my_test" {
  name = "My Security group"

  dynamic "ingress" {
    for_each = lookup(var.list_ports, "dev")
      content {
          from_port   = ingress.value
          to_port     = ingress.value
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    
  tags = {
    Name  = "My Security Group"
    Owner = "Evgen"
    Project_name = local.project_name
  }
}

# locals {
#   # Ids for multiple sets of EC2 instances, merged together
#   instance_ids = list(aws_instance.demo_db.id, aws_instance.demo_app.id)
# }

# output "list_of_instances" {
#     value = local.instance_ids
# }

# output "instance_db" {
#     value = aws_instance.demo_db.id
# }

# resource "aws_instance" "demo_test" {
#   count =  var.env=="dev" ? 1 : 0
#   provider = aws.Frankfurt
#   ami = "ami-0767046d1677be5a0"
#   instance_type = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.my_sg.id]
# }


# resource "aws_security_group" "my_sg" {
#   provider = aws.Frankfurt
#   name        = "My_security_group"
#   description = "My_security_group_description"
# #  vpc_id      = aws_vpc.main.id

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

# egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

output "ami-ouput" {
    description = "My ami output"
    value = data.aws_ami.my-ubuntu.id
}

output "ami-ouput-creation-date" {
    description = "My ami output creation date"
    value = data.aws_ami.my-ubuntu.creation_date
}