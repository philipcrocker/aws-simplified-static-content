variable "bucket_name" {
  default = "private-s3-web-content"
  description = "Website content files bucket"
}

variable "aws_region" {
  type = string
  default = "us-west-1"
}

# variable "aws_access_key" {
#   type      = string
#   sensitive = true
# }

# variable "aws_secret_access_key" {
#   type      = string
#   sensitive = true
# }