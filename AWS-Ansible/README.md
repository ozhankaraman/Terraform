## AWS + Terraform + Ansible
* This Repo is designed to build a public vm and security group over AWS and then configure that vm using Ansible Playbooks all done with a single command

* Before applying the Terraform IAC(Infrastructure As Code) make sure that you setup terraform.tfvars like below with your access and secret keys like below:
```
Ozhans-MacBook:AWS-Terraform-Ansible-1 ozhan$ cat terraform.tfvars
AWS_ACCESS_KEY = "xxxxxxxxxxxxxxxxxxxxx"
AWS_SECRET_KEY = "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
```

* And after that please use below command to initialize terraform environment
```
terraform init
```

* To apply terraform codes to AWS, type below command
```
terraform apply
```

* To test the result check the terraform output to get newly generated vm's public IP address and then you could access that ip from your browser.

* And after that to destroy environment you could use below command
```
terraform destroy
```




