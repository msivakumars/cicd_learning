# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "demo-server" {
  ami = "ami-0f403e3180720dd7e"
  instance_type = "t2.micro"
  key_name = "dpp"
  security_groups = [ "Sample_SG"]
}

resource "aws_security_group" "demo-sg" {
  name        = "Sample_SG"
  description = "Example security group"

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "ssh-port"
  }
}
