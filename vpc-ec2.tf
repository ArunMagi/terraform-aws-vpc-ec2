provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA3FLD3Y27AQXG2NFU"
  secret_key = "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"
}


# main.tf

module "my_vpc" {
  source = "/home/lap577/arun/terraform-vpc-ec2/ec2-vpc"
  
  vpc_name                = "ibp-vpc"
  vpc_cidr_block          = "10.0.0.0/16"
  subnet_app_cidr_block   = "10.0.1.0/24"
  subnet_db_cidr_block    = "10.0.2.0/24"
  key_name                = "my-keypair"
  instance_app_disk_size  = "20"
  instance_db_disk_size   = "20"
  instance_app_disk_type  = "gp2"
  instance_db_disk_type   = "gp2"
  subnet_app_name         = "ibp-app-subet"
  subnet_db_name          = "ibp-db-sunnet"
  subnet_app_zone         = "ap-south-1a"
  subnet_db_zone          = "ap-south-1b"
  instance_type_app       = "t2.micro"
  instance_type_db        = "t2.micro"
  ami_id_app              = "ami-03f4878755434977f"
  ami_id_db               = "ami-03f4878755434977f"
  instance_name_app       = "ibp-app"
  instance_name_db        = "ibp-db"
}
