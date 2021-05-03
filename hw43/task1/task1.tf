provider "aws" {
    access_key = "***********"
    secret_key = "**********"
    region = "us-east-1"
}
resource "aws_launch_template" "mywebserverforhw43" {
  name = "mywebserverforhw43"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 8
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "none"
  }

  cpu_options {
    core_count       = 2
    threads_per_core = 2
  }

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_termination = true

  ebs_optimized = true

#   elastic_gpu_specifications {
#     type = "test"
#   }

#   elastic_inference_accelerator {
#     type = "eia1.medium"
#   }

  iam_instance_profile {
    name = "mywebserverforhw43"
  }

  image_id = "ami-042e8287309f5df03"

  instance_initiated_shutdown_behavior = "terminate"

#   instance_market_options {
#     market_type = "spot"
#   }

  instance_type = "t2.micro"

  #kernel_id = "test"

  key_name = "hw41"

#   license_specification {
#     license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
#   }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  monitoring {
    enabled = false
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  placement {
    availability_zone = "us-east-1a"
  }

#   ram_disk_id = "test"

  vpc_security_group_ids = ["sg-0fa9509f3ede61481"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "MytestInTerraform"
    }
  }

  user_data = filebase64("run.sh")
}
