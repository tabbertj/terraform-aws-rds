# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

variables {
  region      = "us-west-2"
  db_name     = "test-db"
  db_username = "admin"
  db_password = "password"
  publicly_accessible = "false"
}

  assert {
    condition     = aws_db_instance.demo.publicly_accessible == true
    error_message = "incorrect value for publicly_accessible"
  }

