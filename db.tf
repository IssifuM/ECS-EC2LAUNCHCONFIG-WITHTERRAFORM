#Creating a Database
#subnets for database
resource "aws_db_subnet_group" "mysql-subnet-group" {
  name       = "mysql-subnet-group"
  subnet_ids = [aws_subnet.Test-public-sub1.id, aws_subnet.test-public-sub2.id]
}

#creating MySQL database
resource "aws_db_instance" "mysql" {
  identifier                = "mysql"
  allocated_storage         = 5
  backup_retention_period   = 2
  backup_window             = "01:00-01:30"
  maintenance_window        = "sun:03:00-sun:03:30"
  multi_az                  = true
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  name                      = "worker_db"
  username                  = "worker"          # i have to another one
  password                  = "ToptoBottom123$" # i have to another one
  port                      = "3306"
  db_subnet_group_name      = aws_db_subnet_group.mysql-subnet-group.name
  vpc_security_group_ids    = [aws_security_group.rds_sg.id, aws_security_group.ecs_sg.id]
  skip_final_snapshot       = true
  final_snapshot_identifier = "worker-final"
  publicly_accessible       = true
}
