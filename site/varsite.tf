variable "vpc_cidr_block" {

    default         = "192.0.0.0/16"
  
}

variable "any_ip" {

    default         = "0.0.0.0/0"
  
}


variable "public_subnet_cidr_list" {

    type            = "list"
    default         = ["192.0.1.0/24", "192.0.3.0/24"]
  
}

variable "app_subnet_cidr_list" {

    type            = "list"
    default         = ["192.0.2.0/24", "192.0.4.0/24"]
  
}

variable "data_subnet_cidr_list" {
    
    type            = "list"
    default         = ["192.0.5.0/24", "192.0.6.0/24"]
  
}



variable "az" {

 
    type            = "list"
    default         = ["us-east-1a","us-east-1b"]
  
}










