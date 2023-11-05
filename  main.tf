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
  cidr_block         = "10.0.0.0/16"  
  
  tags = {
  Name = "Rede.terraform"
  }
} 

resource "aws_security_group" "app_security_group"{
  name                = "app-security-group"
  description         = "Server.Terraform"
  vpc_id              = aws_vpc.teste.id

# Regras de entrada permitem o tráfego necessário para a aplicação
  ingress{
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks        = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "app_subnet" {
  count               = 3
  vpc_id              = aws_vpc.teste.id
  cidr_block          = "10.0.${count.index}.0/24" 
  availability_zone   = "us-east-1a"
    tags = {
      Name = "subnet-terraform-${count.index + 1}",
      Environment = "subrede.terraform"
   }
}


resource "aws_instance" "app_server" {
  count         = 1
  ami           = "ami-041feb57c611358bd"
  instance_type = "t2.micro" 
  key_name = "tst"
  subnet_id = aws_subnet.app_subnet[0].id  
  security_groups =[aws_security_group.app_security_group.id]
  
  tags = {
    Name = "Server.terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id          = aws_vpc.teste.id
    tags = {
    Name = "internet_igw.terraform"
  }
}

resource "aws_route_table" "public" {
  vpc_id          = aws_vpc.teste.id
  route {
      cidr_block  = "0.0.0.0/0"
      gateway_id  = aws_internet_gateway.igw.id
  }
    tags = {
    Name = "tabela.roteamento-igw.terraform"
  }
}

resource "aws_route_table_association" "public"{
    subnet_id       = aws_subnet.app_subnet[0].id
    route_table_id = aws_route_table.public.id
}

resource "aws_eip" "elástico" {
  instance = aws_instance.app_server[0].id
}