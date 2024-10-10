provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name                 = "dademo-${random_pet.random.id}"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "demo" {
  name       = "dademo-${random_pet.random.id}"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "Demo"
  }
}

resource "aws_security_group" "rds" {
  name   = "dademo-${random_pet.random.id}-rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["192.80.0.0/16"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Demo"
  }
}

resource "aws_db_parameter_group" "demo" {
  name   = "dademo-${random_pet.random.id}"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

provider "random" {}

resource "random_pet" "random" {
  length = 1
}

resource "aws_db_instance" "demo" {
  identifier             = "${var.db_name}-${random_pet.random.id}"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "14"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.demo.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.demo.name
  publicly_accessible    = var.publicly_accessible
  skip_final_snapshot    = true
}

module "vpc_vpc-endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "5.13.0"
  create = "true"

  vpc_id = module.vpc.vpc_id
  create_security_group      = true
  security_group_name_prefix = "justin-vpc-endpoints"
  security_group_description = "VPC endpoint security group"
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from VPC"
      cidr_blocks = [module.vpc.vpc_cidr_block]
    }
  }


}
