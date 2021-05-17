provider "aws" {
    access_key = "*****************"
    secret_key = "*****************"
    region     = "us-east-1"
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "mylogbucketdos"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "b" {
  bucket = "mybucketwebsitesdos01"
  acl    = "public-read"
  policy = file("policy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}


resource "aws_s3_bucket_object" "object" {
  bucket = "mybucketwebsitesdos01"
  key    = "index.html"
#   source = "./index.html"
#   etag = filemd5("./index.html")
}