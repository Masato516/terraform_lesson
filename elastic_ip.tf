resource "aws_eip" "recruit_ip" {
  instance = aws_instance.recruit_web_server.id
  vpc      = true

  tags = {
    Name = "recruit_ip"
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