resource "aws_s3_bucket" "recruit_bucket" {
  bucket = "bucket.ritsrecruit.net"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "HEAD", "DELETE"]
    allowed_origins = ["https://www.${var.domain}"]
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

# S3を操作するためのIAMユーザー
resource "aws_iam_user" "s3_user" {
  name = "s3-user"
}

# S3のfull access権限を持つポリシーをIAMユーザーにアタッチ
resource "aws_iam_user_policy" "s3" {
  name   = "s3_policy"
  user   = aws_iam_user.s3_user.name
  policy = data.aws_iam_policy_document.s3_full_access_policy.json
}

# S3のIAM access key を作成
resource "aws_iam_access_key" "s3" {
  user = aws_iam_user.s3_user.name
}

# S3のfull access権限のポリシーデータを取得
data "aws_iam_policy_document" "s3_full_access_policy" {
  statement {
    actions   = ["s3:*"]
    resources = ["*"]
    effect = "Allow"
  }
}

# IAM access key を出力
output "aws_iam_s3_access_key" {
  value     = aws_iam_access_key.s3.id
  sensitive = true
}
# IAM secret access key を出力
output "aws_s3_iam_secret" {
  value     = aws_iam_access_key.s3.secret
  sensitive = true
}