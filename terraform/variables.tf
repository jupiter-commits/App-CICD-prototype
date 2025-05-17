variable "aws_region" {
  type    = string
  default = "eu-west-3"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "public_key_1" {
  type        = string
  description = "public key used in key pair resource for ec2 instances"
}
