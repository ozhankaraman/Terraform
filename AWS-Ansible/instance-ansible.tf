resource "aws_instance" "instance_ansible" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.allow-ssh-http-https.id]

  provisioner "local-exec" {
    command = "echo '${aws_instance.instance_ansible.id} ansible_host=${aws_instance.instance_ansible.public_ip} ansible_ssh_private_key_file=${aws_instance.instance_ansible.key_name} ansible_ssh_user=ubuntu ansible_python_interpreter=/usr/bin/python3' > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i inventory ansible.yml "
  }

  tags = {
    Name = "Ansible Managed Instance"
  }

}

output "Ansible_Instance_IP" {
  value = aws_instance.instance_ansible.public_ip
}


