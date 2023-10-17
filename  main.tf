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
  cidr_block          = "10.0.0.0/16"  
  
  tags = {
  Name = "Rede.terraform"
  }
} 

resource "aws_subnet" "app_subnet" {
  count               = 1
  vpc_id              = aws_vpc.teste.id
  cidr_block          = "10.0.0.0/16"
  
  
    tags = {
    Name = "subrede.terraform"
   }
}


resource "aws_instance" "app_server" {
  count         = 1
  ami           = "ami-041feb57c611358bd"
  instance_type = "t2.micro" 
  key_name = "amazon-linux"

  subnet_id = aws_subnet.app_subnet[0].id  

  tags = {
    Name = "Server.terraform"
  }

}    



#resource "aws_eip" "elástico" {
 # instance = aws_instance.app_server.id
#}