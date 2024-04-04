variable "region" {
  description = "AWS region to deploy resources to"
}

variable "db_name" {
  description = "Unique name to assign to RDS instance"
}

variable "db_username" {
  description = "RDS root username"
}

variable "db_password" {
  description = "RDS root user password"
  sensitive   = true
}

variable "publicly_accessible" {
  description = "RDS instance is publicly_accessible "
  default   = false
}
