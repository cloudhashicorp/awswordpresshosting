
resource "aws_autoscaling_group" "wordpress_asg" {

    name                        = "wordpress_asg"
    max_size                    = 3
    min_size                    = 2
    # health_check_grace_period   = 20
    health_check_type           = "EC2"
    force_delete                = true
    launch_configuration        = var.lc_projectH
    target_group_arns           = ["${var.tg_front_end}"]
    vpc_zone_identifier         = ["${var.output_appsubnets[0]}", "${var.output_appsubnets[1]}"]
  
}
