provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "example" {
    ami           = "ami-40d28157"
    instance_type = "t2.micro"
    subnet_id     = "subnet-6b804622"
    tags {
        Name = "mxwest-terraform-example"
    }
}
