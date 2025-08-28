resource "aws_secretsmanager_secret" "db_password" {
  name = "DB_PASSWORD"
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = "YourSuperSecretPassword" # replace securely
}

resource "aws_secretsmanager_secret" "api_key" {
  name = "API_KEY"
}

resource "aws_secretsmanager_secret_version" "api_key" {
  secret_id     = aws_secretsmanager_secret.api_key.id
  secret_string = "YourAPIKeyHere"
}

