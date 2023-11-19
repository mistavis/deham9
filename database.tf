# WIP

resource "aws_db_instance" "instance_db" {
  allocated_storage = 10
  availability_zone = data.aws_availability_zones.available.names[0]
  identifier        = "database"
  # db_name                = "database"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = "wordpress"
  password               = "password"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.sg_db_allow_ssh.id]

  provisioner "local-exec" {
    command = "echo DB instance = ${self.endpoint} >> metadata"
  }
}

# Be sure to use this when connecting to your DB from EC2
# sudo yum install mariadb
# use the writers instance endpoint
# mysql -h <endpoint> -P 3306 -u <mymasteruser> -p
# TODO 
# 1. Connect DB to EC2
# 2. Migrate Wordpress DB 