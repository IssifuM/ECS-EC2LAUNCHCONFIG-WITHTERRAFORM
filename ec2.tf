# creating a server for eu-west-2 region

/* resource "aws_instance" "Test-server1" {
  ami                         = var.ami
  instance_type               = var.type
  iam_instance_profile        = aws_iam_instance_profile.ecs_agent.name
  key_name                    = "SisterMAariama"
  associate_public_ip_address = true
  availability_zone           = var.az1
  subnet_id                   = aws_subnet.Test-public-sub1.id
  vpc_security_group_ids      = [aws_security_group.ecs_sg.id]

  tags = {
    Name = "Test-server1"
  }
} */

#EC2 launch Config for ECS 
resource "aws_launch_configuration" "ecs_launch_config" {
  image_id             = "ami-00b01c5b2db6f02f7"
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  key_name             = "SisterMAariama"
  security_groups      = [aws_security_group.ecs_sg.id]
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=my-cluster >> /etc/ecs/ecs.config"
  instance_type        = "t2.micro"
}

#Creating AutoScalling
resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
  name                      = "asg"
  vpc_zone_identifier       = [aws_subnet.Test-public-sub1.id]
  launch_configuration      = aws_launch_configuration.ecs_launch_config.id
  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 10
  health_check_grace_period = 300
  health_check_type         = "EC2"
  tag {
    key                 = "Name"
    value               = "ECS-myecscluster"
    propagate_at_launch = true
  }
}
/* #attache ALB ( tweak this)
load_balancer {
    target_group_arn = aws_alb_target_group.myapp-tg.arn
    container_name   = "testapp"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.testapp, aws_iam_role_policy_attachment.ecs_task_execution_role] */

