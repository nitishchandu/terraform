#define the cloud provider
provider "aws" {
  region     = "ap-south-1"
}

#this block creates vpc with the mentioned cidr and tag details
resource "aws_vpc" "main" {
  
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags {
    Name = "test_vpc"
  }

}

#displays vpc ID on console
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

#creates public subnet
resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags {
    Name = "Public_Subnet"
  }
}
