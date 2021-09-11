resource "aws_route53_zone" "recruit-rits" {
  name = "recruit-rits.net"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.recruit-rits.zone_id
  name    = "www.recruit-rits.net"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.recruit_ip.public_ip]
}