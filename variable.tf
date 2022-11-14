variable "subnet_public" {
  description = "ap-northeast-2c"
  default     = "subnet-0684c83999d5c6996"
}

variable "subnet_public_1" {
  description = "ap-northeast-2a"
  default     = "subnet-0547ff281e3f5f6fb"

}


# variable "subnets" {
#   description = "Subnets for RDS Instances"
#   type        = list(string)
#   default = [["subnet-0684c83999d5c6996", "subnet-0547ff281e3f5f6fb"]]
# }

variable "health_check" {
  type = map(string)
  default = {
    "timeout"             = "10"
    "interval"            = "20"
    "path"                = "/"
    "port"                = "80"
    "unhealthy_threshold" = "2"
    "healthy_threshold"   = "3"
  }
}

variable "ssh_private_key" {
  default = "seoul_aws.pem"
}