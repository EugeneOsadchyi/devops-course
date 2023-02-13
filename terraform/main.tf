provider "aws" {
  region  = "eu-west-2"
  profile = "terraform"

  default_tags {
    tags = {
      app      = "DevOps Course"
      terrform = true
    }
  }
}

module "network" {
  source = "./modules/network"
}

module "database" {
  source = "./modules/database"

  database_username = var.database_username
  database_password = var.database_password

  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnet_ids
}
