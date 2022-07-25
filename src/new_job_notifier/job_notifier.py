from email.message import Message
import boto3
import os
client = boto3.client('sns')
sns_topic_arn = os.environ["SNS_TOPIC"]

def send_mail(newImage):
    client.publish(TopicArn = sns_topic_arn,
    Subject = "New AWS Job: " + newImage["title"]["S"],
    Message = "New AWS Job: " + newImage["title"]["S"] + 
    " Description: " + newImage["description"]["S"]
    )

def process_record(record):
    if record["eventName"] != "INSERT" and record["eventName"] != "MODIFY":
        return 

    newImage = record["dynamodb"]["NewImage"]
    if "title" in newImage and "AWS" in newImage["title"]["S"].upper():
        send_mail(newImage)
        return
    if "description" in newImage and "AWS" in newImage["description"]["S"].upper():
        send_mail(newImage)




def handler(event, context):
    for record in event["Records"]:
        process_record(record)
