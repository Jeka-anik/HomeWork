variable "env"{
    type          = string
    default       = "dev"
}

variable "instance_type"{
    description   = "Instance type"
    #type          = string
    default       = "t2.micro"
}

variable "ami"{
    description   = "Ami"
    type          = string
    default       = "ami-042e8287309f5df03"
}

variable "list_ports"{
    description   = "List of ports"
    type          = map
    default       = {
        "dev" =  ["80", "443", "22"]
        "prod" = ["443"]
    }
}