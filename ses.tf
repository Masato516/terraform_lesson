# SESにドメインを登録？？
resource "aws_ses_domain_identity" "recruit_ses" {
  domain   = var.domain
  provider = aws
}

# DKIM tokensの生成
resource "aws_ses_domain_dkim" "recruit_dkim" {
  domain = aws_ses_domain_identity.recruit_ses.domain
}

# CNAMEレコードをホストゾーンに登録
# To verify ownership of this identity, 
# DKIM must be configured in the domain's DNS settings using the CNAME records provided.
resource "aws_route53_record" "recruit_cname_record" {
  count   = 3
  zone_id = aws_route53_zone.recruit_zone.zone_id
  name    = "${element(aws_ses_domain_dkim.recruit_dkim.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.recruit_dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

# MEMO: CNAMEレコードの設定だけで十分だと思われる(DKIMベース)
# TXTレコードをホストゾーンに登録
# resource "aws_route53_record" "recruit_amazonses_verification_record" {
#   zone_id = aws_route53_zone.recruit_zone.zone_id
#   name    = "_amazonses.${aws_ses_domain_identity.recruit_ses.id}"
#   type    = "TXT"
#   ttl     = "600"
#   records = [aws_ses_domain_identity.recruit_ses.verification_token]
# }

# MEMO: 毎回、実行しなくてもよい？？
# ドメインの検証を実施
# resource "aws_ses_domain_identity_verification" "recruit_verification" {
#   domain = aws_ses_domain_identity.recruit_ses.id

#   depends_on = [aws_route53_record.recruit_amazonses_verification_record]
# }

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