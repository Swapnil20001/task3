data "aws_subnet_ids" "example" {
  vpc_id = "vpc-038cda520c095e939"
}

data "aws_subnet" "main" {
  for_each = data.aws_subnet_ids.example.ids
  id       = each.value
}


data "aws_availability_zones" "available" {
  state = "available"
}