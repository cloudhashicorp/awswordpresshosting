resource "aws_internet_gateway" "gw_projectH" {

    vpc_id          = "${aws_vpc.projectH.id}"
    tags            = {
        Name        = "Internet Gateway_projectH"
    }
  
}
