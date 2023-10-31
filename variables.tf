# variable "AWS_ACCESS_KEY"{
#     description="AWS Access Key"
# }
# variable "AWS_SECRET_KEY"{
#     description="AWS Access Key"
# }
variable "aws_region" {
  default     = "us-west-2"
  description = "AWS region"
}
# Network Mask - 255.255.255.0 Addresses Available - 256
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "public_cidr_1" {
  default = "10.0.1.0/24" # 256 IPs
}
variable "private_cidr_1" {
  default = "10.0.2.0/24" # 256 IPs
}
variable "public_cidr_2" {
  default = "10.0.3.0/24" # 256 IPs
}
variable "private_cidr_2" {
  default = "10.0.4.0/24" # 256 IPs
}
variable "cidr_blocks" {
  default = "0.0.0.0/0"
}
variable "instance_type" {
  default = "t3.micro"
}
# variable "apac_region"{
#     default="us-west-2"
# }
variable "amis" {
  type        = map(string)
  description = "Region specific AWS Machine Images (AMIs)"
  default = {
    us-east-1 = "ami-0d2017e886fc2c0ab"
    us-west-2 = "ami-0d2017e886fc2c0ab"
  }
  #   validation {
  #     condition     = length(var.amis) > 4 && substr(var.amis["us-west-2"], 0, 4) == "ami-"
  #     error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  #   }
}
# variable "webservers"{
#     type = map(map(string))
#     description = "AWS EC2 webserver instance with names WEBAPI-Server and Web-App-Server"
#     default = {
#       "webserver1" = {
#         "name" = "WebAPI-Server"
#       }
#     #   "webserver2" = {
#     #     "name" = "WebApp-Server"
#     #   }
#     }
# }