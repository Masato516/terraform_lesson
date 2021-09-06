# IGWへのルーティング
resource "aws_route" "route_recruit_igw" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.recruit_igw.id
  depends_on             = [aws_route_table.public_rt]
}

# ルートテーブルの作成
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.recruit_web.id

  tags = {
    Name = "recruit_public_rt"
  }
}

# ルートテーブルの関連付け
resource "aws_route_table_association" "recruit_public_rt" {
  subnet_id      = aws_subnet.recruit_web_1c.id
  route_table_id = aws_route_table.public_rt.id
}