packer {
  required_plugins {


    
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = ">= 1.1.1"
    }


    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}


variable "project_id" {
  type    = string
  default = "geometric-edge-395607"
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
  default = "/home/piero/keys/terraform-demo.json"
}

source "googlecompute" "nginx" {
  project_id              = var.project_id
  image_name              = "nginx-image-as-simple-as-posible"
  source_image            = "debian-11-bullseye-v20230711"
  source_image_family     = "debian-11"
  zone                    = var.zone
  ssh_username            = "piero"
  ssh_timeout             = "2m"
  image_description       = "Debian 11 Bullseye nginx as simple as posible"
  network                 = var.vpc_name
  subnetwork              = var.subnet_name
  tags                    = ["http-server","https-server"]
  instance_name           = "nginx-packer-{{uuid}}"
  disk_size               = 20

  image_labels = {
    created_by  = "piero"
    environment = "test"
  }

  account_file = var.account_file_path

}

build {
  sources = ["source.googlecompute.nginx"]
   provisioner "ansible" {
     playbook_file = "./first_ansible_playbook.yml"
  }
}

