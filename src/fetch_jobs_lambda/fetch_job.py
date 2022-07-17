import requests

JOB_API_URL = 'https://www.arbeitnow.com/api/job-board-api'

def load_job_data():
    print("start loading job data")
    response = requests.get(JOB_API_URL)
    return response.json()

def handle(event, context):
    job_api_data = load_job_data()
    print(job_api_data)
    print("Map Data")
    print("Save Data")

if __name__ == "__main__":
    handle({},{})