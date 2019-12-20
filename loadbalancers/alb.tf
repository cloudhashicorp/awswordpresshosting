
resource "aws_lb" "alb" {

    name                    = "wordpress-app-load-balancer"
    internal                = false
    load_balancer_type      = "application"
    security_groups         = ["${var.sg_from_any_to_lb}"]
    subnets                 = ["${var.output_appsubnets[0]}",
                               "${var.output_appsubnets[1]}"]
    idle_timeout            = 180

    

    enable_deletion_protection = true

    tags                        = {
        Environment             = "Production"
    }

  
}

resource "aws_lb_target_group" "tg_front_end" {

    name                        = "tg-front-end"
    port                        = 80
    protocol                    = "HTTP"
    target_type                 = "instance"
    vpc_id                      = "${var.out_projecth_vpc_id}"

    tags                        = {
        name                    = "Target Group Front End"
    }

}

output "tg_front_end" {
  value = "${aws_lb_target_group.tg_front_end.arn}"
}




resource "aws_lb_listener" "front_end" {

    load_balancer_arn       = "${aws_lb.alb.arn}"
    port                    = "80"
    protocol                = "HTTP"

    default_action {
        type                = "forward"
        target_group_arn    = "${aws_lb_target_group.tg_front_end.arn}"
     
    }
  

}

#resource "aws_lb_target_group_attachment" "tg_attachment_front_end" {

 #  count                   = 2 
  # target_group_arn        = "${aws_lb_target_group.tg_front_end.arn}"
   #target_id               = "${element(split(",", join(",", var.ec2_instance)), count.index)}" # Terraform has no direct array creation
   #port                    = 80
  
#}





