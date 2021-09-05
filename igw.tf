resource "aws_internet_gateway" "igw_for_recruit_web" {
  vpc_id = aws_vpc.recruit_web.id

  tags = {
    Name = "igw_for_recruit_web"
  }
}