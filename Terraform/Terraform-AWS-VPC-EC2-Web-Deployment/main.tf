provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["137112412989"] # Amazon official owner ID
}

# --- VPC and Networking ---

# 1. VPC Creation
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-VPC"
  }
}

# 2. Internet Gateway (IGW) and association
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-IGW"
  }
}

# 3. Subnets (1 Public, 2 Private in different AZs)

# Public Subnet (AZ A)
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true # Required for the public EC2 instance
  tags = {
    Name = "Public Subnet - AZ A"
  }
}

# Private Subnet A (AZ B)
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "Private Subnet A - AZ B"
  }
}

# Private Subnet B (AZ C)
resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = "${var.aws_region}c"
  tags = {
    Name = "Private Subnet B - AZ C"
  }
}

# --- Routing ---

# Public Route Table: Routes internet-bound traffic through the IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "Public Route Table"
  }
}

# Associate Public Route Table with the Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# --- Security Group for SSH Access ---

# 4. Security Group
resource "aws_security_group" "ssh_access" {
  name        = "ssh-access-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  # Ingress Rule: Allow SSH (Port 22) from anywhere (0.0.0.0/0)
  ingress {
    description = "SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress Rule: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-SSH-Access"
  }
}

# --- EC2 Instance ---

# 5. EC2 Instance (in public subnet)
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  # This setting ensures the instance gets a Public IP address
  associate_public_ip_address = true

  tags = {
    Name = "my-WebServer"
  }
}
