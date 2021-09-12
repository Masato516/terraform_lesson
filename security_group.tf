resource "aws_security_group" "sg_for_public_subnet" {
  name        = "sg_for_public_subnet"
  description = "This sg is for recruit web"
  vpc_id      = aws_vpc.recruit_web.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_for_recruit_web"
  }
}

resource "aws_security_group" "sg_for_db_subnet" {
  name        = "sg_for_db_subnet"
  description = "This sg is for db of recruit web"
  vpc_id      = aws_vpc.recruit_web.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.recruit_web.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_for_recruit_db"
  }
}