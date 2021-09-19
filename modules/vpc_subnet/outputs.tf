output "vpc_id" {
  value = aws_vpc.recruit_web.id
}

output "public_subnet_id" {
  value = aws_subnet.recruit_web_1c.id
}

output "private_subnet_1c_id" {
  value = aws_subnet.recruit_web_db_1c.id
}

output "private_subnet_1d_id" {
  value = aws_subnet.recruit_web_private_1d.id
}
