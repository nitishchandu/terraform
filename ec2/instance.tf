provider "aws" {
  region     = "ap-south-1"
}

resource "aws_instance" "main" {
  ami           = "ami-cdbdd7a2"
  instance_type = "t2.micro"
}
