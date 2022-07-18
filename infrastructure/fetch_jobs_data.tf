resource "aws_lambda_function" "fetch_jobs_lambda" {

  filename      = "build/fetch_jobs_lambda.zip"
  function_name = "fetch_jobs_lambda"
  role          = "arn:aws:iam::902499571432:role/LabRole"
  handler       = "fetch_job.handle"


  source_code_hash = filebase64sha256("build/fetch_jobs_lambda.zip")

  runtime = "python3.9"
  timeout = 600
  layers = [ aws_lambda_layer_version.requests_layer.arn ]
}

resource "aws_lambda_layer_version" "requests_layer" {
  filename   = "build/requests_layer.zip"
  layer_name = "requests_layer"

  compatible_runtimes = ["python3.9"]
}

resource "aws_cloudwatch_event_rule" "every_five_minutes" {
    name = "every-five-minutes"
    description = "Fires every five minutes"
    schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "fetch_jobs_event" {
    rule = aws_cloudwatch_event_rule.every_five_minutes.name
    target_id = "fetch_jobs_event"
    arn = aws_lambda_function.fetch_jobs_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_fetch_jobs_lambda" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.fetch_jobs_lambda.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.every_five_minutes.arn
}