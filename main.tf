# Name: projectH
# Source of Architecture: 
# https://aws.amazon.com/architecture/?awsf.quickstart-architecture-page-filter=highlight%23new
# https://github.com/aws-samples/aws-refarch-wordpress

provider "aws" {
 
  region     =  var.region
  access_key =  var.access_key_id
  secret_key =  var.secret_key_id
}

module "site" {
  source = "./site"
}

module "ec2" {
  source                   = "./ec2"
  sg_app_to_data_wordpress = module.site.sg_app_to_data_wordpress
  output_appsubnets        = module.site.output_appsubnets
}

module "loadbalancers" {
  source                   = "./loadbalancers"
  sg_app_to_data_wordpress = module.site.sg_app_to_data_wordpress
  output_appsubnets        = module.site.output_appsubnets
  out_projecth_vpc_id      = module.site.out_projecth_vpc_id
  ec2_instance             = module.ec2.ec2_instance
  sg_natgw_app_wordpress   = module.site.sg_natgw_app_wordpress
  sg_from_any_to_lb        = module.site.sg_from_any_to_lb
}

module "launch_configuration" {
  source                   = "./launch_configuration"
  sg_app_to_data_wordpress = module.site.sg_app_to_data_wordpress
  ssh_from_public_subnet   = module.site.ssh_from_public_subnet
  sg_natgw_app_wordpress   = module.site.sg_natgw_app_wordpress
  sg_from_any_to_lb        = module.site.sg_from_any_to_lb
}

module "auto_scaling" {
  source            = "./auto_scaling"
  lc_projectH       = module.launch_configuration.lc_projectH_output
  tg_front_end      = module.loadbalancers.tg_front_end
  output_appsubnets = module.site.output_appsubnets
}

module "memcached" {
  source                   = "./memcached"
  output_datasubnets       = module.site.output_datasubnets
  sg_app_to_data_wordpress = module.site.sg_app_to_data_wordpress
}

module "database" {
  source                   = "./database"
  output_datasubnets       = module.site.output_datasubnets
  sg_app_to_data_wordpress = module.site.sg_app_to_data_wordpress
}

module "efsmount" {
  source                   = "./efsmount"
  out_projecth_vpc_id      = module.site.out_projecth_vpc_id
  output_datasubnets       = module.site.output_datasubnets
  sg_app_to_data_wordpress = module.site.sg_app_to_data_wordpress
}

