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
