provider "aws" {
    access_key = "**********"
    secret_key = "************"
    region = "us-east-1"
}
resource "aws_placement_group" "test" {
  name     = "test"
  strategy = "cluster"
}
resource "aws_launch_template" "mywebserverforhw43" {
  name_prefix   = "mywebserverforhw43"
  image_id      = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  key_name = "hw41"
  # security_group_names = "sg-0acc06198675a4bf7" 
}
resource "aws_autoscaling_group" "myASGforHW43" {
  name                      = "myASGforHW43"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  placement_group           = aws_placement_group.test.id
  # launch_configuration      = aws_launch_configuration.ubuntu.name
  vpc_zone_identifier       = ["subnet-4dea796c","subnet-e2d008d3"]
  launch_template {
    id      = aws_launch_template.mywebserverforhw43.id
    version = "$Latest"
  }
  initial_lifecycle_hook {
    name                 = "foobar"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 1000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

#     notification_metadata = <<EOF
# {
#   "foo": "bar"
# }
# EOF

    #notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
    #role_arn                = "arn:aws:iam::123456789012:role/S3Access"
  }

  tag {
    key                 = "Name"
    value               = "MyASGforHW43"
    propagate_at_launch = true
  }

  timeouts {
    delete = "5m"
  }

  tag {
    key                 = "Owner"
    value               = "Evgen"
    propagate_at_launch = false
  }
}
