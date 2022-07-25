resource "aws_lambda_function" "new_job_notifier" {

  filename      = "build/new_job_notifier.zip"
  function_name = "new_job_notifier"
  role          = local.role_arn
  handler       = "job_notifier.handler"


  source_code_hash = filebase64sha256("build/new_job_notifier.zip")

  runtime = "python3.9"
  timeout = 120

    environment {
    variables = {
      SNS_TOPIC = aws_sns_topic.job_notifier.arn
    }
  }
}

resource "aws_lambda_event_source_mapping" "job_trigger" {
  event_source_arn  = aws_dynamodb_table.jobs.stream_arn
  function_name     = aws_lambda_function.new_job_notifier.arn
  starting_position = "LATEST"
}

resource "aws_sns_topic" "job_notifier" {
  name = "job-notifier-topic"
}

resource "aws_sns_topic_subscription" "email_target" {
  topic_arn = aws_sns_topic.job_notifier.arn
  protocol = "email"
  endpoint = "fischeneue+jobnotifier@gmail.com"
}