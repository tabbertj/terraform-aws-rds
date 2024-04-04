# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

variables {
  region      = "us-west-2"
  db_name     = "test-db"
  db_username = "admin"
  db_password = "password"
  publicly_accessible = "false"
}

run "attributes_validation" {
  assert {
    condition     = aws_db_instance.demo.identifier == "test-db-${random_pet.random.id}"
    error_message = "incorrect value for identifier"
  }

  assert {
    condition     = aws_db_instance.demo.instance_class == "db.t3.micro"
    error_message = "incorrect value for instance_class"
  }

  assert {
    condition     = aws_db_instance.demo.allocated_storage == 5
    error_message = "incorrect value for allocated_storage"
  }

  assert {
    condition     = aws_db_instance.demo.engine == "postgres"
    error_message = "incorrect value for engine"
  }

  assert {
    condition     = aws_db_instance.demo.engine_version == "14"
    error_message = "incorrect value for engine_version"
  }

  assert {
    condition     = aws_db_instance.demo.username == "admin"
    error_message = "incorrect value for username"
  }

  assert {
    condition     = aws_db_instance.demo.password == "password"
    error_message = "incorrect value for password"
  }

  assert {
    condition     = aws_db_instance.demo.db_subnet_group_name == aws_db_subnet_group.demo.name
    error_message = "incorrect value for db_subnet_group_name"
  }

  assert {
    condition     = aws_db_instance.demo.vpc_security_group_ids == [aws_security_group.rds.id]
    error_message = "incorrect value for vpc_security_group_ids"
  }

  assert {
    condition     = aws_db_instance.demo.parameter_group_name == aws_db_parameter_group.demo.name
    error_message = "incorrect value for parameter_group_name"
  }

  assert {
    condition     = aws_db_instance.demo.publicly_accessible == true
    error_message = "incorrect value for publicly_accessible"
  }

  assert {
    condition     = aws_db_instance.demo.skip_final_snapshot == true
    error_message = "incorrect value for skip_final_snapshot"
  }
}
