provider "aws" {
  region  = "${var.aws_region}"
}

#------VPC---------

resource "aws_vpc" "hawk_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags {
    Name = "hawk_vpc"
  }
}

#-----------Elastic IP-------------------------
resource "aws_eip" "nat" {
  vpc = true
}

#------------NAT gw---------------------------
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.hawk_public_subnet.id}"

  tags {
    Name = "gw NAT"
  }
}

#------Internet GW-----

resource "aws_internet_gateway" "hawk_internet_gateway" {
  vpc_id = "${aws_vpc.hawk_vpc.id}"

  tags {
    Name = "hawk_IGW"
  }
}

#-----Route tables----
#-----Public Route----
resource "aws_route_table" "hawk_public_rt" {
  vpc_id = "${aws_vpc.hawk_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.hawk_internet_gateway.id}"
  }

  tags {
    Name = "hawk_public"
  }
}

#-----NAT-GW-Route----
resource "aws_route_table" "nat_rt" {
 vpc_id = "${aws_vpc.hawk_vpc.id}"

 route {
 cidr_block = "0.0.0.0/0"
 gateway_id = "${aws_nat_gateway.nat_gw.id}"
 }

 tags {
   Name = "hawk_nat_gw"
 }
}
#----subnets----
resource "aws_subnet" "hawk_public_subnet" {
  vpc_id                  = "${aws_vpc.hawk_vpc.id}"
  cidr_block              = "${var.hawk_public_subnet}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "hawk_public"
  }
}

resource "aws_subnet" "hawk_private_subnet" {
  vpc_id                  = "${aws_vpc.hawk_vpc.id}"
  cidr_block              = "${var.hawk_private_subnet}"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "hawk_private"
  }
}

#-------subnet association with route tables------

resource "aws_route_table_association" "hawk_public_assoc" {
  subnet_id      = "${aws_subnet.hawk_public_subnet.id}"
  route_table_id = "${aws_route_table.hawk_public_rt.id}"
}


resource "aws_route_table_association" "hawk_nat_gw_assoc" {
  subnet_id      = "${aws_subnet.hawk_private_subnet.id}"
  route_table_id = "${aws_route_table.nat_rt.id}"
}
