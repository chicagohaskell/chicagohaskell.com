provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "www" {
  bucket = "www.chicagohaskell.com"
  policy = "${file("policy.json")}"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "apex" {
  bucket = "chicagohaskell.com"

  website {
    redirect_all_requests_to = "${aws_s3_bucket.www.id}"
  }
}

resource "aws_route53_zone" "primary" {
  name = "${aws_s3_bucket.apex.id}"
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name = "${aws_s3_bucket.www.id}"
  type = "A"

  alias {
    name = "${aws_s3_bucket.www.website_domain}"
    zone_id = "${aws_s3_bucket.www.hosted_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = "${aws_s3_bucket.www.id}"
  key = "index.html"
  source = "index.html"
  content_type = "text/html"
  etag = "${md5(file("index.html"))}"
}

resource "aws_s3_bucket_object" "style" {
  bucket = "${aws_s3_bucket.www.id}"
  key = "assets/css/style.css"
  source = "assets/css/style.css"
  content_type = "text/css"
  etag = "${md5(file("assets/css/style.css"))}"
}

resource "aws_s3_bucket_object" "header" {
  bucket = "${aws_s3_bucket.www.id}"
  key = "assets/img/Chicago_tilt-shift.jpg"
  source = "assets/img/Chicago_tilt-shift.jpg"
  content_type = "image/jpg"
  etag = "${md5(file("assets/img/Chicago_tilt-shift.jpg"))}"
}

resource "aws_s3_bucket_object" "watermark" {
  bucket = "${aws_s3_bucket.www.id}"
  key = "assets/img/chicago-haskell-watermark.png"
  source = "assets/img/chicago-haskell-watermark.png"
  content_type = "image/png"
  etag = "${md5(file("assets/img/chicago-haskell-watermark.png"))}"
}

resource "aws_s3_bucket_object" "map" {
  bucket = "${aws_s3_bucket.www.id}"
  key = "assets/img/pivotal-map.png"
  source = "assets/img/pivotal-map.png"
  content_type = "image/png"
  etag = "${md5(file("assets/img/pivotal-map.png"))}"
}
