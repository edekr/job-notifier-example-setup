resource "aws_lambda_function" "fetch_jobs_lambda" {

  filename      = "build/fetch_jobs_lambda.zip"
  function_name = "fetch_jobs_lambda"
  role          = "arn:aws:iam::018572766339:role/LabRole"
  handler       = "fetch_job.handle"


  source_code_hash = filebase64sha256("build/fetch_jobs_lambda.zip")

  runtime = "python3.9"
}