resource "aws_instance" "instance2" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.allow-ssh-http-https.id]
  user_data     = "#!/bin/bash\napt-get update\napt-get -y install nginx\nMY_LOCAL_IP=`ifconfig eth0|grep 'addr:'|grep -v inet6|awk {'print $2'}|cut -d: -f2`\nMY_EXT_IP=`curl ifconfig.me`\necho '<html><body>\n'$MY_LOCAL_IP'<br>\n'$MY_EXT_IP'</body></html>\n' > /var/www/html/index.html\n"

  tags = {
    Name = "User Data Instance"
  }

}

output "User_Data_Instance_IP" {
  value = aws_instance.instance2.public_ip
}


