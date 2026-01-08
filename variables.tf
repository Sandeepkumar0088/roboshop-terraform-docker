variable "ami"{
    default = "ami-045a533d19c34eeb6"
}
# "ami-09c813fb71547fc4f"


variable "instance_type"{
    default = "t3.micro"
}

variable "vpc_security_group_ids" {
    default = [ "sg-039df2e97e51ebc17" ]
}


variable "zone_id" {
    default = "Z09354891N46GVLJSDZH0"
}

variable "components" {
    default = {
      frontend  = { ports = { ssh = 22, frontend = 80 }
        instance_type  = "t3.micro"
        root_volume_size = 25
      }
      mongodb   = { ports = { ssh = 22, mongodb = 27017 }
        instance_type  = "t3.micro"
      }
      catalogue = { ports = { ssh = 22, app = 8080 }
        instance_type  = "t3.micro"
        root_volume_size = 25
      }
      redis     = { ports = { ssh = 22, redis = 6379 }
        instance_type  = "t3.micro"
      }
      user      = { ports = { ssh = 22, app = 8080 }
        instance_type  = "t3.micro"
        root_volume_size = 25
      }
      cart      = { ports = { ssh = 22, app = 8080 }
        instance_type  = "t3.micro"
        root_volume_size = 25
      }
      mysql     = { ports = { ssh = 22, mysql = 3306 }
        instance_type  = "t3.micro"
      }
      shipping  = { ports = { ssh = 22, app = 8080 }
        instance_type  = "t3.micro"
        root_volume_size = 25
      }
      rabbitmq  = { ports = { ssh = 22, rabbitmq = 5672 }
        instance_type  = "t3.micro"
      }
      payment   = { ports = { ssh = 22, app = 8080 }
        instance_type  = "t3.micro"
        root_volume_size = 25
      }
    }
}
