resource "aws_ami_from_instance" "wordpress" {
  name                    = "ami-wordpress"
  source_instance_id      = aws_instance.wordpress.id
  snapshot_without_reboot = true
}
