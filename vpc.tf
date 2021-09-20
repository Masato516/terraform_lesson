# 全体のVPC
resource "aws_vpc" "recruit_web" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc_for_recruit_web"
  }
}

# WEBサーバーを置くためののサブネット
resource "aws_subnet" "recruit_web_1c" {
  vpc_id            = aws_vpc.recruit_web.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "public_subnet_for_recruit_web"
  }
}

# DBを置くためのサブネット
resource "aws_subnet" "recruit_web_db_1c" {
  vpc_id            = aws_vpc.recruit_web.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "private_subnet_for_db"
  }
}

# マルチAZ構成用(マルチAZ構成にしなくてもDBインスタンスを立てるために必要)
resource "aws_subnet" "recruit_web_private_1d" {
  vpc_id            = aws_vpc.recruit_web.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "private_subnet_for_multi_AZ"
  }
}

# DB作成のためのサブネットグループ
resource "aws_db_subnet_group" "db-subnet" {
  name        = "test-db-subnet"
  description = "This subnet-group is for test db subnet"
  subnet_ids  = [aws_subnet.recruit_web_db_1c.id, aws_subnet.recruit_web_private_1d.id]

  tags = {
    Name = "DB subnet group"
  }
}

resource "aws_eip" "recruit_web_eip" {
  instance = aws_instance.recruit_web_server.id
  vpc      = true

  tags = {
    Name = "recruit_web_eip"
  }
}

# 割り当てられたIPアドレスを出力
output "elastic_ip" {
  value       = aws_eip.recruit_web_eip.public_ip
  description = "The public IP address of the main server instance."
}