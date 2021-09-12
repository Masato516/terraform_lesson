resource "aws_s3_bucket" "recruit_bucket" {
  bucket = "bucket.ritsrecruit.net"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "HEAD", "DELETE"]
    allowed_origins = ["https://www.ritsrecruit.link"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_public_access_block" "recruit_access_bucket" {
  bucket = aws_s3_bucket.recruit_bucket.id

  # Block public access (bucket settings)
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}