terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
access_key = "AKIA2QPWAV2K63O2X7QK"
secret_key = "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"
  
}


resource "aws_vpc" "teste" {
  cidr_block = "10.0.0.0/21"
  
  

  tags = {
    Name = "terraform"
  }
} 
resource "aws_instance" "app_server" {
  ami           = "ami-041feb57c611358bd"
  instance_type = "t2.micro"
  subnet_id = "subnet-01f8f79c07c0a3ad2"
  key_name = "amazon-linux"
  
  tags = {
    Name = "terraform"
  }
}

resource "aws_eip" "elástico" {
  instance = aws_instance.app_server.id
}