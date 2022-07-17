import requests
import boto3

JOB_API_URL = 'https://www.arbeitnow.com/api/job-board-api'
job_table_name = "jobs"

dynamodb_resource = boto3.resource("dynamodb")
job_table = dynamodb_resource.Table(job_table_name)

def load_job_data():
    print("start loading job data")
    response = requests.get(JOB_API_URL)
    return response.json()

def map_job_data(job_api_data):
    result = []

    for job_item in job_api_data:
        result.append({
            "id": job_item["slug"],
            "title": job_item["title"],
            "description": job_item["description"],
            "companyName": job_item["company_name"]
        })
    return result

def save_job_data(jobs):
    for job in jobs:
        job_table.put_item(Item = job)

def handle(event, context):
    job_api_data = load_job_data()
    mapped_data = map_job_data(job_api_data)
    save_job_data(mapped_data)


if __name__ == "__main__":
    handle({},{})