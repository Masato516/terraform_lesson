resource "aws_instance" "sandbox" {
  ami           = "ami-09ebacdc178ae23b7" # Amazon Linux 2
  instance_type = "t2.micro"

  tags = {
    Name = "sandbox"
  }
}
