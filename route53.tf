resource "aws_route53_zone" "recruit_zone" {
  name = "ritsrecruit.link"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.recruit_zone.zone_id
  name    = "www.ritsrecruit.link"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.recruit_ip.public_ip]
}