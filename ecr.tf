

#Create an ECR repository
resource "aws_ecr_repository" "worker" {
  name                 = "nginx"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}