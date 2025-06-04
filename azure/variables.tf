variable "subscription_id" {
  type = string
  default = "a23ea812-1d8a-41f1-84b2-806938e8e2e6"
  description = "The Azure subscription id"
}

variable "location" {
  type = string
  default = "North Europe"
  description = "The Azure region used for the resources"
}

variable "my-ip" {
  description = "IP Address from which to get access to the public subnet in CIDR format (usually /32)"
  type = string
  default = ""
}

variable "vnet-cidr" {
  default = ["192.30.0.0/16"]
  type = list(string)
  description = "The CIDR range of the VNet"
}

variable "public-subnet-cidr" {
  description = "Public subnet CIDR"
  type = list(string)
}

variable "private-subnets-cidr" {
  description = "Private subnet CIDR"
  type = list(string)
}

variable "bootcamp-key-name" {
  default = "bootcamp-key"
  description = "Name of key in AWS"
  type = string
}
