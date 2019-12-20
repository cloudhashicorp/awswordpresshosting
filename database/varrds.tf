variable "az" {

 
    type            = "list"
    default         = ["us-east-1a","us-east-1b"]
  
}

variable "output_datasubnets" {

    type            = list(string)
  
}

variable "sg_app_to_data_wordpress" {}


