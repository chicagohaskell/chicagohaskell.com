resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = "${aws_s3_bucket.www.id}.s3.amazonaws.com"
    origin_id   = "S3-${aws_s3_bucket.www.id}"
  }

  enabled             = true
  default_root_object = "index.html"
  price_class = "PriceClass_100"

  aliases = ["${aws_s3_bucket.www.id}", "*.${aws_s3_bucket.www.id}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.www.id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    compress = true
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "cdn_domain_name" {
  value = "${aws_cloudfront_distribution.cdn.domain_name}"
}

output "cdn_zone_id" {
  value = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
}
