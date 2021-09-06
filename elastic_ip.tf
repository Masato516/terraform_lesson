resource "aws_eip" "recruit_ip" {
  instance = aws_instance.recruit_web_server.id
  vpc      = true
  
  tags = {
    Name = "recruit_ip"
  }
}