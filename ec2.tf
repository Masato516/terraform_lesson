resource "aws_instance" "recruit_web_server" {
  ami           = "ami-09ebacdc178ae23b7" # Amazon Linux 2
  instance_type = "t2.micro"
  associate_public_ip_address = "true" # IPアドレスを割り当てる
  vpc_security_group_ids = [aws_security_group.sg_for_public_subnet.id]
  subnet_id     = aws_subnet.recruit_web_1c.id

  tags = {
    Name = "recruit_web_server"
  }
}

# 割り当てられたIPアドレスを出力
output "public_ip" {
  value       = aws_instance.recruit_web_server.public_ip
  description = "The public IP address of the main server instance."
}

output "public_dns" {
  value       = aws_instance.recruit_web_server.public_dns
  description = "The public dns of the main server instance."
}