data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    #values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = "example-launchconfig"
  #image_id        = var.AMIS[var.AWS_REGION]
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.allow-ssh-http.id]
  user_data       = "#!/bin/bash\napt-get update\napt-get -y install nginx stress\nMY_LOCAL_IP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`\nMY_EXT_IP=`curl http://169.254.169.254/latest/meta-data/public-ipv4`\necho '<html><body>\n'$MY_LOCAL_IP'<br>\n'$MY_EXT_IP'</body></html>\n' > /var/www/html/index.html\necho ok > /var/www/html/health.html\n"
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
###  health_check_type         = "ELB"
###  load_balancers            = [aws_elb.my-elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}

