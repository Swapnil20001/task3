resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.mysql.id
  allocation_id = "eipalloc-07bd0d421c01a780f"
}