# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "nodejs-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "nodejs_task" {
  family                   = "nodejs-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "nodejs-container"
      image     = "your-dockerhub-or-ecr-image:latest"
      portMappings = [{ containerPort = 3000, hostPort = 3000, protocol = "tcp" }]
      environment = [{ name = "NODE_ENV", value = "production" }]
      secrets = [
        { name = "DB_PASSWORD", valueFrom = aws_secretsmanager_secret.db_password.arn },
        { name = "API_KEY", valueFrom = aws_secretsmanager_secret.api_key.arn }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/nodejs-app"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

# ECS Service (placeholder, will connect to ALB)
resource "aws_ecs_service" "main" {
  name            = "nodejs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nodejs_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public.id]
    assign_public_ip = true
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }
}

