##Setup variables

variable "do_token" {}
variable "image" {}
variable "size" {}
variable "region" {}
variable "ssh_fingerprint" {}
variable "home_ipv4_addr" {}

provider "digitalocean" {
    token = var.do_token
}
 
resource "digitalocean_droplet" "keycloak-id" {
    name  = "keycloak-id"
    image = var.image
    region = var.region
    size   = var.size
    monitoring = true
    ipv6 = true
    ssh_keys = [
        var.ssh_fingerprint
    ]
}

resource "digitalocean_firewall" "keycloak-id" {
  name = "keycloak-id-allow-80-443"

  droplet_ids = [digitalocean_droplet.keycloak-id.id]
  
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = [var.home_ipv4_addr]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = [var.home_ipv4_addr]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "22"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  
  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

}

output "ip" {
    value = "${digitalocean_droplet.keycloak-id.ipv4_address}"
}