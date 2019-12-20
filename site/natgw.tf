resource "aws_eip" "natgw_eip_projectH" {
    
    count                       = 2
    vpc                         = true
  
}


resource "aws_nat_gateway" "natgw_projectH" {

    count                       = "${length(var.az)}"
    allocation_id               = "${element(aws_eip.natgw_eip_projectH.*.id, count.index)}"
    subnet_id                   = "${element(aws_subnet.publicsubnets.*.id, count.index)}" # ALWAYS Attach NAT Gateway to PUBLIC subnet
                                                                                        
    depends_on                  = ["aws_internet_gateway.gw_projectH"]
    tags                        = {
        Name                    = "gw NAT_projectH-${count.index+1}" #"gw NAT_projectH-${element(var.az, count.index)}"
    }
  
}



