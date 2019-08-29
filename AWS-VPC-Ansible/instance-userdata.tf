resource "aws_instance" "instance2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  subnet_id     = module.vpc-test.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.allow-ssh-http-test.id]
  user_data     = "#!/bin/bash\napt-get update\napt-get -y install nginx stress\nMY_LOCAL_IP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`\nMY_EXT_IP=`curl http://169.254.169.254/latest/meta-data/public-ipv4`\necho '<html><body>\n'$MY_LOCAL_IP'<br>\n'$MY_EXT_IP'</body></html>\n' > /var/www/html/index.html\necho ok > /var/www/html/health.html\n"

  tags = {
    Name = "User Data Instance"
  }

}

output "User_Data_Instance_IP" {
  value = aws_instance.instance2.public_ip
}


