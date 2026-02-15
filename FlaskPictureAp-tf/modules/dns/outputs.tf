output "lb_domain" {
  value = aws_route53_record.lb.fqdn
}
