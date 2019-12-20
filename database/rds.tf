resource "aws_db_subnet_group" "mysqlinstance_subnet_group" {

    name                                    = "mysqlsubnetgroup"
    subnet_ids                              = ["${var.output_datasubnets[0]}", "${var.output_datasubnets[1]}"]
    tags                                    = {
        name                                = "My SQL Subnet Group"
    }
  
}



# No KMS Key ID and it is needed but for this project it is not created
resource "aws_db_instance" "mysqlinstance" {

    allocated_storage                       = 20
    storage_type                            = "gp2"
    engine                                  = "mysql"
    engine_version                          = "5.7.22"
    instance_class                          = "db.t2.micro"
    name                                    = "mysqldb"
    username                                = "projectH"
    password                                = "projectH"
    backup_retention_period                 = "7"
    #parameter_group_name                    = "mysqlinstance.5.7"
    db_subnet_group_name                    = "mysqlsubnetgroup"
    vpc_security_group_ids                  = ["${var.sg_app_to_data_wordpress}"]
    multi_az                                = true
    apply_immediately                       = true
  
}



#resource "aws_db_instance" "mysqlinstance_replica" {
    
    #count                                   = "1"
    #allocated_storage                       = 20
    #storage_type                            = "gp2"
    #engine                                  = "mysql"
   # engine_version                          = "5.7.22"
    #instance_class                          = "db.t2.micro"
    #replicate_source_db                     = "aws_db_instance.mysqlinstance.identifier"
    #parameter_group_name                    = "mysqlinstance.5.7"
   # backup_retention_period                 = "7"
  #  vpc_security_group_ids                  = ["${var.sg_app_to_data_wordpress}"]
 #   multi_az                                = true
  
#}

