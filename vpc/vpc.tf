provider "aws" {
  access_key = "AKIAIJHNNLD5V5RYIIRQ"
  secret_key = "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"
  region     = "ap-south-1"
}

resource "aws_vpc" "main" {
	
	cidr_block = "10.0.0.0/16"

	tags {
	Name = "main"
	}
}
