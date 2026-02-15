resource "aws_route53_record" "lb" {
  zone_id = var.zone_id
  name    = "${var.env}.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [var.lb_ip]
}
