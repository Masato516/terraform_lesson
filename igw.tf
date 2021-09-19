resource "aws_internet_gateway" "recruit_igw" {
  vpc_id = module.vpc_subnet_1.vpc_id

  tags = {
    Name = "recruit_igw"
  }
}
