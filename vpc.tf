resource "aws_vpc" "syslog-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.tag_vpc
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.syslog-vpc.id
  cidr_block = var.cidr_block_subnet_1
  availability_zone = var.availability_zone_1

  tags = {
    Name = var.tag_subnet_1
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.syslog-vpc.id
  cidr_block = var.cidr_block_subnet_2
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.tag_subnet_2
    Description = "subnet for syslog-vpc"
  }
}

resource "aws_security_group" "syslog_sg" {
  name        = "syslog-sg"
  description = "Security group for syslog servers"

  vpc_id = aws_vpc.syslog-vpc.id

  ingress {
    from_port   = 514
    to_port     = 514
    protocol    = "tcp"
    cidr_blocks = ["10.120.96.0/24", "10.120.97.0/24"]
  }

  egress {
    from_port   = 514
    to_port     = 514
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "syslog-sg"
    Description = "syslog security group"
  }
}
