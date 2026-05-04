terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# Criar a VPC isolada para a família de servidores
resource "digitalocean_vpc" "jumphost_vpc" {
  name     = "vpc-infra-core"
  region   = var.region
  ip_range = "10.10.10.0/24"
}

# Criar o Droplet (Servidor Jumphost)
resource "digitalocean_droplet" "jumphost" {
  image    = "ubuntu-24-04-x64"
  name     = "jumphost-core"
  region   = var.region
  size     = var.droplet_size
  vpc_uuid = digitalocean_vpc.jumphost_vpc.id
  ssh_keys = [var.ssh_key_id]

  tags = ["infra", "jumphost"]
}

# Firewall de Borda (Digital Ocean)
resource "digitalocean_firewall" "jumphost_fw" {
  name = "firewall-jumphost"

  droplet_ids = [digitalocean_droplet.jumphost.id]

  # Permitir SSH (necessário para o primeiro deploy via Ansible)
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"] # Recomenda-se depois trocar para o IP da sua casa/escritório
  }

  # Permitir ICMP (Ping) para testes básicos
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Outbound liberado para comunicação com a internet (baixar pacotes, docker, cloudflare, etc)
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
