# resource "aws_route53_zone" "primary" {
#   name = "${aws_s3_bucket.apex.id}"
# }

# resource "aws_route53_record" "www" {
#   zone_id = "${aws_route53_zone.primary.zone_id}"
#   name = "${aws_s3_bucket.www.id}"
#   type = "A"

#   alias {
#     name = "${aws_cloudfront_distribution.cdn.domain_name}"
#     zone_id = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
#     evaluate_target_health = true
#   }
# }
