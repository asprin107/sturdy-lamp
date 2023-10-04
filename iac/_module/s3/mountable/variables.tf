variable "tags" {
  description = "Default tags."
  type = object({
    Project     = string
    Service     = string
    Management  = string
    Environment = string
    Account     = string
  })
}

variable "vpc_endpoint_enabled" {
  description = "Enable VPC endpoint for s3."
  type        = bool
  default     = true
}
variable "s3_vpc_id" {
  description = "VPC id allowed access to s3."
  type        = string
}

variable "s3_subnet_ids" {
  description = "Subnet ids for VPC endpoint to s3 access."
  type        = list(string)
  default     = []
}

variable "s3_access_point_enabled" {
  description = "S3 Access Point enabled."
  type        = bool
  default     = false
}

variable "s3_prefix" {
  description = "S3 bucket prefix."
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "AWS Region."
  type        = string
}

variable "route_table_id" {
  description = "List route table id that access allow to s3."
  type        = map(object({}))
  default     = {}
}

variable "local_mount_path" {
  description = "Mount path in EC2 instance."
  type        = string
}