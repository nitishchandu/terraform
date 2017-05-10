#define the cloud provider
provider "aws" {
  region     = "ap-south-1"
}

#this block creates vpc with the mentioned cidr and tag details
resource "aws_vpc" "main" {
  
  cidr_block = "192.169.0.0/16"
  instance_tenancy = "default"

  tags {
    Name = "test_vpc"
  }

}

#displays vpc ID on console
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

#creates public subnet and default route table
resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "192.169.0.0/16"
  availability_zone = "ap-south-1a"

  tags {
    Name = "Public_Subnet"
  }
}

#displays subnet ID on console
output "subnet_id"{
  value = "${aws_subnet.public.id}"
}

#creates igw
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "igw_test_vpc"
  }
}

#creates new route table and adds igw to route table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "public_route"
  }
}

#route table association
resource "aws_route_table_association" "public" {
   subnet_id = "${aws_subnet.public.id}"
   route_table_id = "${aws_route_table.public.id}"
}

#adding security group
resource "aws_security_group" "test_vpc_sg" {
  name = "test_vpc_sg"
  description = "allow all traffic"

  ingress {
   from_port = 0
   to_port = 65535
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
   from_port = 0
   to_port = 65535
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags {
   Name = "test_SG"
  }
}

#add ec2 instance
resource "aws_instance" "test_ec2"{
  ami = "ami-cdbdd7a2"
  subnet_id = "${aws_subnet.public.id}"
  instance_type = "t2.micro"
 
  tags {
    Name = "test_ec2_instance"
  }
}
