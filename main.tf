provider "aws" {
    region = "us-east-1"
}

variable "server_port" {
    description = "Port used to serve requests"
    default     = 8080
}

resource "aws_instance" "example" {
    ami           = "ami-40d28157"
    instance_type = "t2.micro"
    subnet_id     = "subnet-6b804622"
    vpc_security_group_ids = ["${aws_security_group.instance.id}"]
    tags {
        Name = "mxwest-terraform-example"
    }
    user_data =  <<-EOF
        #!/usr/bin/env bash 
        echo "Hello, World" > index.html
        nohup busyboix httpd -f -p 8080 &
        EOF
}

resource "aws_security_group" "instance" {
    name        = "allow_all"
    description = "Allow all inbound traffic"
    vpc_id      = "vpc-46453b21"
    ingress {
        from_port   = "${var.server_port}"
        to_port     = "${var.server_port}"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

