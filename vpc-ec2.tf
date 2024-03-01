provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAUNK3TL6WY2ICODVP"  
  secret_key = "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"
}


# main.tf

module "my_vpc" {
  source = "./ec2-vpc"
  
  vpc_name                = "ibp-vpc"
  vpc_cidr_block          = "10.0.0.0/16"
  subnet_app_cidr_block   = "10.0.1.0/24"
  subnet_db_cidr_block    = "10.0.2.0/24"
  key_name                = "ubuntutest"
  instance_app_disk_size  = "20"
  instance_db_disk_size   = "20"
  instance_app_disk_type  = "gp2"
  instance_db_disk_type   = "gp2"
  subnet_app_name         = "ibp-app-subet"
  subnet_db_name          = "ibp-db-sunnet"
  subnet_app_zone         = "ap-south-1a"
  subnet_db_zone          = "ap-south-1b"
  instance_type_app       = "t2.large"
  instance_type_db        = "t2.large"
  ami_id_app              = "ami-03f4878755434977f"
  ami_id_db               = "ami-03f4878755434977f"
  instance_name_app       = "ibp-app"
  instance_name_db        = "ibp-db"
  securty_group_app       = "ibp-app-securty group"
  securty_group_db        = "ibp-db-securty group"
  private_ip_app          = "10.0.1.23"
  private_ip_db           = "10.0.2.23"
}
