resource "aws_db_parameter_group" "recruit-pg" {
  name        = "rds-pg"
  family      = "mysql8.0"
  description = "This parameter group is for RDS of recruit-web"

  parameter {
    name  = "time_zone"
    value = "Asia/Tokyo"
  }
  parameter {
    name  = "Slow_query_log"
    value = 1
  }
  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_filesystem"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}