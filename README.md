
### What is this ?
Quick example how to setup Docker droplet for Keycloak PoC.

More details in the [blog post](https://stas.starikevich.com/posts/keycloak-on-docker-with-nginx-and-letsencrypt/).

### How to start

Clone the repo:

```sh
  $ git clone https://github.com/kariedo/keycloak-terraform-example.git
```

Adjust the `terraform.tfvars` with SSH fingerprint and your external IPv4 address

Export DigitalOcean token:

```sh
  $ export TF_VAR_do_token="veryLongStringWithToken"
```

Execute:
```sh
  $ terraform init
  $ terraform apply
```

### Author

**Stas Starikevich**

* [github.com/kariedo](https://github.com/kariedo/)

### License

Copyright © 2020, [kariedo](https://github.com/kariedo).
