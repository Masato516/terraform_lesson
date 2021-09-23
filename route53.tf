resource "aws_route53_zone" "recruit_zone" {
  name = var.domain
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.recruit_zone.zone_id
  name    = "www.${var.domain}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.recruit_web_server.public_ip]
}
