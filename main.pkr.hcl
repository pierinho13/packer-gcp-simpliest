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

source "googlecompute" "nginx" {
  project_id              = var.project_id
  image_name              = "nginx-image-as-simple-as-posible"
  source_image            = "debian-11-bullseye-v20230711"
  source_image_family     = "debian-11"
  zone                    = var.zone
  ssh_username            = "piero.rospigliosi"
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
     ansible_env_vars = ["ANSIBLE_REMOTE_TEMP=/tmp","ANSIBLE_LOCAL_TEMP=/tmp"]
     extra_arguments = [ "--scp-extra-args", "'-O'" ]
  }
}

