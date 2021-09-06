resource "aws_internet_gateway" "recruit_igw" {
  vpc_id = aws_vpc.recruit_web.id

  tags = {
    Name = "recruit_igw"
  }
}