variable "aws_region" {
  description = "This variable is to define aws Region"
  default     = "us-east-2"
}

data "aws_availability_zones" "available" {}

variable "vpc_cidr" {
  description = "This is default CIDR"
  default     = "10.10.0.0/16"
}

variable "hawk_public_subnet" {
   description = "CIDR-block for Public subnet"
   default = "10.10.1.0/24"
}


variable "hawk_private_subnet" {
   description = "CIDR-block for Private subnet"
   default = "10.10.2.0/24"
}
