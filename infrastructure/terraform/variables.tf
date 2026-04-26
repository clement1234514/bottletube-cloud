variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "ami_id" {
  description = "AMI ID für BottleTube-Instanzen"
  type        = string
}
