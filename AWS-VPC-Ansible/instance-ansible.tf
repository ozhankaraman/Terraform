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

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = module.vpc-test.public_subnets[0]

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh-http-test.id]

  # the public SSH key
  key_name = aws_key_pair.mykey.key_name

  provisioner "local-exec" {
    command = "echo '${aws_instance.example.id} ansible_host=${aws_instance.example.public_ip} ansible_ssh_private_key_file=${aws_instance.example.key_name} ansible_ssh_user=ubuntu ansible_python_interpreter=/usr/bin/python3' > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory ansible.yml"
  }

  tags = {
    Name = "Ansible Managed Instance"
  }

}

output "ip" {
  value = aws_instance.example.public_ip
}
