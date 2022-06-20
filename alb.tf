#
#target group for ALB
resource "aws_alb_target_group" "test" {
  name     = "my-alb-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Prod_rock_VPC.id
}

#ALB
resource "aws_alb" "main" {
  name            = "my-alb-ecs"
  subnets         = [aws_subnet.Test-public-sub1.id, aws_subnet.test-public-sub2.id]
  security_groups = [aws_security_group.rds_sg.id, aws_security_group.ecs_sg.id]
}

#ALB Listener
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.test.arn
    type             = "forward"
  }
}