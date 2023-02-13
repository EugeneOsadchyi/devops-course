resource "aws_db_instance" "default" {
  identifier             = "devops-course-rds"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t3.micro"
  username               = var.database_username
  password               = var.database_password
  db_subnet_group_name   = aws_db_subnet_group.private_subnets.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "private_subnets" {
  name       = "devops_course_rds"
  subnet_ids = var.subnet_ids

  tags = {
    "Name" = "DevOps Course RDS private subnet group"
  }
}

resource "aws_security_group" "rds" {
  name   = "devops_course_rds"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DevOps Course RDS"
  }
}
