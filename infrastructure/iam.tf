#######################-Create IAM Role-#######################
resource "aws_iam_role" "cloud_storage_iam_role_1" {
  name = "${var.project}-SSMRole-1"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#######################-Add S3 Permission-#######################
resource "aws_iam_role_policy_attachment" "cloud_storage_S3_policy" {
  role       = aws_iam_role.cloud_storage_iam_role_1.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

#######################--Create IAM Instance Profile-#######################-
resource "aws_iam_instance_profile" "e_instance_profile_1" {
  name = "cloud_storage-SSMInstanceProfile1"
  role = aws_iam_role.cloud_storage_iam_role_1.name
}

#######################-Create IAM Role-#######################
resource "aws_iam_role" "cloud_storage_iam_role_2" {
  name = "${var.project}-SSMRole-2"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#######################-Add SSM Permission-#######################
resource "aws_iam_role_policy_attachment" "cloud_storage_SSM_policy" {
  role       = aws_iam_role.cloud_storage_iam_role_2.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

#######################-Add S3 Permission-#######################
resource "aws_iam_role_policy_attachment" "cloud_storage_S3_policy_2" {
  role       = aws_iam_role.cloud_storage_iam_role_2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

#######################--Create IAM Instance Profile-#######################-
resource "aws_iam_instance_profile" "e_instance_profile_2" {
  name = "cloud_storage-SSMInstanceProfile2"
  role = aws_iam_role.cloud_storage_iam_role_2.name
}