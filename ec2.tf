
# data "aws_availability_zone" "aws_az" {
#   name = "us-west-2"
# }

module "vpc" {
  source = "../../"
}


resource "aws_instance" "wordpress" {
  ami                         = "ami-0e9bfdb247cc8de84"
  instance_type               = "t2.micro"
  key_name                    = "seoul_aws"
  vpc_security_group_ids      = [aws_security_group.wordpress-sg.id]
  associate_public_ip_address = true
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
    
  }

  tags = {
    Name = "Wordpress"
  }
  provisioner "local-exec" { command = "sleep 30" }

  provisioner "local-exec" { command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key ${var.ssh_private_key} ansible/playbook.yml" }

  provisioner "local-exec" { command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key ${var.ssh_private_key} tig/telegraf.yml" }


}

resource "aws_instance" "mysql" {
  ami                         = "ami-0e9bfdb247cc8de84"
  instance_type               = "t2.micro"
  key_name                    = "seoul_aws"
  vpc_security_group_ids      = [aws_security_group.mysql-sg.id]
  associate_public_ip_address = true
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true

  }
  tags = {
    Name = "Mysql"
  }
  provisioner "local-exec" { command = "sleep 30" }

  provisioner "local-exec" { command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${aws_instance.mysql.public_ip},' --private-key ${var.ssh_private_key} docker_ansible/playbook.yml" }

  provisioner "local-exec" { command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key ${var.ssh_private_key} tig/telegraf.yml" }
  
#  provisioner "local-exec" { command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${aws_instance.mysql.public_ip},' --private-key ${var.ssh_private_key} mysql_advance/set_root_pass_slave.yml" }

}