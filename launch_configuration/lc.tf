# Search for Amazon Linux AMI

data "aws_ami" "amazon_linux_lc" {

    owners                  = ["amazon"]
    most_recent             = true

    filter {

        name                = "name"
        values              = ["amzn-ami-hvm-*-x86_64-gp2"]
    }

    filter {

        name                = "architecture"
        values              = ["x86_64"]
    }

    filter {

        name                = "root-device-type"
        values              = ["ebs"]
    }

    filter {

        name                = "virtualization-type"
        values              = ["hvm"]
    }
  
}

resource "aws_launch_configuration" "lc_projectH" {

    name                        = "wordpressinstance"
    image_id                    = "ami-0c6b1d09930fac512" #"${data.aws_ami.amazon_linux_lc.id}"
    instance_type               = "t2.medium"
    security_groups             = ["${var.sg_natgw_app_wordpress}",
                                  "${var.ssh_from_public_subnet}",
                                  "${var.sg_app_to_data_wordpress}",
                                  "${var.sg_from_any_to_lb}"
                                  ]
    key_name                    = "myec2key"
    associate_public_ip_address = true
    user_data                   = "${file("./launch_configuration/userdata.sh")}"
  
}

output "lc_projectH_output" {
  value                        = "${aws_launch_configuration.lc_projectH.name}"
}


