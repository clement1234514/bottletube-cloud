resource "aws_s3_bucket" "bottletube" {
  bucket = "bottletube-images-${random_id.suffix.hex}"
}
