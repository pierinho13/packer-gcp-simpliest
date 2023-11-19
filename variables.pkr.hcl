variable "project_id" {
  type    = string
  default = "gcp-sg-testpipeline"
}

variable "zone" {
  type    = string
  default = "europe-west1-c"
}

variable "vpc_name" {
  type    = string
  default = "vpc-test-demo"
}

variable "subnet_name" {
  type    = string
  default = "subnet-europe-west1"
}

variable "account_file_path" {
  type    = string
  default = "/Users/piero.rospigliosi/keys/test-iac.json"
}