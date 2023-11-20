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
access_key = ""
secret_key = ""
  
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
    from_port         =  0
    to_port           = 65535
    protocol          = "tcp"
    cidr_blocks        = ["0.0.0.0/0"]
  }

  # Regras de saida permitem o tráfego necessário para a aplicação
   ingress{
    from_port         =  0
    to_port           = 65535
    protocol          = "tcp"
    cidr_blocks        = ["0.0.0.0/0"]
  }
}


resource "aws_subnet" "app_subnet" {
  count               = 1
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
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro" 
  key_name = "tst"
  subnet_id = aws_subnet.app_subnet[0].id  
  security_groups =[aws_security_group.app_security_group.id]
  
  tags = {
    Name = "Terraform Ansible Python"
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
