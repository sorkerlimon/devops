provider "aws" {
  region = "us-east-1"
}

# Create S3 Bucket
resource "aws_s3_bucket" "medi_archive_bucket" {
  bucket = "medi-archive-bucket"

  tags = {
    Name = "Medi Archive Bucket"
  }
}

# Reference the existing IAM user (no policy attachment needed)
data "aws_iam_user" "medi_archive" {
  user_name = "medi-archive"  # Existing IAM user
}

output "s3_bucket_name" {
  value = aws_s3_bucket.medi_archive_bucket.bucket
}
