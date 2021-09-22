# MEMO: とりあえず、現時点では必要ない？
# resource "aws_ses_domain_mail_from" "example" {
#   domain           = aws_ses_domain_identity.recruit_ses.domain
#   mail_from_domain = "bounce.${aws_ses_domain_identity.recruit_ses.domain}"
# }

# SESにドメインを登録？？
resource "aws_ses_domain_identity" "recruit_ses" {
  domain = var.domain
}

# TODO: メールアドレスの検証もコード化できないかチェック
#       とりあえず、手動で検証をおこなう
resource "aws_ses_domain_identity_verification" "recruit_verification" {
  domain = aws_ses_domain_identity.recruit_ses.id

  depends_on = [aws_route53_record.www]
}

# DKIM tokensの生成
resource "aws_ses_domain_dkim" "example" {
  domain = aws_ses_domain_identity.recruit_ses.domain
}

# SESでemailの送信権限をもたせるIAMユーザー
resource "aws_iam_user" "ses_smtp" {
  name = "ses-smtp-user"
}

# SESでemailを送信できるポリシーをIAMユーザーに付与
resource "aws_iam_user_policy" "ses_sender" {
  name   = "ses_policy"
  user   = aws_iam_user.ses_smtp.name
  policy = data.aws_iam_policy_document.ses_sender_policy.json
}

# SESのIAM access key を作成
resource "aws_iam_access_key" "ses_smtp_key" {
  user = aws_iam_user.ses_smtp.name
}

# emailを送信する権限を持つSESのポリシーデータを取得
data "aws_iam_policy_document" "ses_sender_policy" {
  statement {
    actions   = ["ses:SendEmail", "ses:SendRawEmail"]
    resources = ["*"]
    effect = "Allow"
  }
}

# IAM access key を出力
output "aws_iam_access_key" {
  value     = aws_iam_access_key.ses_smtp_key.id
  sensitive = true
}
# IAM secret access key を出力
output "aws_iam_secret" {
  value     = aws_iam_access_key.ses_smtp_key.secret
  sensitive = true
}
# MEMO: メールの送信ができなければ、外してみる
# output "aws_iam_smtp_password_v4" {
#   value     = aws_iam_access_key.ses_smtp_key.ses_smtp_password_v4
#   sensitive = true
# }