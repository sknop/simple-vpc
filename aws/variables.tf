variable "region" {
  type = string
}

variable "vpc-cidr" {
  default = "172.32.0.0/16"
  description = "The CIDR block for your VPC"
  type = string
}

variable "my-ip" {
  description = "IP Address from which to get access to the public subnet in CIDR format (usually /32)"
  type = string
  default = ""
}

variable "jumphost-instance-type" {
  description = "AWS instance type used for jumphost instance"
  default = "t3.micro"
}

variable "database-instance-type" {
  description = "AWS instance type used for jumphost instance"
  default = "m5d.large"
}

variable "bootcamp-key-name" {
  default = "bootcamp-key"
  description = "Name of key in AWS"
  type = string
}

variable "owner_email" {
  type = string
}

variable "owner_name" {
  type = string
}

variable "cflt_environment" {
  default = "prod"
}

variable "cflt_partition" {
  default = "sales"
}

variable "cflt_managed_by" {
  type = string
}

variable "cflt_managed_id" {
  default = "user"
}

variable "cflt_service" {
  description = "This is the theatre of operation, like EMEA or APAC"
  type = string
}

variable "keep-until" {
  type = number
  default = 2
}
