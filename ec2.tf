resource "aws_instance" "recruit_web_server" {
  ami                         = "ami-09ebacdc178ae23b7" # Amazon Linux 2
  instance_type               = "t2.micro"
  associate_public_ip_address = "true" # IPアドレスを割り当てる
  vpc_security_group_ids      = [aws_security_group.sg_for_public_subnet.id]
  subnet_id                   = aws_subnet.recruit_web_1c.id
  key_name                    = aws_key_pair.auth.id # 利用する鍵

  user_data = file("./user_data.sh")

   # MEMO: user_dataへのmysql-devel追加によるreplaceを防ぐために以下を追加
  lifecycle {
    ignore_changes = [user_data]
  }

  tags = {
    Name = "recruit_web_server"
  }
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# 割り当てられたIPアドレスを出力
output "public_ip" {
  value       = aws_instance.recruit_web_server.public_ip
  description = "The public IP address of the main server instance."
}
