# Create IAM role
resource "aws_iam_role" "s3_full_access_role" {
  name = "S3FullAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the AWS managed S3 full access policy to the IAM role
resource "aws_iam_policy_attachment" "s3_full_access_policy_attachment" {
  name       = "S3FullAccessPolicyAttachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  roles      = [aws_iam_role.s3_full_access_role.name]
}

# Create an IAM instance profile
resource "aws_iam_instance_profile" "s3_full_access_instance_profile" {
  name = "S3FullAccessInstanceProfile"
  role = aws_iam_role.s3_full_access_role.name
}