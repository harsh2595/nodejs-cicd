# CodeDeploy Application
resource "aws_codedeploy_app" "ecs_app" {
  name = "ecs-bluegreen-app"
  compute_platform = "ECS"
}

# Deployment Group
resource "aws_codedeploy_deployment_group" "ecs_deploy_group" {
  app_name              = aws_codedeploy_app.ecs_app.name
  deployment_group_name = "ecs-bluegreen-deploy"
  service_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
    terminate_blue_instances_on_deployment_success {
      action = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.main.name
    service_name = aws_ecs_service.main.name
  }

  load_balancer_info {
    target_group_pair_info {
      target_groups {
        name = aws_lb_target_group.blue.name
      }
    }
  }
}

