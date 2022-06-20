##ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "myecscluster"
}

#Terraform template_file definition. this comes json.tpl file. THe JSON file that is kept separately

data "template_file" "task_definition_template" {
  template = file("task_definition.json.tpl")
  vars = {
    REPOSITORY_URL = replace(aws_ecr_repository.worker.repository_url, "https://", "")
  }
}

#task definition
resource "aws_ecs_task_definition" "task_definition" {
  family                = "worker"
  container_definitions = data.template_file.task_definition_template.rendered
}

#ecs service
resource "aws_ecs_service" "worker" {
  name            = "worker"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 2
}









