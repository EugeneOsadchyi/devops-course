variable "database_username" {
  type        = string
  description = "Database username"
  sensitive   = true
}

variable "database_password" {
  type        = string
  description = "Database password"
  sensitive   = true
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnets where RDS instance can be provisioned in"
}

variable "vpc_id" {
  type        = string
  description = "A VPC ID, where RDS is provisioned"
}
