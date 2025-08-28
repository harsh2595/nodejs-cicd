# IAM User for GitHub Actions
resource "aws_iam_user" "ci_cd_user" {
  name = "ci-cd-github-actions"
}

# IAM Policy for GitHub Actions CI/CD
resource "aws_iam_policy" "ci_cd_policy" {
  name        = "ci-cd-ecs-policy"
  description = "Permissions for GitHub Actions to deploy ECS Blue/Green"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ecr:*",
          "ecs:*",
          "codedeploy:*",
          "cloudwatch:*",
          "logs:*",
          "s3:*",
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "ci_cd_attach" {
  user       = aws_iam_user.ci_cd_user.name
  policy_arn = aws_iam_policy.ci_cd_policy.arn
}

# Access keys for GitHub Actions
resource "aws_iam_access_key" "ci_cd_key" {
  user = aws_iam_user.ci_cd_user.name
}

# Outputs
output "ci_cd_access_key" {
  value     = aws_iam_access_key.ci_cd_key.id
  sensitive = true
}

output "ci_cd_secret_key" {
  value     = aws_iam_access_key.ci_cd_key.secret
  sensitive = true
}

