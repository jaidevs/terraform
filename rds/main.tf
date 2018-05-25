provider "aws" {
  region  = "${var.aws_region}"
}

resource "aws_db_option_group" "optiongp" {
  name                     = "${var.option_group_name}"
  option_group_description = "${var.option_group_desc}"
  engine_name              = "${var.option_engine_name}"
  major_engine_version     = "${var.option_major_engine_version}"
}



resource "aws_security_group" "rdsdefault" {
  name = "rds_sg"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "local_file" "foo" {
  filename = "/home/jaidev/rdspasswd"
}

resource "aws_db_instance" "postgresql" {
  allocated_storage      = "${var.rds_size}"
  storage_type           = "${var.rds_storage_type}"
  engine                 = "${var.rds_engine_type}"
  engine_version         = "${var.rds_engine_version}"
  instance_class         = "${var.rds_instance_class}"
  name                   = "${var.rds_database_name}"
  username               = "${var.rds_username}"
  password               = "${data.local_file.foo.id}"
  parameter_group_name   = "${var.rds_pg_name}"
  multi_az               = "${var.rds_multi_az}"
  publicly_accessible    = "${var.rds_public_access}"
  port                   = "${var.rds_port}"
  skip_final_snapshot    = "${var.skip_rds_final_snapshot}"
  vpc_security_group_ids = ["${aws_security_group.rdsdefault.id}"]
  option_group_name      = "${aws_db_option_group.optiongp.id}"

  tags {
    Name        = "${var.env}-postgresql"
    Environment = "${var.env}"
    Owner       = "${var.owner}"
  }
}
