#######################-Create IAM Role-#######################
resource "aws_iam_role" "cloud_storage_iam_role_server" {
  name = "${var.project}-Role-MainServer"

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
  role       = aws_iam_role.cloud_storage_iam_role_server.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "cloud_storage_CWlogs" {
  role       = aws_iam_role.cloud_storage_iam_role_server.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "cloud_storage_CWagent" {
  role       = aws_iam_role.cloud_storage_iam_role_server.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentAdminPolicy"
}

#######################--Create IAM Instance Profile-#######################-
resource "aws_iam_instance_profile" "e_instance_profile_server" {
  name = "cloud_storage-profile-main-server"
  role = aws_iam_role.cloud_storage_iam_role_server.name
}

#######################-Create IAM Role-#######################
resource "aws_iam_role" "cloud_storage_iam_role_proxy" {
  name = "${var.project}-Role-BastionHost"

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
  role       = aws_iam_role.cloud_storage_iam_role_proxy.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

#######################-Add S3 Permission-#######################
resource "aws_iam_role_policy_attachment" "cloud_storage_S3_policy_2" {
  role       = aws_iam_role.cloud_storage_iam_role_proxy.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

#######################--Create IAM Instance Profile-#######################-
resource "aws_iam_instance_profile" "e_instance_profile_proxy" {
  name = "cloud_storage-profile-proxy-server"
  role = aws_iam_role.cloud_storage_iam_role_proxy.name
}