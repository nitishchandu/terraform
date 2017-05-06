provider "aws" {
  region     = "ap-south-1"
}

resource "aws_vpc" "main" {
  
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags {
    Name = "test_vpc"
  }

}

  output "vpc_id" {
    value = "${aws_vpc.main.id}"
  }
