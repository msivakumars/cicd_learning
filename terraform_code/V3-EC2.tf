# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
}

# Create VPC
resource "aws_vpc" "demo-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
    Name = "demo-vpc"

    }
}

# Create Subnet-01
resource "aws_subnet" "demo-subnet-01" {
    vpc_id     = aws_vpc.demo-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags = {
    Name = "demo-subnet-01"

    }
}

# Create Subnet-02
resource "aws_subnet" "demo-subnet-02" {
    vpc_id     = aws_vpc.demo-vpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags = {
    Name = "demo-subnet-02"

    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "demo-igw" {
    vpc_id = aws_vpc.demo-vpc.id

    tags = {
        Name = "demo-igw"
    }
}

# Create Route Table
resource "aws_route_table" "demo-route-table" {
    vpc_id = aws_vpc.demo-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo-igw.id
    }

    tags = {
    Name = "demo-route-table"
    }
}

# Associate Route Table with Subnet-01
resource "aws_route_table_association" "demo-route-table-association-01" {
    subnet_id      = aws_subnet.demo-subnet-01.id
    route_table_id = aws_route_table.demo-route-table.id
}

# Associate Route Table with Subnet-02
resource "aws_route_table_association" "demo-route-table-association-02" {
    subnet_id      = aws_subnet.demo-subnet-02.id
    route_table_id = aws_route_table.demo-route-table.id
}
resource "aws_instance" "demo-server" {
    ami = "ami-0f403e3180720dd7e"
    instance_type = "t2.micro"
    key_name = "dpp"
    security_groups = [ aws_security_group.demo-sg.id]
    subnet_id     = aws_subnet.demo-subnet-01.id

    tags = {
        Name = "demo-server"
    }
}

resource "aws_security_group" "demo-sg" {
    name        = "Sample_SG"
    description = "Example security group"
    vpc_id = aws_vpc.demo-vpc.id
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
