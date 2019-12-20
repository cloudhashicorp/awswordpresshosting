

# These EC2 instances are stand alone 
# This "data" is for querying Amazon Linux
data "aws_ami" "amazon_linux" {

    owners                   = ["amazon"]
    most_recent              = true

    filter {
        name                = "name"
        values              = ["amzn-ami-hvm-*-x86_64-gp2"]
        
    }

    filter {
        name                = "owner-alias"
        values              = ["amazon", ]
    }

    filter {
        name                 = "architecture"
        values               = ["x86_64"]
    }

    filter {
        name                 = "root-device-type"
        values               = ["ebs"]
    }

    filter {
        name                 = "virtualization-type"
        values               = ["hvm"]
    }

    
  
}


# Create AWS Instance using the data from CentOS 7

resource "aws_key_pair" "myec2key" {

    key_name        = "myec2key"
    public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAve5N9uVckdbOdSiaQ9oZ1yt1dGH+LoFq9rB+QMlAR523KZWcjjwqRHP0+RHzjfHqcqkkKGFNcAMSd+CBPxXz7ek2QtJGtROqEk2t+Iamdjpmb9ZuhdJKSgl/NqmQ7OBF7eKo4erj/zFmlJ/YbMwjfmMxH66tdCdf10YIUcHIUUZ/6QOozLZBrUvC8p3fFcF9hgQDHqQV0tmSzxYFSUa/sZek/KUkh4nfLwR94hBO6WKdl4wCCEPwTuO1A1OjbNHkl+94x6mp7lHOsvR0XTHbJ5eFkuaDWQYLwdV5R4x0Wu++oVIhjrLPpkVZtLKcd5tpxAgF6pVcTs5t/70osFAWDQ== rsa-key-20191124"
  
}

resource "aws_instance" "ec2_instance" {

    count                       = 2
    ami                         = "${data.aws_ami.amazon_linux.id}"
    instance_type               = "t2.micro"
    vpc_security_group_ids      = ["${var.sg_app_to_data_wordpress}"]
    subnet_id                   = "${element(var.output_appsubnets, count.index)}"
    key_name                    = "myec2key"
    user_data                   = "${file("./launch_configuration/userdata.sh")}"

    tags                        = {
        name                    = "WordPress Instance-${count.index+1}"
    }

  
}

# Initial config for the aws_lb_target_group_attachment

output "ec2_instance" {
  value = "${aws_instance.ec2_instance.*.id}"
}




