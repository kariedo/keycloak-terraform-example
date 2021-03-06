variable "do-ssh-key" {}

resource "null_resource" "ansible-deploy-docker" {

  depends_on = [digitalocean_droplet.keycloak-id, null_resource.ansible-create-inventory]

  provisioner "local-exec" {
    command = "sleep 30; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u centos --private-key '${var.do-ssh-key}' -i ansible/inventory/test ansible/tasks/deploy-docker.yml"
  }
}