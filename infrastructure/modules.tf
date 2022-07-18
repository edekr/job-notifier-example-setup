module "fetch_jobs" {
    source = "./fetch_jobs"

    job_table_name = aws_dynamodb_table.jobs.name
    role_arn = local.role_arn
}