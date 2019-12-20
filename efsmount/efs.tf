resource "aws_efs_mount_target" "efsmounttarget" {

    count                               = 2
    file_system_id                      = "${aws_efs_file_system.efsprojecth.id}"
    subnet_id                           = "${element(var.output_datasubnets, count.index)}"
    security_groups                     = ["${var.sg_app_to_data_wordpress}"]
  
}

resource "aws_efs_file_system" "efsprojecth" {

    creation_token                      = "efsprojecthtoken"

    tags                                = {
        name                            = "EFS Project H"
    }
  
}

