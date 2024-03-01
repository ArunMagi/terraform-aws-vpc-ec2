# vpc_module.tf

# Variables
variable "vpc_cidr_block" {}
variable "subnet_app_cidr_block" {}
variable "subnet_db_cidr_block" {}
variable "key_name" {}
variable "instance_app_disk_size" {}
variable "instance_db_disk_size" {}
variable "instance_app_disk_type" {}
variable "instance_db_disk_type" {}
variable "subnet_app_zone" {}
variable "subnet_db_zone" {}
variable "instance_type_app" {}
variable "instance_type_db" {}
variable "ami_id_app" {}
variable "ami_id_db" {}
variable "instance_name_app" {}
variable "instance_name_db" {}
variable "vpc_name" {}
variable "subnet_app_name"{}
variable "subnet_db_name" {}
variable "securty_group_app" {}
variable "securty_group_db" {}
variable "private_ip_app" {}
variable "private_ip_db" {}
# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

#app server securty group
resource "aws_security_group" "app_sg" {
  vpc_id      = aws_vpc.main.id
  name        = var.securty_group_app
  description = "Example security group with SSH and HTTP allow rules"


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from anywhere
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic to all destinations
  }

}

#db server securty group
resource "aws_security_group" "db_sg" {
  vpc_id      = aws_vpc.main.id
  name        = var.securty_group_db
  description = "Example security group with SSH and HTTP allow rules"


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from anywhere
  }
    ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic to all destinations
  }


}



# Subnets
resource "aws_subnet" "subnet_app" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_app_cidr_block
  availability_zone = var.subnet_app_zone  # Modify this according to your preference

  tags = {
    Name = var.subnet_app_name
  }
}

resource "aws_subnet" "subnet_db" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_db_cidr_block
  availability_zone = var.subnet_db_zone  # Modify this according to your preference

  tags = {
    Name = var.subnet_db_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MainVPC-Gateway"
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# Associate Route Table with Subnets
resource "aws_route_table_association" "subnet_app_association" {
  subnet_id      = aws_subnet.subnet_app.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet_db_association" {
  subnet_id      = aws_subnet.subnet_db.id
  route_table_id = aws_route_table.public.id
}


resource "aws_instance" "app-server" {
  ami           = var.ami_id_app       
  instance_type = var.instance_type_app      
  subnet_id     = aws_subnet.subnet_app.id    
  key_name      = var.key_name 
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  private_ip    = var.private_ip_app
   user_data = file("app-script.sh")

  root_block_device {
    volume_size = var.instance_app_disk_size
    volume_type = var.instance_app_disk_type
  }

  tags = {
    Name = var.instance_name_app 
  }
}

resource"aws_instance""db-server" {
  ami           = var.ami_id_db          
  instance_type = var.instance_type_db    
  subnet_id     = aws_subnet.subnet_db.id  
  key_name      = var.key_name
  private_ip    = var.private_ip_db
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  associate_public_ip_address = true
  user_data = file("db-script.sh")

  root_block_device {
    volume_size = var.instance_db_disk_size
    volume_type = var.instance_db_disk_type
  }

  tags = {
    Name = var.instance_name_db
  }
}

