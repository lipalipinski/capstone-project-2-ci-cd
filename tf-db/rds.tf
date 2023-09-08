module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.1.1"

  identifier = "jlipinski-petclinic-db"

  db_subnet_group_name   = "petclinic-jlipinski"
  vpc_security_group_ids = [data.aws_security_groups.db-sg.ids[0]]
  skip_final_snapshot = true

  # tf can't remove an option group associated with snapshots
  create_db_option_group = false

  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class       = "db.t3.micro"

  allocated_storage = 20

  db_name  = "petclinic"
  username = var.db-username
  port     = 3306

  db_instance_tags = {
    Name = "rds_app_db"
  }
}
