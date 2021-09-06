resource "aws_s3_bucket" "recruit-bucket-2" {
  bucket = "bucket.recruit-rits-2.net"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "HEAD", "DELETE"]
    allowed_origins = ["https://www.recruit-rits.net"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_public_access_block" "recruit-bucket-access-bucket" {
  bucket = aws_s3_bucket.recruit-bucket-2.id

  # Block public access (bucket settings)
  block_public_acls   = true
  ignore_public_acls  = true
  block_public_policy = true
  restrict_public_buckets = true
}