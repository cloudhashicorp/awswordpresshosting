
#################Public Route Table#################
# Creates 2 Public Route Table
resource "aws_route_table" "public_rtb_projectH" {

    count           = 2
    vpc_id          = "${aws_vpc.projectH.id}"

    tags            = {
        Name        = "Public Route Table_projectH-${count.index+1}"
    }
  
}

resource "aws_route" "public_natgw_rt_0" {

    #count                       = 2 
    #route_table_id              = "${element(aws_route_table.public_rtb_projectH.*.id, count.index)}"
    route_table_id              = "${aws_route_table.public_rtb_projectH.0.id}"
    destination_cidr_block      = "${var.any_ip}"
    #gateway_id                  = "${aws_internet_gateway.gw_projectH.id}"
    nat_gateway_id              = "${aws_nat_gateway.natgw_projectH.0.id}"
    depends_on                  = ["aws_route_table.public_rtb_projectH"]

}


resource "aws_route" "public_natgw_rt_1" {

    #count                       = 2 
    #route_table_id              = "${element(aws_route_table.public_rtb_projectH.*.id, count.index)}"
    route_table_id              = "${aws_route_table.public_rtb_projectH.1.id}"
    destination_cidr_block      = "${var.any_ip}"
    #gateway_id                  = "${aws_internet_gateway.gw_projectH.id}"
    nat_gateway_id              = "${aws_nat_gateway.natgw_projectH.1.id}"
    depends_on                  = ["aws_route_table.public_rtb_projectH"]

}


resource "aws_route_table_association" "public_rtb_assoc_projectH" {

    count                       = 2
    subnet_id                   = "${element(aws_subnet.publicsubnets.*.id, count.index)}"
    route_table_id              = "${element(aws_route_table.public_rtb_projectH.*.id, count.index)}" 
  
}







#################App Route Table#################

resource "aws_route_table" "app_rtb_projectH" {

    count           = 2
    vpc_id          = "${aws_vpc.projectH.id}"

    tags            = {
        Name        = "App Route Table_projectH-${count.index+1}"
    }
  
}



resource "aws_route" "app_igw_rt_0" {

    #count                       = 2 # count can be removed
    # route_table_id              = "${element(aws_route_table.app_rtb_projectH.*.id, count.index)}" # SPLAT  
    # nat_gateway_id              = "${element(aws_nat_gateway.natgw_projectH.*.id, count.index)}" # SPLAT
    route_table_id              = "${aws_route_table.app_rtb_projectH.0.id}"
    destination_cidr_block      = "${var.any_ip}"
    #nat_gateway_id              = "${aws_nat_gateway.natgw_projectH.0.id}"
    gateway_id                  = "${aws_internet_gateway.gw_projectH.id}"
    depends_on                  = ["aws_route_table.app_rtb_projectH"]

}

resource "aws_route" "app_igw_rt_1" {

    #count                       = 2 # count can be removed
    # route_table_id              = "${element(aws_route_table.app_rtb_projectH.*.id, count.index)}" # SPLAT
    # nat_gateway_id              = "${element(aws_nat_gateway.natgw_projectH.*.id, count.index)}" # SPLAT
    route_table_id              = "${aws_route_table.app_rtb_projectH.1.id}"
    destination_cidr_block      = "${var.any_ip}"
    #nat_gateway_id              = "${aws_nat_gateway.natgw_projectH.1.id}"
    gateway_id                  = "${aws_internet_gateway.gw_projectH.id}"
    depends_on                  = ["aws_route_table.app_rtb_projectH"]

}


resource "aws_route_table_association" "app_rtb_assoc_projectH_0" {

    # count                       = 2 # Count can be removed
    # subnet_id                   = "${element(aws_subnet.publicsubnets.*.id, count.index)}" # SAMPLE of SPLAT
    # route_table_id              = "${element(aws_route_table.public_rtb_projectH.*.id, count.index)}" # SAMPLE of SPLAT
    subnet_id                   = "${aws_subnet.appsubnets.0.id}"
    route_table_id              = "${aws_route_table.app_rtb_projectH.0.id}" # SAMPLE of SPLAT
  
}

resource "aws_route_table_association" "app_rtb_assoc_projectH_1" {

    # count                       = 2 # Count can be removed
    # subnet_id                   = "${element(aws_subnet.publicsubnets.*.id, count.index)}" # SAMPLE of SPLAT
    # route_table_id              = "${element(aws_route_table.public_rtb_projectH.*.id, count.index)}" # SAMPLE of SPLAT
    subnet_id                   = "${aws_subnet.appsubnets.1.id}"
    route_table_id              = "${aws_route_table.app_rtb_projectH.1.id}" # SAMPLE of SPLAT
  
}


#######################Data Route Table#########################

resource "aws_route_table" "data_rt_projectH" {

    count           = 2
    vpc_id          = "${aws_vpc.projectH.id}"
    tags            = {
        Name        = "Data Route Table_projectH-${count.index+1}"
    }
  
}


resource "aws_route_table_association" "data_rtb_assoc_projectH_1" {

    count                       = 2 # Count can be removed
    subnet_id                   = "${element(aws_subnet.datasubnets.*.id, count.index)}" # SAMPLE of SPLAT
    # route_table_id              = "${element(aws_route_table.public_rtb_projectH.*.id, count.index)}" # SAMPLE of SPLAT
    #subnet_id                   = "${aws_subnet.appsubnets.1.id}"
    route_table_id              = "${element(aws_route_table.data_rt_projectH.*.id, count.index)}" # SAMPLE of SPLAT
  
}

#resource "aws_route" "data_to_app_rt" {

 #   count                       = 2
  #  route_table_id              = "${aws_route_table.data_rt_projectH.0.id}"
   # destination_cidr_block      = "${element(split(",", join(",", var.app_subnet_cidr_list)), count.index)}"
    #depends_on                  = ["aws_route_table.app_rtb_projectH"]

#}






  






