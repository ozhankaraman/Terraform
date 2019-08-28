## AWS + Terraform + Examples
* This Repo is designed to build to store some common Terraform Examples that i am using on my daily basis

* Before applying the Terraform IAC(Infrastructure As Code) make sure that you setup terraform.tfvars like below with your access and secret keys like below:

```
terraform init
```

* To apply terraform codes to AWS, type below command
```
terraform apply
```

* or you could use a backend.tf like below to hold your state file on Cloud
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
* To test the result check the terraform output 

* And after that to destroy environment you could use below command
```
terraform destroy
```




