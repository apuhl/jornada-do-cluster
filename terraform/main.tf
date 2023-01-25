terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "dop_v1_8fb7150ed3c65a06cf76f315657b78b665a9446d4fc7f7e200f9542b80e70562"
}

resource "digitalocean_droplet" "jenkins_droplet" {
  image    = "ubuntu-22-04-x64"
  name     = "jenkins-jornada-devops"
  region   = var.do_main_region
  size     = "s-2vcpu-2gb"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
}

data "digitalocean_ssh_key" "ssh_key" {
  name = var.ssh_key_name
}

resource "digitalocean_kubernetes_cluster" "k8s-cluster" {
  name   = "k8s-devopselite-cluster"
  region = var.do_main_region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.25.4-do.0"

  node_pool {
    name       = "default"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}

variable "do_token" {
}

variable "do_main_region" {
  default = "nyc1"
}

variable "ssh_key_name" {
  default = "DevopsElite"
}

output "jenkins-ip" {
  value = digitalocean_droplet.jenkins_droplet.ipv4_address
}

resource "local_file" "jenkins-ip-file" {
  filename = "${digitalocean_droplet.jenkins_droplet.name}.ip-address.txt"
  content = digitalocean_droplet.jenkins_droplet.ipv4_address
}

resource "local_file" "kubernetes-cluster-config" {
 filename = "kube_config.yaml"
 content = digitalocean_kubernetes_cluster.k8s-cluster.kube_config.0.raw_config
}