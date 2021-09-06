resource "aws_db_instance" "recruit_db" {
  identifier             = "recruit-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0.23"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = "foobarbaz"
  db_subnet_group_name   = aws_db_subnet_group.db-subnet.name
  vpc_security_group_ids = [aws_security_group.sg_for_db_subnet.id]
  parameter_group_name   = aws_db_parameter_group.recruit-pg.name
  multi_az               = false
  skip_final_snapshot    = true # DB削除時にスナップショットを残す
  # final_snapshot_identifier = "recruit-db-snapshot"
}