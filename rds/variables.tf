variable "aws_region" {
  description = "This variable is to define aws Region"
  default     = "us-east-2"
}



variable "bucket_name" {
  description = "This variable is to define Bucket Name"
  default     = "hawk-infra-jaidev"
}

variable "password_file_name" {
  description = "This variable is to define File Name which containd DB Password"
  default     = "rdspasswd"
}

variable "rds_size" {
  description = "This variable is to define RDS Size"
  default     = "10"
}

variable "rds_storage_type" {
  description = "This variable is to define Storage Type"
  default     = "gp2"
}

variable "rds_engine_type" {
  description = "This variable is to define Engine type"
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "This variable is to define Engine Version"
  default     = "10.3"
}

#-----------OPTION GROUP variables-------------------
variable "option_group_name" {
  description = "This variable is to define option_group_name"
  default = "hawkoptiongp"
}

variable "option_group_desc" {
  description = "This variable is to define option_group_desc"
  default = "hawkoptiongp"
}

variable "option_engine_name" {
  description = "This variable is to define engine_name"
  default = "postgres"
}

variable "option_major_engine_version" {
  description = "This variable is to define major_engine_version"
  default = "10"
}




#------------------------------------------------------

variable "rds_instance_class" {
  description = "This variable is to define Instance Class"
  default     = "db.t2.micro"
}

variable "rds_database_name" {
  description = "This variable is to define RDS default DATABASE"
  default     = "hawkdb"
}

variable "rds_username" {
  description = "This variable is to define RDS Username"
  default     = "testuser"
}

variable "rds_pg_name" {
  description = "This variable is to define RDS Parameter Group"
  default     = "default.postgres10"
}

variable "rds_multi_az" {
  description = "This variable is to define whether to choose Multi-AZ or not"
  default     = "false"
}

variable "rds_public_access" {
  description = "This variable is to define whether to RDS is Publicly accessible or not"
  default     = "true"
}

variable "rds_port" {
  description = "This variable is to define RDS Port No."
  default     = "5432"
}

variable "skip_rds_final_snapshot" {
  description = "This variable is to define whether to make RDS snapshot or not"
  default     = "true"
}

variable "env" {
  description = "This variable is to define environment"
  default     = "test"
}

variable "owner" {
  description = "This variable is to define infrastructure owner"
  default     = "hawk"
}
