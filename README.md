## Terraform Examples
* This Repo is designed to build to store some common Terraform Examples that i am using on my daily basis

* Before applying the Terraform IAC(Infrastructure As Code) make sure that you setup terraform.tfvars like below with your access and secret keys like below:

```
terraform init
```

* To apply terraform codes to AWS, type below command
```
terraform apply
```

* or you could use a backend.tf like below to hold your state file over AWS
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

* Minimum required policy for IAM user is below
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:CreateTable",
                "dynamodb:PutItem",
                "dynamodb:DescribeTable",
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "s3:CreateBucket",
                "s3:ListBucket",
                "s3:GetBucketVersioning"
            ],
            "Resource": [
                "arn:aws:dynamodb:*:*:table/<table name>",
                "arn:aws:s3:::<bucket name>"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject"
            ],
            "Resource": "arn:aws:s3:::<bucket name>/*"
        }
    ]
}
```

* Create a S3 Bucket and Dynamodb table on AWS. When you create DynamoDB table use LockID as primary key(case sensitive). Enable versioning and server_side_encryption_configuration on S3 bucket that you create.

* AWS user needs programatic access like below
```
root@vx4:~# cat .aws/credentials
[default]
region = eu-west-2
aws_access_key_id = xx
aws_secret_access_key = yy
```

* To test the result check the terraform output 

* And after that to destroy environment you could use below command
```
terraform destroy
```




