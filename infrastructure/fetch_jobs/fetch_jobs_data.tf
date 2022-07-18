resource "aws_lambda_function" "fetch_jobs_lambda" {

  filename      = "build/fetch_jobs_lambda.zip"
  function_name = "fetch_jobs_lambda"
  role          = var.role_arn
  handler       = "fetch_job.handle"


  source_code_hash = filebase64sha256("build/fetch_jobs_lambda.zip")

  runtime = "python3.9"
  timeout = 600
  layers = [ aws_lambda_layer_version.requests_layer.arn ]

  environment {
    variables = {
      JOB_TABLE_NAME = var.job_table_name
    }
  }
}