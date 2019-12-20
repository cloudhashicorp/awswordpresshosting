# NAT Gateway to App Subnet

resource "aws_security_group" "sg_natgw_app_wordpress" {

    name                    = "NAT_TO_APP"
    description             = "Allow Port 80 from NATGW to APP"
    vpc_id                  = "${aws_vpc.projectH.id}"


    ingress {
        
        from_port           = 80
        to_port             = 80
        protocol            = "tcp"
        cidr_blocks         = ["${var.public_subnet_cidr_list[0]}"]
    }

     ingress {
        
        from_port           = 80
        to_port             = 80
        protocol            = "tcp"
        cidr_blocks         = ["${var.public_subnet_cidr_list[1]}"]
    }

     egress {
        
        from_port           = 0
        to_port             = 0
        protocol            = -1
        cidr_blocks         = ["${var.any_ip}"]
    }
}

    output "sg_natgw_app_wordpress" {
       value = "${aws_security_group.sg_natgw_app_wordpress.id}"
    }

 resource "aws_security_group" "sg_from_any_to_lb" {

    name                    = "Any To LB" # Any sources from Internet
    description             = "Allow Port 80 from Any To LB"
    vpc_id                  = "${aws_vpc.projectH.id}"

    ingress {
        
        from_port           = 80
        to_port             = 80
        protocol            = "tcp"
        cidr_blocks         = ["${var.any_ip}"] # source subnet
    }

     egress {
        
        from_port           = 0
        to_port             = 0
        protocol            = -1
        cidr_blocks         = ["${var.any_ip}"]
    }
}

 output "sg_from_any_to_lb" {
       value = "${aws_security_group.sg_from_any_to_lb.id}"
    }
    
   

# SSH from Any IP

resource "aws_security_group" "ssh_from_anywhere" {

    name                    = "allow ssh from anywhere"
    description             = "Any user can SSH"
    vpc_id                  = "${aws_vpc.projectH.id}"


    ingress {

        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        cidr_blocks         = ["${var.any_ip}"]

    }


    egress {

        from_port           = 0
        to_port             = 0
        protocol            = -1
        cidr_blocks         = ["${var.any_ip}"]

    }
  
    tags                    = {
        name                = "Allow port 22 from Anywhere"
    }
}

output "ssh_from_anywhere" {
  value = "${aws_security_group.ssh_from_anywhere.id}"
}


# SSH from PUBLIC SUBNET IPs

resource "aws_security_group" "ssh_from_public_subnet" {

    name                    = "allow ssh from public subnet"
    description             = "Any user can SSH from public subnet"
    vpc_id                  = "${aws_vpc.projectH.id}"


    ingress {

        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        cidr_blocks         = ["${var.public_subnet_cidr_list[0]}"]

    }

    ingress {

        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        cidr_blocks         = ["${var.public_subnet_cidr_list[1]}"]

    }


    egress {

        from_port           = 0
        to_port             = 0
        protocol            = -1
        cidr_blocks         = ["${var.public_subnet_cidr_list[0]}"]

    }

      egress {

        from_port           = 0
        to_port             = 0
        protocol            = -1
        cidr_blocks         = ["${var.public_subnet_cidr_list[1]}"]

    }
  
    tags                    = {
        name                = "Allow port 22 from Public Subnet"
    }
}

output "ssh_from_public_subnet" {
  value = "${aws_security_group.ssh_from_public_subnet.id}"
}

# Port to open from App Subnet to Data Subnet

resource "aws_security_group" "sg_app_to_data_wordpress" {

    name                    = "SG for Data Subnet"
    description             = "Application Ports of Data Subnet"
    vpc_id                  = "${aws_vpc.projectH.id}"

     ingress {
        
        from_port           = 3000 #sample port of 3000 for EFS MOUNT Target
        to_port             = 3000
        protocol            = "tcp"
        cidr_blocks         = ["${var.data_subnet_cidr_list[0]}"]
    }

       ingress {
        
        from_port           = 3000 #sample port of 3000 for EFS MOUNT Target
        to_port             = 3000
        protocol            = "tcp"
        cidr_blocks         = ["${var.data_subnet_cidr_list[1]}"]
    }


       ingress {
        
        from_port           = 11211
        to_port             = 11211
        protocol            = "tcp"
        cidr_blocks         = ["${var.data_subnet_cidr_list[0]}"]
    }

       ingress {
        
        from_port           = 11211
        to_port             = 11211
        protocol            = "tcp"
        cidr_blocks         = ["${var.data_subnet_cidr_list[1]}"]
    }

    egress {

        from_port           = 0
        to_port             = 0
        protocol            = -1
        cidr_blocks         = ["${var.any_ip}"]


    }

    tags                    = {

        name                = "Data SG"
    }
}

output "sg_app_to_data_wordpress" {
  value = "${aws_security_group.sg_app_to_data_wordpress.id}"
}







  
   
  



