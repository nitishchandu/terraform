provider "aws" {
  access_key = "AKIAIJHNNLD5V5RYIIRQ"
  secret_key = "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"
  region     = "ap-south-1"
}

resource "aws_instance" "main" {
  ami           = "ami-cdbdd7a2"
  instance_type = "t2.micro"
}
