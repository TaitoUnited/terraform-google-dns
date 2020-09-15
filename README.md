# Google Cloud DNS

Example usage:

```
provider "google" {
  project = "my-infrastructure"
  region  = "europe-west1"
  zone    = "europe-west1b"
}

resource "google_project_service" "compute" {
  service                    = "compute.googleapis.com"
  disable_dependent_services = true
  disable_on_destroy         = false
}

module "dns" {
  source       = "TaitoUnited/dns/google"
  version      = "1.0.0"
  providers    = [ google ]
  depends_on   = [ google_project_service.compute ]
  dns_zones    = yamldecode(file("${path.root}/../infra.yaml"))["dnsZones"]
}
```

Example YAML:

```
dnsZones:
  - name: my-domain
    dnsName: mydomain.com.
    visibility: public
    dnsSec:
      state: on
    recordSets:
      - dnsName: www.mydomain.com.
        type: A
        ttl: 3600
        values: ["127.127.127.127"]
      - dnsName: myapp.mydomain.com.
        type: CNAME
        ttl: 43200
        values: ["myapp.otherdomain.com."]
```

Combine with the following modules to get a complete infrastructure defined by YAML:

- [Admin](https://registry.terraform.io/modules/TaitoUnited/admin/google)
- [DNS](https://registry.terraform.io/modules/TaitoUnited/dns/google)
- [Network](https://registry.terraform.io/modules/TaitoUnited/network/google)
- [Kubernetes](https://registry.terraform.io/modules/TaitoUnited/kubernetes/google)
- [Databases](https://registry.terraform.io/modules/TaitoUnited/databases/google)
- [Storage](https://registry.terraform.io/modules/TaitoUnited/storage/google)
- [Monitoring](https://registry.terraform.io/modules/TaitoUnited/monitoring/google)
- [PostgreSQL users](https://registry.terraform.io/modules/TaitoUnited/postgresql-users/google)
- [MySQL users](https://registry.terraform.io/modules/TaitoUnited/mysql-users/google)

TIP: Similar modules are also available for AWS, Azure, and DigitalOcean. All modules are used by [infrastructure templates](https://taitounited.github.io/taito-cli/templates#infrastructure-templates) of [Taito CLI](https://taitounited.github.io/taito-cli/).

See also [Google Cloud project resources](https://registry.terraform.io/modules/TaitoUnited/project-resources/google), [Full Stack Helm Chart](https://github.com/TaitoUnited/taito-charts/blob/master/full-stack), and [full-stack-template](https://github.com/TaitoUnited/full-stack-template).

Contributions are welcome!
