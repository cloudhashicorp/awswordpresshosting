# create a ElastiCache Subnet Group First coming from the list
# of the Subnet created in the vpc_config.tf

resource "aws_elasticache_subnet_group" "datasubnetmemcache" {


    name                            = "datasubnetmemcache"
    subnet_ids                      = ["${var.output_datasubnets[0]}", "${var.output_datasubnets[1]}"]
  
}


resource "aws_elasticache_cluster" "elasticachemem" {

    cluster_id                      = "memcached-cluster"
    engine                          = "memcached"
    node_type                       = "cache.t2.medium"
    num_cache_nodes                 = 2
    parameter_group_name            = "default.memcached1.5"
    port                            = 11211
    subnet_group_name               = "${aws_elasticache_subnet_group.datasubnetmemcache.name}"
    preferred_availability_zones    = ["${var.az[0]}", "${var.az[1]}"]
    security_group_ids              = ["${var.sg_app_to_data_wordpress}"]


  
}
