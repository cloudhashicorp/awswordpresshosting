resource "aws_vpc" "projectH" {

    cidr_block          = "${var.vpc_cidr_block}"

    tags                = {
        Name            = "VPC PROJECT H"
    }
  
}

output "out_projecth_vpc_id" {
  value = "${aws_vpc.projectH.id}"
}

resource "aws_subnet" "publicsubnets" {

    count               = "${length(var.az)}"
    vpc_id              = "${aws_vpc.projectH.id}"
    cidr_block          = "${element(var.public_subnet_cidr_list, count.index)}"
    availability_zone   = "${element(var.az, count.index)}"
    tags                =  {
        Name            = "Public-Subnet-${count.index+1}"
    }
    
} 

resource "aws_subnet" "appsubnets" {

    count               = "${length(var.az)}"
    vpc_id              = "${aws_vpc.projectH.id}"
    cidr_block          = "${element(var.app_subnet_cidr_list, count.index)}"
    availability_zone   = "${element(var.az, count.index)}"
    tags                = {
        Name            = "App-Subnet-${count.index+1}"
    }
  
}

output "output_appsubnets" {
 
  value = "${aws_subnet.appsubnets.*.id}"
}

resource "aws_subnet" "datasubnets" {

    count               = "${length(var.az)}"
    vpc_id              = "${aws_vpc.projectH.id}"
    cidr_block          = "${element(var.data_subnet_cidr_list, count.index)}"
    availability_zone   = "${element(var.az, count.index)}"
    tags                = {
        Name            = "Data-Subnet-${count.index+1}"
    }
  
}

output "output_datasubnets" {
  value = "${aws_subnet.datasubnets.*.id}"
}










