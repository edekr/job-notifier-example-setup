resource "aws_dynamodb_table" "jobs" {
  name           = "jobs"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
  stream_enabled = true
  stream_view_type = "NEW_IMAGE"
}