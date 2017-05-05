#provider "aws" {
#  access_key = "${var.aws_access_key}"
#  secret_key = "${var.aws_secret_key}"
#  region     = "us-east-1"
#}

# Create a web server
#resource "Prabhakar" "Iac" {
#  name               = "Pariwar_Dreams"
#  ami_id = "ami-b63769a1"
#  instance_type = "t2.micro"
#}


provider "aws" {
  access_key = "xxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxx"
  region     = "us-east-1"
}

resource "aws_instance" "main" {
  ami           = "ami-b63769a1"
  instance_type = "t2.micro"
}

variable "vpc_id" {}

data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}

resource "aws_subnet" "example" {
  vpc_id            = "${data.aws_vpc.selected.id}"
  availability_zone = "us-west-1a"
  cidr_block        = "${cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)}"
}
