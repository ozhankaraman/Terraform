## Terraform Ansible Configurator for Instance

Playbook Takes Actions Below

* Creates a VPC
* Creates a Security Group
* Creates a SSH Key
* Creates a Instance 
* Configures Instance to install nginx and then copies index.html to web root
* Creates a Instance and configures it using User-Data
* Outputs Instance IP

Before starting terraform apply use
* ssh-keygen -f mykey
* Use S3/DynamoDB Combination to store state file like below and define it in backend.tf file like below
```
terraform {
  backend "s3" {
    bucket = "terraform-remote-state-storage-xxxxxxxxxxxx"
    dynamodb_table = "terraform-state-xxxxxxx"
    key = "terraform.tfstate"
    encrypt = false
    region = "xx-xxxx-x"
  }
}
```
* terraform init 
* terraform apply
